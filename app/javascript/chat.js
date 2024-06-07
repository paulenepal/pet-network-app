// app/javascript/chat.js
import SendBird from "sendbird";

document.addEventListener('DOMContentLoaded', () => {
  console.log('JavaScript loaded');

  const SENDBIRD_APP_ID = "<%= ENV['SENDBIRD_APP_ID'] %>";
  const sb = new SendBird({ appId: SENDBIRD_APP_ID });

  const chatLinks = document.querySelectorAll('.chat-link');
  const chatContainer = document.getElementById('chat-container');
  const chatUsername = document.getElementById('chat-username');
  const minimizeChat = document.getElementById('minimize-chat');
  const closeChat = document.getElementById('close-chat');
  const chatInput = document.getElementById('chat-input');
  const chatMessages = document.getElementById('chat-messages');

  if (!chatContainer || !chatUsername || !minimizeChat || !closeChat || !chatInput || !chatMessages) {
    console.error('One or more elements are missing');
    return;
  }

  chatLinks.forEach(link => {
    link.addEventListener('click', (e) => {
      e.preventDefault();
      console.log('Chat link clicked');
      const userId = e.currentTarget.dataset.userId;
      const username = e.currentTarget.dataset.username;
      console.log('User ID:', userId);
      console.log('Username:', username);
      chatUsername.innerText = username;
      chatContainer.classList.remove('hidden');
      chatContainer.classList.add('block');

      // Authenticate with SendBird
      sb.connect(userId, (user, error) => {
        if (error) {
          console.error('SendBird connection error:', error);
          return;
        }
        console.log('SendBird connected as:', user.nickname);

        // Create or get a chat channel
        const params = new sb.GroupChannelParams();
        params.isPublic = false;
        params.isEphemeral = false;
        params.userIds = [userId, 'admin']; // Include both the shelter and admin user IDs

        sb.GroupChannel.createChannel(params, (channel, error) => {
          if (error) {
            console.error('SendBird createChannel error:', error);
            return;
          }
          console.log('Channel created:', channel.url);

          // Load previous messages
          const messageListQuery = channel.createPreviousMessageListQuery();
          messageListQuery.load(20, true, 'latest', (messages, error) => {
            if (error) {
              console.error('SendBird loadMessages error:', error);
              return;
            }
            chatMessages.innerHTML = '';
            messages.forEach(message => {
              const messageElement = document.createElement('div');
              messageElement.classList.add('p-2', 'border', 'border-gray-300', 'rounded', 'mb-2');
              messageElement.innerText = `${message.sender.nickname}: ${message.message}`;
              chatMessages.appendChild(messageElement);
            });
          });

          // Send a message
          chatInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
              const message = chatInput.value;
              chatInput.value = '';

              channel.sendUserMessage(message, (message, error) => {
                if (error) {
                  console.error('SendBird sendMessage error:', error);
                  return;
                }
                const messageElement = document.createElement('div');
                messageElement.classList.add('p-2', 'border', 'border-gray-300', 'rounded', 'mb-2');
                messageElement.innerText = `${message.sender.nickname}: ${message.message}`;
                chatMessages.appendChild(messageElement);
              });
            }
          });

          // Receive messages
          sb.addChannelHandler('uniqueHandlerId', new sb.ChannelHandler({
            onMessageReceived: (channel, message) => {
              const messageElement = document.createElement('div');
              messageElement.classList.add('p-2', 'border', 'border-gray-300', 'rounded', 'mb-2');
              messageElement.innerText = `${message.sender.nickname}: ${message.message}`;
              chatMessages.appendChild(messageElement);
            }
          }));
        });
      });
    });
  });

  minimizeChat.addEventListener('click', () => {
    console.log('Minimize button clicked');
    chatContainer.classList.toggle('h-10');
    chatMessages.classList.toggle('hidden');
  });

  closeChat.addEventListener('click', () => {
    console.log('Close button clicked');
    chatContainer.classList.add('hidden');
  });
});
