# SpendWise

<h3>
Turn Your Expenses into Insights!
</h3>

This application empowers users to effortlessly manage their finances by tracking both income and
expenses. It offers a comprehensive summary of all transactions, enabling users to seamlessly
monitor and stay on top of their financial activities.

## Features

- **Transaction Management:** Users can add, edit, and delete transactions, categorizing them as
  either
  income or expense.
- **Summary Overview:** The app offers a clear and concise summary of all transactions, helping
  users
  understand their financial status at a glance.
- **Filtering Options:** Users can apply multiple filters to view specific transactions based on
  categories, dates, or types (income/expense), making it easier to analyze spending patterns.
- **Daily Reminders:** The app includes a notification feature that reminds users to add their daily
  transactions, ensuring that no expense or income is overlooked.
- **User-Friendly Interface:** Designed with simplicity and efficiency in mind, the app offers a
  seamless user experience, making financial tracking easy for everyone.
- **Architecture:** Follow MVVM pattern for clear separation of concerns.
- **Authentication with Firebase:** Secure user authentication using Firebase, supporting multiple
  sign-in methods to protect user data.
- **Light and Dark Dynamic Theming:** Enjoy a visually appealing interface with both light and dark
  themes that dynamically adjust to user preferences.
- **Efficient CRUD Operations with Realm:** Leverages Realm database for fast and reliable Create,
  Read,
  Update, and Delete operations on transactions.
- **Unit Testing with Mockito:** Ensures code reliability through unit tests using Mockito,
  maintaining a high standard of app performance and stability.

### Prerequisites

- Flutter SDK
- Dart SDK

## Getting Started

To run this application locally, follow these steps:

1. Make sure you have Flutter installed. For installation instructions, refer to
   the [Flutter documentation](https://flutter.dev/docs/get-started/install).
2. Clone this repository to your local machine.
3. Navigate to the project directory and run `flutter pub get` to install dependencies.
4. Connect a device or start an emulator.
5. Run the app using the command `flutter run`.

## Dependencies

This project uses several third-party dependencies. Some of the key dependencies include:

- `provider`: Simplifies state management by allowing easy access to and updates of state across the
  app.
- `realm`: Provides local database storage with real-time syncing capabilities, enabling efficient
  data management.
- `flutter_local_notifications`: Allows scheduling and displaying local notifications on Android and
  iOS.
- `firebase_core`: Initializes and configures Firebase services in the app.
- `firebase_auth`: Manages user authentication with various sign-in methods.
- `cloud_firestore`: A NoSQL cloud database for real-time data storage and syncing.

For a full list of dependencies, refer to the `pubspec.yaml` file.

## Directory Structure

      lib/
        |-- data/
              |-- models/ # Contains data models used throughout the application.
              |-- repositories/ # Manages data operations and interfaces with data sources.
        |-- generated/
              |-- (auto-generated files) # Stores auto-generated files. Avoid manual modifications.
        |-- utils/
              |-- configs/ # Configuration settings used across the application.
              |-- core/ # Core functionalities and utilities essential for the app's functionality.
              |-- routes/ # Handles navigation and route management within the app.
        |-- viewModels/
              |-- (ViewModel classes) # Contains ViewModel classes for business logic and state management.
        |-- views/
              |-- (UI components) # Houses the UI components and screens that form the application's interface.
        |-- widgets/
              |-- (custom widgets) # Custom widgets that are reusable across different parts of the application.
      main.dart
        |-- (entry point) # The main entry point of the application.

## License

Distributed under the MIT License. See LICENSE for more information.

## Contact

Twitter - https://x.com/iamSmkz
LinkedIn - https://www.linkedin.com/in/iamsmk

## Acknowledgements

Flutter
Provider
Firebase
Realm DB