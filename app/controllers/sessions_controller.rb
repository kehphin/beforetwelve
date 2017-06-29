class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => :create
  def new
    query_params = ''
    if !request.query_parameters.empty?
      query_params = '?' + request.query_parameters.to_query
    end

    redirect_to '/auth/facebook'
  end

  def create
    auth = request.env["omniauth.auth"]
    query_params = request.env['omniauth.params']
    # Find user with the steam uid OR create a new user with the uid.
    user = User.where(:uid => auth['uid'].to_s).first || User.create_with_omniauth(auth, query_params)
    reset_session
    session[:user_id] = user.id

    if user.setup_completed
      redirect_to '/dashboard'
    else
      redirect_to setup_path(:uid => auth['uid'])
    end
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
