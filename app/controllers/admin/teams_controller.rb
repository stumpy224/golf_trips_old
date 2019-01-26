module Admin
  class TeamsController < Admin::ApplicationController
    def create
      resource = resource_class.new(resource_params)
      authorize_resource(resource)

      if resource.save
        # if no Score records, create them
        if resource.scores.empty?
          resource.outing_golfer.outing.course.holes.each do |hole|
            Score.create(team_id: resource.id, hole_id: hole.id)
          end
        end

        redirect_to(
            [namespace, resource],
            notice: translate_with_resource("create.success"),
        )
      else
        render :new, locals: {
            page: Administrate::Page::Form.new(dashboard, resource),
        }
      end
    end

    def index
      search_term = params[:search].to_s.strip
      resources = Administrate::Search.new(scoped_resource,
                                           dashboard_class,
                                           search_term).run
      resources = apply_resource_includes(resources)

      resources = order.apply(resources)

      if params[:order]
        resources = order.apply(resources)
      else
        resources = resources.order("team_date desc", :team_number, :rank_letter)
      end

      resources = resources.page(params[:page]).per(records_per_page)
      page = Administrate::Page::Collection.new(dashboard, order: order)

      render locals: {
          resources: resources,
          search_term: search_term,
          page: page,
          show_search_bar: false,
          show_search_bar: show_search_bar?,
      }
    end

    def update
      total_points = 0
      team = Team.find(params[:id])

      params[:team][:scores].each do |score|
        par = score[:par].to_i
        strokes = score[:strokes].to_i
        points = get_points(par, strokes)
        Score.find(score[:id]).update(points: points, strokes: strokes) if !strokes.zero? && score_needs_updated?(team.scores, score)
        total_points += points
      end

      params[:team][:points_actual] = total_points
      params[:team][:points_plus_minus] = params[:team][:points_actual].to_i - params[:team][:points_expected].to_i
      team.update(team_params)

      flash[:notice] = "Team record for #{team.outing_golfer.golfer.full_name_with_nickname} has been updated"

      redirect_to admin_teams_path
    end

    def generate
      teams_by_date = get_teams_by_date_ordered_by_points(params[:id], params[:team_date])

      number_of_groups = (teams_by_date.size / 4.to_f).ceil

      # A players
      create_players(teams_by_date.first(number_of_groups), "A")

      # B players
      create_players(teams_by_date.slice(number_of_groups, number_of_groups).reverse, "B")

      # C players
      create_players(teams_by_date.slice(number_of_groups * 2, number_of_groups), "C")

      # D players
      create_players(teams_by_date.slice(number_of_groups * 3, (teams_by_date.size - number_of_groups * 3)).reverse, "D")

      flash[:notice] = "Teams generated for #{(params[:team_date].to_date + 1).strftime("%a %b %d, %Y")}"
    end

    def email_registered_users
      @admin_control_value = AdminControl.find_by_name("team_generation_emails").value

      case @admin_control_value
      when "OFF"
        render html: "<div>Team generation emails are turned off (see Admin Control for team_generation_emails).</div>".html_safe
      when "ON"
        users_notified = 0

        User.all.each do |user|
          golfer = Golfer.find_by_email(user.email)

          if !golfer.nil?
            today = params[:team_date]
            tomorrow = params[:team_date].to_date + 1
            golfers_team_placing = 0

            golfers_team_today = Team.joins(:outing_golfer).includes(:outing_golfer)
                              .where(team_date: today)
                              .where("outing_golfers.golfer_id = #{golfer.id}")
                              .first

            team_rankings = get_teams_ranking_by_date(params[:id], today)

            team_rankings.each.with_index do |team_rankings, index|
              golfers_team_placing = index + 1 if team_rankings.team_number == golfers_team_today.team_number
            end

            team_members_today = Team.where(team_date: today)
                                      .where(team_number: golfers_team_today.team_number)
                                      .order(:rank_letter)

            golfers_team_tomorrow = Team.joins(:outing_golfer).includes(:outing_golfer)
                              .where(team_date: tomorrow)
                              .where("outing_golfers.golfer_id = #{golfer.id}")
                              .first

            team_members_tomorrow = Team.where(team_date: tomorrow)
                                      .where(team_number: golfers_team_tomorrow.team_number)
                                      .order(:rank_letter)

            UserMailer.team_results_and_next_day_team(user, golfer, params[:id], golfers_team_placing, team_members_today, team_members_tomorrow).deliver_now

            users_notified += 1
          end

        end # end of User loop

        render html: "<div>#{users_notified} #{'email'.pluralize(users_notified)} sent</div>".html_safe
      end

    end

    private

    def team_params
      params.require(:team).permit(:outing_golfer_id, :team_number, :rank_number, :rank_letter, :points_expected, :points_actual, :points_plus_minus, :team_date, :scores)
    end

    def score_needs_updated?(existing_scores, score)
      !existing_scores.any? {|existing_score| existing_score.id == score[:id] && existing_score.strokes == score[:strokes]}
    end

    def create_players(players, rank_letter)
      players.each.with_index do |team, index|
        team.rank_letter = rank_letter
        team.rank_number = rank_letter == "B" || rank_letter == "D" ? (players.size - index) : (index + 1)
        team.team_number = index + 1

        create_team_for_tomorrow_and_scores(team)
      end
    end

    def create_team_for_tomorrow_and_scores(team)
      next_day_team = Team.create(outing_golfer_id: team.outing_golfer_id, team_number: team.team_number,
                                  rank_number: team.rank_number, rank_letter: team.rank_letter,
                                  points_expected: team.points_actual, team_date: team.team_date + 1)

      next_day_team.outing_golfer.outing.course.holes.each do |hole|
        Score.create(team_id: next_day_team.id, hole_id: hole.id)
      end
    end
  end
end
