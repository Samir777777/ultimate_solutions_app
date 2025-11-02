ultimate_solutions_app

 Overview
This Flutter app loads order data from an API and stores it locally using SQLite for fast filtering and offline support. It also implements a session timeout feature that automatically redirects the user to the login screen after 2 minutes of inactivity or when the app is backgrounded.

 Design Decisions

 Local Data Storage using SQLite
- Chose `sqflite` for lightweight and reliable local database support.
- Local storage improves data access speed and enables offline filtering.
- Data models mirror API JSON structure for easy serialization.

 Session Timeout using `flutter_inactive_timer`
- Simplifies inactivity monitoring without manually tracking UI events.
- Session timeout is set to 2 minutes, ensuring a balance between security and convenience.
- Automatic redirect enhances security by logging out inactive users.

 Architecture and Modularity
- Clear separation between API services, database helper, and UI screens.
- Improves maintainability, testing, and scalability.

 Localization Support
- Supports both English and Arabic with easy language switching.

 Code Quality
- Uses asynchronous Dart features (`async`/`await`) and clear state management.
- Proper error handling and clean coding practices.

 Setup & Run
- Tested on latest Flutter SDK.
- Install dependencies:

