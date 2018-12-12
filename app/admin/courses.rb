ActiveAdmin.register Course do
  permit_params :name, :address, :phone, :url,
                holes_attributes: [:id, :course_id, :number, :par, :handicap, :_destroy]

  after_create do |course|
    (1..18).each do |i|
      Hole.create(course_id: course.id, number: i, par: 4)
    end
  end

  config.sort_order = 'name_asc'

  form do |f|
    f.inputs do
      f.input :name
      f.input :address
      f.input :phone
      f.input :url

      f.inputs do
        f.has_many :holes,
                   heading: "Holes",
                   new_record: false do |h|
          # h.input :course_id, as: :select, collection: Course.select(:id, :name).order(:name)
          h.input :course_id, as: :hidden
          h.input :number
          h.input :par
          h.input :handicap
        end
      end
    end

    f.actions
  end

  show do
    attributes_table do
      row :name
      row :address
      row :phone
      row :url
      row :created_at
      row :updated_at
    end

    panel "Holes" do
      table_for course.holes do
        column :number
        column :par
        column :handicap
        column :created_at
        column :updated_at
      end
    end
  end
end
