class NotificationMailer < ActionMailer::Base
  default from: "politikaopen_admin@fair-play.sk"
  
  def user_update(user, new_user = false)
    @user, @new_user = user, new_user
    mail to: Politikaopen::Application.config.notification_mailing_list, subject: "Aktualizacia pouzivatela"
  end
end
