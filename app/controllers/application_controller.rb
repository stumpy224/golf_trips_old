class ApplicationController < ActionController::Base
  include ApplicationHelper
  include GoogleDriveHelper
  include SessionsHelper
  include TeamsHelper

  before_action :under_maintenance?, :logged_in?

  add_flash_types :success, :info, :warning, :error

  def initialize
    @board_members = Golfer.where(is_board_member: true).order(:last_name, :first_name)
    super() # NOTE: This *must* be called
  end
end
