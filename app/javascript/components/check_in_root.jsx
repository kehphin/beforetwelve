import React from 'react'
import GuestTable from './guest_table';
import UserTable from './user_table';
import DefaultCheckIn from './default_check_in';
import Modal from 'react-modal';

export default class CheckInRoot extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      checkedInUserName: '',
      checkedInGuestName: '',
      checkedInVenueName: '',
      checkedInMasterlist: false,
      checkedInPlusOne: false,
      showCheckInModal: false,

      venues: [],
    }

    $.get('/api/venues').done((data) => {
      this.setState({
        venues: Object.values(data),
      });
    });

    this.handleSearchDebounced = _.debounce(() => {
      this.searchDebounced.apply(this);
    }, this.state.debounce);
  }

  handleCheckIn(checkInHash) {
    const params = { data: checkInHash }

    $.post('/api/check_ins', params).done((data) => {
      this.setState({
        checkedInUserName: data.user_name,
        checkedInGuestName: data.guest_name,
        checkedInVenueName: data.venue_name,
        checkedInMasterlist: data.master_checkin,
        checkedInPlusOne: data.plusone_checkin,
        showCheckInModal: true,
      });
    });
  }

  closeModal(e) {
    e.preventDefault();
    this.setState({ showCheckInModal: false })
  }

  render() {
    return (
      <div>
        <DefaultCheckIn venues={this.state.venues} handleCheckIn={(e, attrs) => this.handleCheckIn(e, attrs)}/>

        <div className='checkin-tables-container'>
          <div className='checkin-table-container'>
            <h3>Host Check In</h3>
            <UserTable venues={this.state.venues} handleCheckIn={(e, attrs) => this.handleCheckIn(e, attrs)}/>
          </div>

          <div className='checkin-table-container'>
            <h3>Guest Check In</h3>
            <GuestTable venues={this.state.venues} handleCheckIn={(e, attrs) => this.handleCheckIn(e, attrs)}/>
          </div>
        </div>

        <Modal
          isOpen={this.state.showCheckInModal}
          contentLabel="Modal"
          style={{
            overlay: {
              backgroundColor: 'transparent'
            },
            content: {
              color: 'black',
              margin: 'auto',
              top: 0,
              left: 0,
              bottom: 0,
              right: 0,
              height: '200px',
              width: '300px'
            }
          }}
        >
          <h1>Checked In!</h1>
          <p>{this.state.checkedInGuestName || 'Guest'} checked into <b>{this.state.checkedInUserName || 'BeforeTwelve'}</b>'s guestlist to <b>{this.state.checkedInVenueName}</b> {this.state.checkedInPlusOne ? 'with a +1' : ''}</p>
          <button className='btn btn-primary' onClick={e => this.closeModal(e)}>Close</button>
        </Modal>
      </div>
    );
  }
}
