class ApplicationController < ActionController::Base
  include ApplicationHelper
  include SessionsHelper
  include TeamsHelper

  before_action :logged_in?

  add_flash_types :success, :info, :warning, :error

  def initialize
    @board_members = Golfer.where(is_board_member: true).order(:last_name, :first_name)
    super() # NOTE: This *must* be called
  end
end
