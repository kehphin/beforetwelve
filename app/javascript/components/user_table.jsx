// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>GuestTable React</div> at the bottom
// of the page.

import React from 'react';
import PropTypes from 'prop-types';
import SearchInput from 'react-search-input';
import CheckInButton from './check_in_button';
import _ from 'underscore';

export default class UserTable extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      debounce: 300,
      searchTerm: '',
      users: [],
      checkedInUserName: '',
      checkedInVenueName: '',
      showCheckInModal: false,
    }

    this.handleSearchDebounced = _.debounce(() => {
      this.searchDebounced.apply(this);
    }, this.state.debounce);
  }

  searchDebounced() {
    $.get(`/api/users?term=${this.state.searchTerm}`).done((data) => {
      this.setState({
        users: Object.values(data),
      });
    });
  }

  searchUpdated(e) {
    const searchTerm = e.target.value;

    this.setState({
      searchTerm: searchTerm
    });

    if (searchTerm) this.handleSearchDebounced();
  }

  handleCheckIn(checkInHash) {
    this.setState({
      searchTerm: '',
      users: []
    });

    this.props.handleCheckIn(checkInHash)
  }

  render() {
    return (
      <div className='loan-table-container'>
        <input className="search-input" value={this.state.searchTerm} onChange={e => this.searchUpdated(e)}/>

        <table className="ui celled striped table checkin-user-table">
          <thead>
            <tr>
              <th className='name-header'>First Name</th>
              <th className='name-header'>Last Name</th>
              <th className='name-header'>Email</th>
              <th className='name-header'>Phone Number</th>

              {this.props.venues.map(venue => (
                <th className='venue-header' key={venue.id}>{venue.name}</th>
              ))}

            </tr>
          </thead>
          <tbody>
            {this.state.users.map(user => (
              <tr className='checkin-table-row' key={user.id}>
                <td><span>{user.first_name}</span></td>
                <td><span>{user.last_name}</span></td>
                <td><span>{user.email}</span></td>
                <td><span>{user.phone_number}</span></td>

                {this.props.venues.map(venue => (
                  <td className='button-table-item' key={venue.id}>
                    <CheckInButton userId={user.id} venueId={venue.id} masterCheckIn={false} plusOneCheckIn={false} handleCheckIn={(checkInHash) => this.handleCheckIn(checkInHash)}/>
                  </td>
                ))}

              </tr>
            ))}
          </tbody>
        </table>
      </div>
    );
  }
}
