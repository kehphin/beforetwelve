class SubmittedLoanMailer < ApplicationMailer
  def send_email(loan)
    mg_client = Mailgun::Client.new(ENV['EMAIL_API_KEY'])
    app_root = ENV['APP_ROOT']
    message_params = {
      :from    => ENV['EMAIL_SENDER_ADDRESS'],
      :to      => ENV['ADMIN_EMAIL_RECIPIENT'],
      :subject => '[Admin] CSGO Keybank Application Received',
      :html    => "Application Received from Steam user: #{loan.user.name} for #{loan.keys} keys! Log into the dashboard <a href='#{app_root}/signin'>here</a>"}
    mg_client.send_message ENV['EMAIL_DOMAIN'], message_params
  end
end
