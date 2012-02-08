class PasswordMailer < ActionMailer::Base
  default from: "politikaopen_admin@fair-play.sk"
  
  def reset_password(address, password)
    @password = password
    mail to: address, subject: 'Reset hesla'
  end
end
