ActiveAdmin.register User do
  permit_params :is_admin

  config.sort_order = 'first_name_asc, last_name_asc'

  controller do
    def edit
      @page_title = "#{resource.first_name} #{resource.last_name}"
    end

    def show
      @page_title = "#{resource.first_name} #{resource.last_name}"
    end
  end

  form do |f|
    f.inputs "Admin Details" do
      f.input :is_admin, label: "Admin?"
    end
    f.actions
  end

end
