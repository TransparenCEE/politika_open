class PasswordMailer < ActionMailer::Base
  default from: "admin@politikaopen.sk"

  def reset_password(address, password)
    @password = password
    mail to: address, subject: 'Reset hesla'
  end
end
