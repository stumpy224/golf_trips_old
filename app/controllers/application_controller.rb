class ApplicationController < ActionController::Base
  include ApplicationHelper
  include SessionsHelper
  include TeamsHelper

  add_flash_types :success, :info, :warning, :error
end
