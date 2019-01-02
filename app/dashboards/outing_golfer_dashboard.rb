require "administrate/base_dashboard"

class OutingGolferDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
      outing: Field::BelongsTo,
      golfer: Field::BelongsTo.with_options(
          order: "last_name"
      ),
      lodging: Field::BelongsTo,
      teams: Field::HasMany.with_options(
          limit: 100,
          sort_by: :team_date
      ),
      id: Field::Number,
      created_at: Field::DateTime,
      updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
      :outing,
      :golfer,
      :lodging,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
      :outing,
      :golfer,
      :lodging,
      :created_at,
      :updated_at,
      :teams,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
      :outing,
      :golfer,
      :lodging,
  ].freeze

  # Overwrite this method to customize how outing golfers are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(outing_golfer)
    "#{outing_golfer.golfer.full_name_with_nickname}"
  end
end
