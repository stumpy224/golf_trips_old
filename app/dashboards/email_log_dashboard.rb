require "administrate/base_dashboard"

class EmailLogDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    outing: Field::BelongsTo,
    golfer: Field::BelongsTo,
    id: Field::Number,
    template: Field::String,
    subject: Field::String,
    body: Field::String,
    sent_to: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :template,
    :subject,
    :sent_to,
    :created_at,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :template,
    :subject,
    :body,
    :sent_to,
    :created_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  # FORM_ATTRIBUTES = [
  #   :outing,
  #   :golfer,
  #   :template,
  #   :subject,
  #   :body,
  #   :sent_to,
  # ].freeze

  # Overwrite this method to customize how email logs are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(email_log)
  #   "EmailLog ##{email_log.id}"
  # end
end
