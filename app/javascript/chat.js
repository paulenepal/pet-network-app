// function loadChatScript() {
//   const script = document.createElement('script');
//   script.src = '/javascript/chat.js'; // Update this path to the correct one
//   document.body.appendChild(script);
// }



// document.addEventListener('DOMContentLoaded', function() {
//   const currentUserId = "<%= current_user.sendbird_id %>";
//   let currentChannelUrl = null;
//   const chatLinks = document.querySelectorAll('.chat-link');

//   chatLinks.forEach(function(chatLink) {
//     chatLink.addEventListener('click', function(event) {
//       event.preventDefault();
//       const targetUserId = chatLink.dataset.userId;
//       const targetUsername = chatLink.dataset.username;
//       handleChatLinkClick(targetUserId, targetUsername);
//     });
//   });

//   function createGroupChannel(targetUserId) {
//     return fetch('/sendbird/create_group_channel_to_sendbird', {
//       method: 'POST',
//       headers: {
//         'Content-Type': 'application/json',
//         'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
//       },
//       body: JSON.stringify({
//         user_id: targetUserId
//       })
//     })
//     .then(response => response.json());
//   }

//   function handleChatLinkClick(targetUserId, targetUsername) {
//     createGroupChannel(targetUserId).then(channelInfo => {
//       const channelUrl = channelInfo.channel_url;
//       document.getElementById('chat-container').dataset.channelUrl = channelUrl;
//       document.getElementById('chat-username').textContent = targetUsername;
//       document.getElementById('chat-container').classList.remove('hidden');
//       initializeChatMessagesContainer(channelUrl);
//       fetchMessages(channelUrl);
//     });
//   }

//   function initializeChatMessagesContainer(channelUrl) {
//     const chatMessagesContainer = document.getElementById('chat-messages-container');
//     chatMessagesContainer.innerHTML = `<div id="chat-messages-${channelUrl}" class="p-3 h-64"></div>`;
//   }

//   function sendMessage(channelUrl, userId, message) {
//     fetch('/sendbird/send_message_to_sendbird', {
//       method: 'POST',
//       headers: {
//         'Content-Type': 'application/json',
//         'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
//       },
//       body: JSON.stringify({
//         channel_url: channelUrl,
//         user_id: userId,
//         message: message
//       })
//     })
//     .then(response => response.json())
//     .then(response => {
//       const chatMessages = document.getElementById(`chat-messages-${channelUrl}`);
//       const messageElement = document.createElement('div');
//       messageElement.textContent = message;
      

//       // Apply styles based on user ID
//     if (userId === currentUserId) {
//       messageElement.classList.add('bg-blue-200', 'rounded-xl', 'py-2', 'px-4', 'my-2', 'float-right');
//     } else {
//       messageElement.classList.add('bg-orange-200', 'rounded-xl', 'py-2', 'px-4', 'my-2', 'float-left');
//     }

//       chatMessages.appendChild(messageElement);
//     })
//     .catch(error => {
//       console.error('Error sending message:', error);
//       alert('Error sending message');
//     });
//   }

//   document.getElementById('chat-input').addEventListener('keypress', function(event) {
//     if (event.key === 'Enter') {
//       event.preventDefault();
//       const message = event.target.value;
//       const chatContainer = document.getElementById('chat-container');
//       const channelUrl = chatContainer.dataset.channelUrl;
//       const userId = "<%= current_user.sendbird_id %>";
//       if (message.trim() !== '' && channelUrl && userId) {
//         sendMessage(channelUrl, userId, message);
//         event.target.value = '';
//         fetchMessages(channelUrl);
//       }
//     }
//   });

// function fetchMessages(channelUrl) {
//   fetch(`/sendbird/fetch_messages_from_sendbird?channel_url=${channelUrl}&message_ts=${Date.now()}`, {
//     method: 'GET',
//     headers: {
//       'Content-Type': 'application/json',
//       'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
//     }
//   })
//   .then(response => response.json())
//   .then(response => {
//     if (response.messages) {
//       const chatMessages = document.getElementById(`chat-messages-${channelUrl}`);
//       chatMessages.innerHTML = '';
//       response.messages.forEach(message => {
//         const messageElement = document.createElement('div');
//         messageElement.classList.add('message');
//         const timestamp = new Date(message.created_at);
//         const formattedTime = timestamp.toLocaleString();

//         if (message.user.user_id === "<%= current_user.sendbird_id %>") {
//           messageElement.classList.add('sender-message');
//         } else {
//           messageElement.classList.add('receiver-message');
//         }

//         messageElement.innerHTML = `
//           <div class="message-content">
//             <span>${message.message}</span>
//             <div class="message-time">${formattedTime}</div>
//           </div>
//         `;

//         // Apply styles based on user ID
//         if (message.user.user_id === currentUserId) {
//           messageElement.classList.add('bg-blue-200', 'rounded-xl', 'py-2', 'px-4', 'my-2', 'float-right');
//         } else {
//           messageElement.classList.add('bg-orange-200', 'rounded-xl', 'py-2', 'px-4', 'my-2', 'float-left');
//         }

//         chatMessages.appendChild(messageElement);
//       });
//     } else {
//       console.error('Failed to fetch messages:', response.error);
//       alert('Failed to fetch messages');
//     }
//   })
//   .catch(error => {
//     console.error('Error fetching messages:', error);
//     alert('Error fetching messages');
//   });
// }

//   document.getElementById('close-chat').addEventListener('click', function() {
//     const chatContainer = document.getElementById('chat-container');
//     chatContainer.classList.add('hidden');
//   });

//   document.getElementById('minimize-chat').addEventListener('click', function() {
//     const chatContainer = document.getElementById('chat-container');
//     const chatMessages = document.getElementById('chat-messages-container');
//     chatContainer.classList.toggle('h-10');
//     chatMessages.classList.toggle('hidden');
//   });

//   document.getElementById('btn-chat').addEventListener('click', function() {
//     const navChatContainer = document.getElementById('users-list');
//     navChatContainer.classList.toggle('hidden');
//   });

//   document.addEventListener('DOMContentLoaded', function() {
//     const searchInput = document.querySelector('.search-user');
//     const userList = document.querySelector('.list-of-users ul');
//     const users = Array.from(userList.getElementsByTagName('li'));

//     searchInput.addEventListener('input', function() {
//       const searchTerm = searchInput.value.trim().toLowerCase();

//       users.forEach(user => {
//         const username = user.dataset.username.toLowerCase();
//         if (username.includes(searchTerm)) {
//           user.style.display = 'block';
//         } else {
//           user.style.display = 'none';
//         }
//       });
//     });
//   });

//   loadChatScript();

// });