require "administrate/base_dashboard"

class TeamDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
      outing_golfer: Field::BelongsTo.with_options(
          searchable: true,
          searchable_field: 'id'
      ),
      scores: Field::HasMany.with_options(
          limit: 18,
          sort_by: "hole_id"
      ),
      id: Field::Number,
      team_number: Field::Number,
      rank_number: Field::Number,
      rank_letter: Field::Select.with_options(
          collection: ["", "A", "B", "C", "D"],
          searchable: false
      ),
      points_expected: Field::Number,
      points_actual: Field::Number,
      points_plus_minus: Field::Number,
      team_date: DateField.with_options(
          searchable: true,
          searchable_field: 'team_date'
      ),
      created_at: Field::DateTime,
      updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
      :outing_golfer,
      :team_date,
      :team_number,
      :rank_number,
      :rank_letter,
      :points_expected,
      :points_actual,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
      :id,
      :outing_golfer,
      :team_date,
      :team_number,
      :rank_number,
      :rank_letter,
      :points_expected,
      :points_actual,
      :points_plus_minus,
      :created_at,
      :updated_at,
      :scores,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
      :outing_golfer,
      :team_date,
      :team_number,
      :rank_number,
      :rank_letter,
      :points_expected,
  ].freeze

  # Overwrite this method to customize how teams are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(team)
    "#{team.outing_golfer.golfer.first_name} #{team.outing_golfer.golfer.last_name}: Team #{team.team_number} on #{team.team_date}"
  end
end
