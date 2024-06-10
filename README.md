# The Ruby Project: Pet Network App

### Unite Hearts. Find Joy & Save Lives.

Welcome to The Ruby Project, your dedicated platform fostering connections between shelters, adopters, and pets across the Philippines. Our mission is clear: to empower shelters by showcasing their incredible pets, amplifying their stories, and ultimately facilitating loving adoptions. At the heart of it all are the pets themselves, each one deserving of a warm and loving home.

Join us in The Ruby Project as we strive to make a difference in the lives of shelter animals, one adoption at a time. Welcome to a world where compassion meets companionship.

## User Stories

### Admin User Stories
1. **Approve/Deny Sign-ups:** Approve or deny potential adopter sign-ups to ensure platform integrity.
2. **Invite/Approve Shelters:** Invite and approve shelters to join the platform.
3. **Manage User Accounts:** View and manage all user accounts (both potential adopters and shelters).
4. **View Adoption Applications:** View adoption applications sent by potential adopters for status monitoring.
5. **Real-time Communication:** Chat with shelters for real-time communication.

### Shelter User Stories
1. **Create Account:** Create an account easily and securely.
2. **Create Pet Profiles:** Create detailed profiles for each adoptable animal, including photos and relevant information.
3. **View All Pets:** View all pets available for adoption.
4. **Update Pet Profiles:** Update pet profiles quickly when an animal is adopted or becomes unavailable.
5. **View Statistics:** View a dashboard with statistics on adopted and pending adoption pets.
6. **Approve/Deny Applications:** Approve or deny adoption applications based on factors such as pet suitability and adopter preferences.
7. **Real-time Communication:** Chat with potential adopters for real-time communication.

### Potential Adopter User Stories
1. **Create Account:** Create an account easily and securely.
2. **Receive Notifications:** Receive a notification when my account has been approved by the admin.
3. **Search for Pets:** Search for available pets using various filters.
4. **View Pet Profiles:** View detailed pet profiles, including photos and descriptions.
5. **Save Favorite Pets:** Save my favorite pet profiles to a list for quick reference.
6. **Post Comments/Questions:** Post questions or comments on each animal profile.
7. **Fill Out Applications:** Fill out an adoption application to be sent to the admin and shelter.
8. **View All Adoption Applications:** View all of my adoption applications in one page.
9. **View Application Status:** View updates on the status of my adoption application.
10. **Withdraw Applications:** Destroy or withdraw an adoption application.
11. **Real-time Communication:** Chat with shelters for any questions or concerns during the adoption process.

## Getting Started

### Prerequisites

- Ruby 3.3.0
- Rails 7.1.3
- PostgreSQL

### Installation

1. Clone the repository:
    ```git clone https://github.com/paulenepal/pet-network-app.git```
    ```cd pet-network-app```

2. Install dependencies:
    ```bundle install```

3. Set up the database:
    ```rails db:create```
    ```rails db:migrate```

4. Run the application:
    ```rails server```

### Gems Used
    `rails`: Web application framework
    `pg`: PostgreSQL database adapter
    `puma`: Web server
    `importmap-rails`: JavaScript with ESM import maps
    `turbo-rails`: SPA-like page accelerator
    `stimulus-rails`: JavaScript framework
    `tailwindcss-rails`: CSS framework
    `font-awesome-sass`: Icon library
    `devise`: Authentication
    `devise_invitable`: Invitations for Devise
    `geocoder`: Geocoding
    `rspec-rails`: Testing framework
    `factory_bot_rails`: Fixtures replacement
    `faker`: Fake data generator
    `sendbird`: Chat functionality
    `dotenv-rails`: Environment variables
    `faraday`: HTTP client

### Contributing

1.  Fork the repository.
2.  Create a feature branch (git checkout -b feature-branch).
3.  Commit your changes (git commit -m 'Add some feature').
4.  Push to the branch (git push origin feature-branch).
5.  Create a new Pull Request.
