// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// document.addEventListener('DOMContentLoaded', function() {
//   // Get the chat link buttons
//   console.log ("Javascript loaded")
//   const chatLinks = document.querySelectorAll('.chat-link');

//   // Add click event listener to each chat link button
//   chatLinks.forEach(function(chatLink) {
//     chatLink.addEventListener('click', function(event) {
//       event.preventDefault();
      
//       // Get the target user ID and username from data attributes
//       const targetUserId = chatLink.dataset.userId;
//       const targetUsername = chatLink.dataset.username;

//       // Update chat interface with user information
//       document.getElementById('chat-username').textContent = `${targetUsername}`;

//       // Show the chat container
//       const chatContainer = document.getElementById('chat-container');
//       chatContainer.classList.remove('hidden');

//       // Make an AJAX request to create the group channel
//       // createGroupChannel(targetUserId, targetUsername);
//     });
//   });

//   // Function to create group channel
//   // function createGroupChannel(targetUserId, targetUsername) {
//   //   // Make AJAX request to Rails controller action
//   //   fetch('/sendbird/create_group_channel_to_sendbird', {
//   //     method: 'POST',
//   //     headers: {
//   //       'Content-Type': 'application/json',
//   //       'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
//   //     },
//   //     body: JSON.stringify({
//   //       user_id: targetUserId
//   //     })
//   //   })
//   //   .then(response => response.json())
//   //   .then(channelInfo => {
//   //     // Handle response - you can open the chat interface or do other actions here
//   //     console.log('Group channel created:', channelInfo);
//   //     alert(`Group channel created with ${targetUsername}`);

//   //     // Update chat interface with user information
//   //     document.getElementById('chat-username').textContent = `${targetUsername}`;

//   //     // Show the chat container
//   //     const chatContainer = document.getElementById('chat-container');
//   //     chatContainer.classList.remove('hidden');
//   //   })
//   //   .catch(error => {
//   //     console.error('Error creating group channel:', error);
//   //     alert('Error creating group channel');
//   //   });
//   // }

//   // Add click event listener to close chat button
//   document.getElementById('close-chat').addEventListener('click', function() {
//     // Hide the chat container
//     const chatContainer = document.getElementById('chat-container');
//     chatContainer.classList.add('hidden');
//   });

//   // Add click event listener to minimize chat button
//   document.getElementById('minimize-chat').addEventListener('click', function() {
//     console.log('Minimize button clicked');
//     const chatContainer = document.getElementById('chat-container');
//     const chatMessages = document.getElementById('chat-messages');
//     chatContainer.classList.toggle('h-10');
//     chatMessages.classList.toggle('hidden');
//   });

  //  // Add click event listener to open chat button
  //  document.getElementById('btn-chat').addEventListener('click', function() {
  //   // Hide the chat container
  //   const navChatContainer = document.getElementById('users-list');
  //   navChatContainer.classList.toggle('hidden');
  // });

