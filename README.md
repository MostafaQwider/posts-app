# Posts App 📱

A robust Flutter application for sharing posts and comments, built with **Clean Architecture** and **Firebase**.

## 🚀 Features

- **Posts Management**:
  - View all posts in a real-time feed.
  - Create new posts with titles and content.
  - **Edit** existing posts.
  - Delete posts.
- **Comments System**:
  - View comments on each post.
  - Add new comments to engage with content.
- **Real-time Updates**: changes are reflected instantly using Firestore streams.

## 🛠️ Tech Stack & Architecture

This project follows the **Clean Architecture** principles to ensure separation of concerns, scalability, and testability.

### Layers:
1.  **Domain Layer**: Contains Entities, Use Cases, and Repository Interfaces. Pure Dart code, no Flutter dependencies.
2.  **Data Layer**: Handles data retrieval from Firestore, Model mapping, and Repository Implementations.
3.  **Presentation Layer**: UI Components, Pages, and State Management using `Provider`.

### Key Technologies:
- **Flutter** & **Dart**
- **Firebase Firestore**
- **Provider** (State Management)
- **GetIt** (Dependency Injection)
- **Equatable**
- **Intl** & **Timeago** (Date formatting)

## 📂 Project Structure
```
lib/
├── core/
│   ├── di/                 # Dependency Injection setup
│   └── errors/             # Custom Failures and Exceptions
├── features/
│   └── posts/
│       ├── data/           # Data Source, Models, Repositories Impl
│       ├── domain/         # Entities, Repositories Interface, Use Cases
│       └── presentation/   # Pages, Widgets, Providers
└── main.dart
```
## 🖼 Screenshots
<img width="677" height="347" alt="Screenshot 2026-01-19 064230" src="https://github.com/user-attachments/assets/000f3681-12ec-429d-b138-8e06cdd45bfe" />

<img width="676" height="346" alt="Screenshot 2026-01-19 064354" src="https://github.com/user-attachments/assets/2e6a583f-1e23-44b9-bec3-89cd21ccc3f8" />



## 🔧 Setup & Installation

1.  **Clone the repository**:
```    git clone https://github.com/your-username/posts_app.git ```
2.  **Install dependencies**:
    ```flutter pub get```
3.  **Firebase Configuration**:
    -   Ensure you have a Firebase project set up.
    -   Add your `google-services.json` (Android) / `GoogleService-Info.plist` (iOS) to the respective folders.
4.  **Run the app**:
 ```   flutter run```

## 👨‍💻 Developed By

Mostafa Qwider



