import { setCallback } from "client/chat";
import "components/message/message"; // message is nested, so we import it here
import "./messages.pcss";

const scrollToBottom = element => {
  // eslint-disable-next-line
  element.scrollTop = element.scrollHeight;
};

const messages = document.querySelector(".js-messages");

if (messages) {
  const content = messages.querySelector(".js-messages--content");

  scrollToBottom(content);

  // Telling `chat.js` to call this piece of code whenever a new message is received
  // over ActionCable
  setCallback(message => {
    content.insertAdjacentHTML("beforeend", message);

    scrollToBottom(content);
  });
}
