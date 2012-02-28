class LoggingObserver
  def self.delivered_email(message)
    File.open(Rails.root.join('log', "mail.log"), 'a') do |f|
      f.puts '-------------------'
      f.puts "to: #{message.to}"
      f.puts "subject: #{message.subject}"
      f.puts message.body
      f.puts '-------------------'
      f.puts
    end
  end
end
