class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat"
  end

  # Called when message-form contents are received by the server
  def send_message(payload)
    message = Message.new(author: current_user, text: payload["message"])

    ActionCable.server.broadcast "chat", message: render(message) if message.save
  end

  private

  def render(message)
    ApplicationController.new.helpers.c("message", message: message)
  end
end
