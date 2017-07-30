import React from 'react';

export default class PayLessSignup extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      guestName: '',
      submitted: false,
    };
  }

  handleSignup(e) {
    const params = { name: this.state.guestName };

    $.post('/api/guests', params).done((data) => {
      this.setState({ submitted: true });
    });

  }

  handleInput(e) {
    const guestName = e.target.value;

    this.setState({
      guestName: guestName,
    });
  }

  render() {
    const buttonClass = 'ui primary button new-guest-button' + (this.state.submitted ? ' disabled' : '');
    const buttonText = this.state.submitted ? this.state.guestName + ' added to Guest List!' : 'Add to Guest List';

    return (
      <div>
        <input className='pay-less-signup' placeholder='ENTER YOUR FULL NAME...' value={this.state.guestName} onChange={e => this.handleInput(e)}></input>
        <a className={buttonClass} onClick={e => this.handleSignup(e)}>{buttonText}</a>
      </div>
    );
  }
}
