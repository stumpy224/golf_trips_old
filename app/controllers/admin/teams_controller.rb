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
        resources = resources.order(:team_date, :team_number, :rank_letter)
      end

      resources = resources.page(params[:page]).per(records_per_page)
      page = Administrate::Page::Collection.new(dashboard, order: order)

      render locals: {
          resources: resources,
          search_term: search_term,
          page: page,
          show_search_bar: show_search_bar?,
      }
    end

    def update
      team = Team.find(params[:id])
      total_points = 0

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

    private

    def team_params
      params.require(:team).permit(:outing_golfer_id, :team_number, :rank_number, :rank_letter, :points_expected, :points_actual, :points_plus_minus, :team_date, :scores)
    end

    def score_needs_updated?(existing_scores, score)
      !existing_scores.any? { |existing_score| existing_score.id == score[:id] && existing_score.strokes == score[:strokes] }
    end
  end
end
