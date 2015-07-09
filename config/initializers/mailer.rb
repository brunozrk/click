Rails.env.on(:development) do
  config.action_mailer.default_url_options = { host: 'localhost:3000' }

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = { address: 'localhost', port: 1025 }
end

Rails.env.on(:test) do
  config.action_mailer.default_url_options = { host: 'localhost:3000' }
end

Rails.env.on(:production) do
  config.action_mailer.default_url_options = { host: 'http://www.clickhoras.com/' }

  ActionMailer::Base.smtp_settings = {
    address: 'smtp.sendgrid.net',
    port: '587',
    authentication: :plain,
    user_name: Rails.application.secrets.sendgrid_user_name,
    password: Rails.application.secrets.sendgrid_password,
    domain: 'sendgrid.me'
  }
end