// });




      // app/javascript/chat.js
      // document.addEventListener('DOMContentLoaded', () => {
      // console.log('JavaScript loaded');
      
      // const chatLinks = document.querySelectorAll('.chat-link');
      // const chatContainer = document.getElementById('chat-container');
      // const chatUsername = document.getElementById('chat-username');
      // const minimizeChat = document.getElementById('minimize-chat');
      // const closeChat = document.getElementById('close-chat');
      // const chatInput = document.getElementById('chat-input');
      // const chatMessages = document.getElementById('chat-messages');

      

      // if (!chatContainer || !chatUsername || !minimizeChat || !closeChat || !chatInput || !chatMessages) {
      //   console.error('One or more elements are missing');
      //   return;
      // }

      // chatLinks.forEach(link => {
      //   link.addEventListener('click', async (e) => {
      //     e.preventDefault();
      //     console.log('Chat link clicked');
      //     const userId = e.currentTarget.dataset.userId;
      //     const username = e.currentTarget.dataset.username;
      //     console.log('User ID:', userId);
      //     console.log('Username:', username);

      //      // Make an AJAX request to create a group channel
      // try {
      //   const response = await fetch('/messages', {
      //     method: 'POST',
      //     headers: {
      //       'Content-Type': 'application/json',
      //       'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      //     },
      //     body: JSON.stringify({ user_id: userId })
      //   });

      //   if (!response.ok) {
      //     throw new Error('Failed to create group channel');
      //   }

      //   const channelInfo = await response.json();
      //   console.log('Channel Info:', channelInfo);

      //   // Update chat UI with channel info
      //     chatUsername.innerText = username;
      //     chatContainer.classList.remove('hidden');
      //     chatContainer.classList.add('block');

      //   } catch (error) {
      //     console.error('Error:', error);
      //   }
      //   });
      // });

      // minimizeChat.addEventListener('click', () => {
      //   console.log('Minimize button clicked');
      //   chatContainer.classList.toggle('h-10');
      //   chatMessages.classList.toggle('hidden');
      // });

      // closeChat.addEventListener('click', () => {
      //   console.log('Close button clicked');
      //   chatContainer.classList.add('hidden');
      // });

      // chatInput.addEventListener('keypress', (e) => {
      //   if (e.key === 'Enter') {
      //     console.log('Enter key pressed');
      //     const message = chatInput.value;
      //     chatInput.value = '';
      //     const messageElement = document.createElement('div');
      //     messageElement.classList.add('p-2', 'border', 'border-gray-300', 'rounded', 'mb-2');
      //     messageElement.innerText = message;
      //     chatMessages.appendChild(messageElement);
      //   }
      // });

      // Function to fetch messages from the backend
  // function fetchMessages(channelType, channelUrl, messageId) {
  //   fetch(`/messages/${channelType}/${channelUrl}/${messageId}`)
  //     .then(response => response.json())
  //     .then(data => {
  //       if (data.error) {
  //         console.error('Error fetching message:', data.error);
  //       } else {
  //         displayMessage(data);
  //       }

  //     })
  //     .catch(error => {
  //       console.error('Error fetching message:', error);
  //     });
  // }

  // Function to display a message in the chat interface
//   function displayMessage(message) {
//     const messagesDiv = document.getElementById('chat-messages');
//     const messageDiv = document.createElement('div');
//     messageDiv.classList.add('message');
//     messageDiv.innerText = `${message.sender.nickname}: ${message.message}`;
//     messagesDiv.appendChild(messageDiv);
//   }

//   // Example usage: Replace with actual values
//   const channelType = 'group_channels';
//   const channelUrl = 'your_channel_url';
//   const messageId = 'your_message_id';

//   // Fetch and display the message
//   // fetchMessages(channelType, channelUrl, messageId);

//   // Add event listeners for chat input and send button
//   // const chatInput = document.getElementById('chat-input');
//   chatInput.addEventListener('keypress', function(e) {
//     if (e.key === 'Enter') {
//       const messageText = chatInput.value;
//       sendMessage(channelType, channelUrl, messageText);
//       chatInput.value = ''; // Clear the input
//     }
//   });

//   function sendMessage(channelInfo) {
//     const csrfToken = document.querySelector('meta[name="csrf-token"]').content;

//      // Replace user_id with the actual user ID from channelInfo
//      const user_id = window.currentUser.id;

//      // Replace channel_url with the actual channel URL from channelInfo
//      const channel_url = channelInfo.channel.channel_url;
 
//      // Get the message text from the chat input div
//      const messageText = document.getElementById('chat-input').value.trim();
    
//     fetch(`/messages/send_message`, {
//       method: 'POST',
//       headers: {
//         'Content-Type': 'application/json',
//         'X-CSRF-Token': csrfToken // Include CSRF token in the headers
//       },
//       body: JSON.stringify({
//         user_id: user_id,
//         channel_url: channel_url,
//         message: messageText
//       })
//     })
//     .then(response => response.json())
//     .then(data => {
//       if (data.success) {
//         // Message sent successfully, you can update UI or do other actions here
//         console.log('Message sent successfully:', data.message);
//       } else {
//         // Handle error
//         console.error('Error sending message:', data.message);
//       }
//     })
//     .catch(error => {
//       console.error('Error sending message:', error);
//     });
//   }
// });
