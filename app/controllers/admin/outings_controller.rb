module Admin
  class OutingsController < Admin::ApplicationController

    def create
      resource = resource_class.new(resource_params)
      authorize_resource(resource)

      if resource.save
        Golfer.where(is_active: true).order(:last_name).each do |golfer|
          outing_golfer = OutingGolfer.create(outing_id: resource.id, golfer_id: golfer.id)
          team = Team.create(outing_golfer_id: outing_golfer.id, team_date: resource.start_date)
          resource.course.holes.each do |hole|
            Score.create(team_id: team.id, hole_id: hole.id)
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
        resources = resources.order(start_date: :desc)
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
  end
end
