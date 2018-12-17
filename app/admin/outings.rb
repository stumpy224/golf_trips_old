ActiveAdmin.register Outing do
  permit_params :course_id, :name, :start_date, :end_date,
                attendees_attributes: [:id, :outing_id, :golfer_id, :attend_date, :team_number, :rank_number, :rank_letter, :points_expected, :points_actual, :_destroy]

  config.sort_order = 'created_at_desc'

  # by default, assign each active Golfer to the start_date of the newly created Outing
  after_create do |outing|
    Golfer.where(is_active: true).order(:last_name).each do |golfer|
      Attendee.create(outing_id: outing.id, golfer_id: golfer.id, attend_date: outing.start_date)
    end
  end

  form partial: 'form'

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

      table_for outing.attendees.order(attend_date: :desc) do
        column "Golfer" do |attendee|
          Golfer.find(attendee.golfer_id).full_name_with_nickname
        end

        column "Date Attending" do |attendee|
          # source => https://apidock.com/ruby/DateTime/strftime
          # "%a %b %d, %Y" => abbreviated weekday + abbreviated month + day of the month, + year with century
          # Fri Oct 5, 2018
          attendee.attend_date.strftime("%a %b %d, %Y")
        end

        column :team_number
        column :rank_number
        column :rank_letter
        column "Expected Points", :points_expected
        column "Actual Points", :points_actual
      end

      status_tag label: "#{outing.attendees.select(:golfer_id).distinct.count} total golfers"
    end
  end
end
