require "administrate/base_dashboard"

class GolferDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    first_name: Field::String,
    last_name: Field::String.with_options(
      order: "last_name"
    ),
    nickname: Field::String,
    email: Field::String,
    phone: Field::String,
    is_active: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    is_registered: Field::Boolean,
    is_board_member: Field::Boolean,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :first_name,
    :last_name,
    :nickname,
    :email,
    :is_active,
    :is_registered,
    :is_board_member,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :first_name,
    :last_name,
    :nickname,
    :email,
    :phone,
    :is_active,
    :created_at,
    :updated_at,
    :is_registered,
    :is_board_member,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :first_name,
    :last_name,
    :nickname,
    :email,
    :phone,
    :is_active,
    :is_board_member,
    # :is_registered,
  ].freeze

  # Overwrite this method to customize how golfers are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(golfer)
    "#{golfer.full_name_with_nickname}"
  end
end
