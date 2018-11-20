ActiveAdmin.register Golfer do
  permit_params :first_name, :last_name, :nickname, :email, :phone, :is_active

  config.sort_order = 'last_name_asc'

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
      f.input :first_name
      f.input :last_name
      f.input :nickname
      f.input :email
      f.input :phone
      f.input :is_active, label: 'Active?'
    end
    f.actions
  end

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
