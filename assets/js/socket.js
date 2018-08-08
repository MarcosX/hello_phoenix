import {Socket, Presence} from "phoenix"

let socket = new Socket("/socket", {
  params: { user_id: window.location.search.split("=")[1]}
});

function renderOnlineUsers(presences) {
  let response = "";

  Presence.list(presences, (id, {metas: [first, ...rest]}) => {
    let count = rest.length + 1;
    response += `<br>${id} (count: ${count})</br>`;
  })

  document.querySelector("main[role=main]").innerHTML = response;
};

socket.connect();

let presences = {};

let channel = socket.channel("room:lobby", {});

channel.on("presence_state", state => {
  presences = Presence.syncState(presences, state);
  renderOnlineUsers(presences);
});

channel.on("presence_diff", diff => {
  presences = Presence.syncDiff(presences, diff);
  renderOnlineUsers(presences);
});

// Now that you are connected, you can join channels with a topic:
let chatInput = document.querySelector("#chat-input");
let messagesContainer = document.querySelector("#messages");

chatInput.addEventListener("keypress", event => {
  if (event.keyCode === 13) {
    channel.push("new_msg", {body: chatInput.value});
    chatInput.value = "";
  }
});

channel.on("new_msg", payload => {
  let messageItem = document.createElement("li");
  messageItem.innerText = `[${Date()}] ${payload.body}`;
  messagesContainer.appendChild(messageItem);
});

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

export default socket
