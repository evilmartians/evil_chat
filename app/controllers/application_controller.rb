class ApplicationController < ActionController::Base
  # That's all there is:
  prepend_view_path Rails.root.join("frontend")
end
