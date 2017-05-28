// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>GuestTable React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

class GuestTable extends React.Component {
  constructor(props) {
    super(props);
  }

  async handleSubmit(e) {
    const params = {
      organization: {
        name: 'weeee'
      },
    };

    try {
      const masterlistResult = await $.post('/api/masterlists', params)
    } catch (e) {
      console.log(e)
    }

    debugger;


    // $.post('/api/masterlists', params)
    //  .done((data) => {
    //     debugger;
    //     orgId = data.data.uuid;
    //     this.pollForInvitationLink(orgId);
    //   })
    //  .fail((xhr) => {
    //     if (xhr.status === 422) {
    //       this.setState({ creationState: 'user_already_exists' });
    //     } else {
    //       this.setState({
    //         creationState: 'failed',
    //         errorMessage: xhr.statusText,
    //       });
    //     }
    // });
  }

  render() {
    return (
       <div className='loan-table-container'>
    <table className="ui celled striped table">
      <thead>
        <tr>
          <th>First Name</th>
          <th>Last Name</th>
          <th>Checked In</th>
        </tr>
      </thead>
      <tbody>

      </tbody>
    </table>
    <button className='btn btn-primary' onClick={e => this.handleSubmit(e)}>Create!</button>
  </div>
    );
  }
}


document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <GuestTable name="React" />,
    document.body.appendChild(document.createElement('div')),
  )
})
