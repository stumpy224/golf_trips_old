class ApplicationMailer < ActionMailer::Base
  default from: "Golf Hacker Club <golfhackerclub@gmail.com>", bcc: "golfhackerclub@gmail.com"
  layout 'mailer'
end
