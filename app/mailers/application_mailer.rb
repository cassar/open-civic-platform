class ApplicationMailer < ActionMailer::Base
  default from: 'notifications@' + ENV['DOMAIN']
  layout 'mailer'
end
