import cable from "actioncable";

let consumer;

const createChannel = (...args) => {
  if (!consumer) {
    consumer = cable.createConsumer();
  }

  return consumer.subscriptions.create(...args);
};

export default createChannel;
