# Pocket Bank

Pocket Bank is a mobile application built with Flutter that allows users to manage their finances make payments to other users and also enables them to request loans. It utilizes Firebase for data storage and integrates with the Mpesa API for mobile money transactions.

## Prerequisites

- Flutter: Ensure you have Flutter installed on your development machine. Follow the official installation guide here: https://docs.flutter.dev/get-started/install

- GitHub Account: You'll need a GitHub account to clone the project repository.

## Setting Up

1. Firebase

    - Create a project on the Firebase console: https://console.firebase.google.com/

    - Enable the required Firebase services for your project (e.g., Cloud Firestore, Authentication).

    - Get the following information after you've set up your Firebase. You'll input this information in the ```main.dart`` file to initialize your Firebase:
        * apiKey
        * authDomain
        * projectId
        * storageBucket
        * messagingSenderId
        * appId
    
2. Mpesa API

    - Register as a developer on the Safaricom developer portal: https://developer.safaricom.co.ke/

    - Create an app and obtain the following credentials:
        Consumer Key
        Consumer Secret
        Passkey

    - Create an environment file named .env in the project root directory. This file should not be committed to version control.

    - Add the following lines to your .env file, replacing the placeholders with your actual credentials:
        CONSUMER_KEY=<your_consumer_key>
        CONSUMER_SECRET=<your_consumer_secret>
        PASS_KEY=<your_pass_key>
        API_KEY=<api_key>

3. Dependencies

Navigate to the project root directory in your terminal.
Run the following command to install required dependencies:

  Bash
    ```flutter pub get```


## Running the Project

Connect your device or launch an emulator.
Run the following command to start the application:
 
 Bash
  ```flutter run```

