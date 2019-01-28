class ApplicationMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper)
  add_template_helper(TeamsHelper)

  default from: "Golf Hacker Club <golfhackerclub@gmail.com>", bcc: "golfhackerclub@gmail.com"

  layout 'mailer'
end
