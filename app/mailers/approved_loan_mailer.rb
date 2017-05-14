class ApprovedLoanMailer < ApplicationMailer
  def send_email(loan)
    mg_client = Mailgun::Client.new(ENV['EMAIL_API_KEY'])
    message_params = {
      :from    => ENV['EMAIL_SENDER_ADDRESS'],
      :to      => loan.user.email,
      :subject => 'CSGO Keybank Application Approved!',
      :text    => "Congratulations! You've been approved for #{loan.keys} keys in exchange for a collateral of: #{loan.collateral}. Please add us on Steam via the Steam trade url: XXX in order to complete the transaction. Thanks!"}
    mg_client.send_message ENV['EMAIL_DOMAIN'], message_params
  end
end
