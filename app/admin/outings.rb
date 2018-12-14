ActiveAdmin.register Outing do
  permit_params :course_id, :name, :start_date, :end_date,
                attendees_attributes: [:id, :outing_id, :golfer_id, :attend_date, :_destroy]

  config.sort_order = 'created_at_desc'

  # by default, assign each active Golfer to the newly created Outing
  after_create do |outing|
    # loop through outing dates
    Golfer.where(is_active: true).each do |golfer|
      (outing.start_date..outing.end_date).each do |date|
        Attendee.create(outing_id: outing.id, golfer_id: golfer.id, attend_date: date)
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :course
      f.input :name
      f.input :start_date, as: :datepicker
      f.input :end_date, as: :datepicker

      f.inputs do
        f.has_many :attendees,
                   heading: "Attendees",
                   allow_destroy: true do |a|
          a.input :outing_id, as: :hidden
          a.input :golfer_id, as: :select, collection: Golfer.all.order(:last_name).map{ |g| ["#{g.full_name_with_nickname}", g.id] }
          a.input :attend_date, as: :datepicker
        end
      end
    end

    f.actions
  end

  show do
    attributes_table do
      row :course
      row :name
      row :start_date
      row :end_date
      row :created_at
      row :updated_at
    end

    panel "Attendees" do
      status_tag label: "#{outing.attendees.select(:golfer_id).distinct.count} total golfers"

      table_for outing.attendees do
        column "Golfer" do |attendee|
          Golfer.find(attendee.golfer_id).full_name_with_nickname
        end

        column "Attend Date" do |attendee|
          # source => https://apidock.com/ruby/DateTime/strftime
          # "%a %b %d, %Y" => abbreviated weekday + abbreviated month + day of the month, + year with century
          # Fri Oct 5, 2018
          attendee.attend_date.strftime("%a %b %d, %Y")
        end
      end

      status_tag label: "#{outing.attendees.select(:golfer_id).distinct.count} total golfers"
    end
  end
end
