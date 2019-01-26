# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/account_activation
  def account_activation
    user = User.first
    user.activation_token = User.new_token
    UserMailer.account_activation(user)
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/password_reset
  def password_reset
    user = User.first
    user.reset_token = User.new_token
    UserMailer.password_reset(user)
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/team_results_and_next_day_team
  def team_results_and_next_day_team
    golfer = Golfer.first
    golfers_team_placing = 3

    golfers_team_today = Team.joins(:outing_golfer).includes(:outing_golfer)
                                .where(team_date: "2018-05-20")
                                .where("outing_golfers.golfer_id = #{golfer.id}")
                                .first

    golfers_team_tomorrow = Team.joins(:outing_golfer).includes(:outing_golfer)
                                .where(team_date: "2018-05-21")
                                .where("outing_golfers.golfer_id = #{golfer.id}")
                                .first

    team_members_today = Team.where(team_date: golfers_team_today.team_date)
                             .where(team_number: golfers_team_today.team_number)
                             .order(:rank_letter)
    team_members_tomorrow = Team.where(team_date: golfers_team_tomorrow.team_date)
                             .where(team_number: golfers_team_tomorrow.team_number)
                             .order(:rank_letter)

    UserMailer.team_results_and_next_day_team(User.first, golfer, Outing.first.id, golfers_team_placing, team_members_today, team_members_tomorrow)
  end

end
