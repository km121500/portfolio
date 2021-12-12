class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  default from: '管理人だよ<from@gmail.com>'
  layout 'mailer'
end
