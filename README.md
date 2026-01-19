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
![Screenshot_٢٠٢٦٠١١٩-٠٧٠٩٥٤](https://github.com/user-attachments/assets/1a3ccc4f-0f56-4194-a220-504b842dae12)
![Screenshot_٢٠٢٦٠١١٩-٠٧١٤٢٠](https://github.com/user-attachments/assets/bf988174-e94f-4fd5-9fc9-22d6a2be3cd8)
![Screenshot_٢٠٢٦٠١١٩-٠٧١٤٣٨](https://github.com/user-attachments/assets/3a06b2e0-1d1b-440b-99ae-3e3bf1c4f75e)
![Screenshot_٢٠٢٦٠١١٩-٠٧١٤٤٢](https://github.com/user-attachments/assets/676f4c20-48a4-4810-89ac-abc55c8643e8)
![Screenshot_٢٠٢٦٠١١٩-٠٧١٨١٢](https://github.com/user-attachments/assets/2ee0f759-3994-4019-a2fa-b9c358731a33)
![Screenshot_٢٠٢٦٠١١٩-٠٧١٨١٨](https://github.com/user-attachments/assets/83e98c3e-5b73-4ad1-8c59-429174bd8040)
![Screenshot_٢٠٢٦٠١١٩-٠٧١٨٤٢](https://github.com/user-attachments/assets/92dbbb9b-6d31-416d-b080-22f307664eca)


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

