module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = session.fetch("username", nil)
      reject_unauthorized_connection unless current_user
    end

    # By default we don't have access to the session object
    # https://edgeguides.rubyonrails.org/action_cable_overview.html#notes
    def session
      cookies.encrypted[Rails.application.config.session_options[:key]]
    end
  end
end
