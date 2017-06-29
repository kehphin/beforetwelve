// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>GuestTable React</div> at the bottom
// of the page.

import React from 'react';
import PropTypes from 'prop-types';
import SearchInput from 'react-search-input';
import Modal from 'react-modal';
import CheckInButton from './check_in_button';
import _ from 'underscore';

export default class DefaultCheckIn extends React.Component {
  handleCheckIn(e, venueId) {
    e.preventDefault();

    this.props.handleCheckIn({
      user_id: null,
      guest_id: null,
      venue_id: venueId,
      master_checkin: true,
      plusone_checkin: false,
    });
  }

  render() {
    return (
      <div>
        {this.props.venues.map(venue => (
          <button key={venue.name} className='btn btn-primary default-checkin-button' onClick={(e) => this.handleCheckIn(e, venue.id)}><a className='fa fa-check'></a>MasterList - {venue.name}</button>
        ))}
      </div>
    );
  }
}
