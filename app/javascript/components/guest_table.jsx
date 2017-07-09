// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>GuestTable React</div> at the bottom
// of the page.

import React from 'react';
import PropTypes from 'prop-types';
import SearchInput from 'react-search-input';
import Modal from 'react-modal';
import CheckInButton from './check_in_button';
import _ from 'underscore';

export default class GuestTable extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      debounce: 300,
      searchTerm: '',
      guests: [],
    }

    this.handleSearchDebounced = _.debounce(() => {
      this.searchDebounced.apply(this);
    }, this.state.debounce);
  }

  searchDebounced() {
    $.get(`/api/guests?term=${this.state.searchTerm}`).done((data) => {
      this.setState({
        guests: Object.values(data),
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
      guests: []
    });

    this.props.handleCheckIn(checkInHash)
  }

  render() {
    return (
      <div className='loan-table-container'>
        <input className="search-input" value={this.state.searchTerm} onChange={e => this.searchUpdated(e)}/>

        <table className="ui celled striped table checkin-guest-table">
          <thead>
            <tr>
              <th className='name-header'>Name</th>
              <th className='plusone-header'>+1</th>

              {this.props.venues.map(venue => (
                <th className='venue-header' key={venue.id}>{venue.name}</th>
              ))}

            </tr>
          </thead>
          <tbody>
            {this.state.guests.map(guest => (
              <tr className='checkin-table-row' key={guest.id}>
                <td><span>{guest.name}</span></td>
                <td><span>{guest.plusone ? <i className="fa fa-check"></i> : <i className="fa fa-times"></i>}</span></td>

                {this.props.venues.map(venue => (
                  <td className='button-table-item' key={venue.id}>
                    <CheckInButton guestId={guest.id} venueId={venue.id} masterCheckIn={!guest.plusone} plusOneCheckIn={guest.plusone} handleCheckIn={(checkInHash) => this.handleCheckIn(checkInHash)}/>
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
