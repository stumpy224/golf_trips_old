class ApplicationController < ActionController::Base
  include ApplicationHelper
  include SessionsHelper
  add_flash_types :success, :info, :warning, :error
end
