class UserMailer < ApplicationMailer

  SUBJECT_PREFIX = "Golf Hacker Club"

  def account_activation(user)
    @user = user
    @mail = mail(to: user.email, subject: "#{SUBJECT_PREFIX} Account Activation")
    EmailLog.create(template: __method__.to_s,
                    subject: @mail.subject,
                    body: @mail.html_part.body.decoded,
                    sent_to: @mail.to)
  end

  def password_reset(user)
    @user = user
    @mail = mail(to: user.email, subject: "#{SUBJECT_PREFIX} Password Reset")
    EmailLog.create(template: __method__.to_s,
                    subject: @mail.subject,
                    body: @mail.html_part.body.decoded,
                    sent_to: @mail.to)
  end

  def team_results_and_next_day_team(user, golfer, outing_id, golfers_team_placing, team_members_today, team_members_tomorrow)
    @outing_id = outing_id
    @golfers_team_placing = golfers_team_placing
    @team_members_today = team_members_today
    @team_members_tomorrow = team_members_tomorrow
    @mail = mail(to: user.email, subject: "#{SUBJECT_PREFIX} Results for #{team_members_today.first.team_date.strftime("%a %b %d, %Y")}")
    EmailLog.create(template: __method__.to_s,
                    subject: @mail.subject,
                    body: @mail.html_part.body.decoded,
                    sent_to: @mail.to,
                    outing_id: outing_id,
                    golfer_id: golfer.id)
  end
end
