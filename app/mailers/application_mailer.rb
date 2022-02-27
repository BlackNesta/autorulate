class ApplicationMailer < ActionMailer::Base
  default from: "noreply@autorulate.herokuapp.com"
  layout 'mailer'
end
