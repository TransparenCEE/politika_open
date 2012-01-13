class NotificationMailer < ActionMailer::Base
  default :from => "admin@politikaopen.sk"
  
  def user_update(user)
    @user = user
    mail to: Politikaopen::Application.config.notification_mailing_list, subject: "Aktualizacia pouzivatela"
  end
end
