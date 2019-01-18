module Admin
  class OutingGolfersController < Admin::ApplicationController
    def create
      resource = resource_class.new(resource_params)
      authorize_resource(resource)

      if resource.save
        outing = Outing.find(resource.outing_id)
        team = Team.create(outing_golfer_id: resource.id, team_date: outing.start_date)

        outing.course.holes.each do |hole|
          Score.create(team_id: team.id, hole_id: hole.id)
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
        resources = resources.joins(:outing, :golfer).order("outings.start_date desc", "golfers.last_name")
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
