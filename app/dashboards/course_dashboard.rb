require "administrate/base_dashboard"

class CourseDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
      id: Field::Number,
      name: Field::String,
      address: Field::String,
      phone: Field::String,
      url: Field::String,
      created_at: Field::DateTime,
      updated_at: Field::DateTime,
      holes: Field::HasMany.with_options(
          limit: 18,
          sort_by: :number
      ),
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
      :name,
      :address,
      :phone,
      :url,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
      :id,
      :name,
      :address,
      :phone,
      :url,
      :created_at,
      :updated_at,
      :holes,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
      :name,
      :address,
      :phone,
      :url,
  ].freeze

  # Overwrite this method to customize how courses are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(course)
    "#{course.name}"
  end
end
