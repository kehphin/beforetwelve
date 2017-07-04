import React from 'react'

export default class Social extends React.Component {
  shareFacebook(e) {
    FB.ui({
      method: 'feed',
      link: 'http://beforetwelve.club',
      caption: 'Use BeforeTwelve as your #1 Clubbing Promoter',
    }, function(response){});
  }

  render() {
    return (
      <div className='event-sharing'>
        <img className="fb-share-button" src="/fb_share.png" onClick={e => this.shareFacebook(e)}></img>
        <div>
          <a className="twitter-share-button"
            href="https://twitter.com/intent/tweet"
            data-size="large"
            data-text="Check out tonight's event, it's gonna be lit! - Your BeforeTwelve promoter"
            data-url="http://beforetwelve.club"
          >
            Tweet
          </a>
        </div>
      </div>
    );
  }
}
