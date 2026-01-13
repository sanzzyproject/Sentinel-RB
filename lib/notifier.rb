require 'net/smtp'
require 'net/http'
require 'json'
require 'uri'

class Notifier
  def initialize(config)
    @config = config
  end

  def send_alert(messages)
    return if messages.empty?

    full_message = "🚨 **SERVER ALERT** 🚨\n\n" + messages.join("\n")
    
    send_email(full_message) if @config['notifications']['enable_email']
    send_telegram(full_message) if @config['notifications']['enable_telegram']
  end

  private

  def send_email(body)
    email_conf = @config['email']
    msg = "Subject: Server Alert!\n\n#{body}"

    begin
      smtp = Net::SMTP.new(email_conf['server'], email_conf['port'])
      smtp.enable_starttls
      smtp.start('localhost', email_conf['user_name'], email_conf['password'], :login) do |s|
        s.send_message msg, email_conf['from'], email_conf['to']
      end
      puts "✅ Email sent successfully."
    rescue => e
      puts "❌ Failed to send email: #{e.message}"
    end
  end

  def send_telegram(body)
    tg_conf = @config['telegram']
    uri = URI("https://api.telegram.org/bot#{tg_conf['bot_token']}/sendMessage")
    
    params = { chat_id: tg_conf['chat_id'], text: body }
    
    begin
      res = Net::HTTP.post_form(uri, params)
      puts "✅ Telegram sent." if res.is_a?(Net::HTTPSuccess)
    rescue => e
      puts "❌ Failed to send Telegram: #{e.message}"
    end
  end
end
