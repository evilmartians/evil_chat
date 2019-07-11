/* eslint no-param-reassign: off */

import { sendMessage } from "client/chat";
import "./message-form.pcss";

const isMac = navigator.platform.match(/Mac/) != null;

const handleLineBreak = input => {
  input.value = `${input.value}\n`;
};

const handleSubmit = input => {
  const { value } = input;

  if (value.length === 0) {
    return;
  }

  // Invokes sendMessage, that, in turn, invokes Ruby send_message method
  // that will create a Message instance with ActiveRecord
  sendMessage(input.value);

  input.value = "";
  input.focus();
};

const form = document.querySelector(".js-message-form");

if (form) {
  const input = form.querySelector(".js-message-form--input");
  const submit = form.querySelector(".js-message-form--submit");

  // You can send a message with [Enter] or [Cmd/Ctrl + Enter]
  input.addEventListener("keydown", event => {
    if (event.code !== "Enter") {
      return;
    }

    event.preventDefault();

    const { altKey, ctrlKey, metaKey, shiftKey } = event;
    const withModifier = altKey || shiftKey || (isMac ? ctrlKey : metaKey);

    if (withModifier) {
      handleLineBreak(input);
    } else {
      handleSubmit(input);
    }
  });

  // Or by cicking a button
  submit.addEventListener("click", event => {
    event.preventDefault();
    handleSubmit(input);
  });
}
