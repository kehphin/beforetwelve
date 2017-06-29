import React from 'react'

export default class CheckInButton extends React.Component {
  handleCheckIn(e) {
    e.preventDefault();

    this.props.handleCheckIn({
      user_id: this.props.userId,
      guest_id: this.props.guestId,
      venue_id: this.props.venueId,
      master_checkin: this.props.masterCheckIn,
      plusone_checkin: this.props.plusOneCheckIn,
    });
  }

  render() {
    return (
      <button className='btn btn-primary' onClick={e => this.handleCheckIn(e)}><i className="fa fa-check-square-o"></i></button>
    );
  }
}
