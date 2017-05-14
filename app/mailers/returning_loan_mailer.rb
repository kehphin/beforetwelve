class ReturningLoanMailer < ApplicationMailer
  def send_email(loan)
    mg_client = Mailgun::Client.new(ENV['EMAIL_API_KEY'])
    message_params = {
      :from    => ENV['EMAIL_SENDER_ADDRESS'],
      :to      => ENV['ADMIN_EMAIL_RECIPIENT'],
      :subject => '[Admin] CSGO Keybank Loan Return',
      :text    => "Loan return request received from Steam user: #{loan.user.name} for #{loan.keys} keys! User's trade url is: #{loan.user.trade_url}"}
    mg_client.send_message ENV['EMAIL_DOMAIN'], message_params
  end
end
