# Posts App

A robust Flutter application for sharing posts and comments, built with Clean Architecture and Firebase.

## Features

- Responsive Design: Works seamlessly on Mobile, Tablet, and Web.
- Posts Management: Create, Read, Update, and Delete posts.
- Comments System: Engage with content through comments.


## Technologies Used

- Flutter: UI Toolkit.
- Dart: Programming Language.
- Firebase Firestore: Backend Database.
- Provider: State Management.
- GetIt: Dependency Injection.
- Dartz: Functional Programming.

## 📂 Project Structure

```
lib/
├── core/
│   ├── di/                 # Dependency Injection setup
│   └── Services/           # Services
├── features/
│   └── posts/
│       ├── data/           # Data Source, Models, Repositories Impl
│       ├── domain/         # Entities, Repositories Interface, Use Cases
│       └── presentation/   # Pages, Widgets, Providers
└── main.dart
```
## Clean Architecture

This project adopts Clean Architecture to ensure separation of concerns and maintainability. It divides the application into three distinct layers:

1. Presentation Layer:
   Handles the UI and user interactions. It communicates with the Domain layer to execute business logic and observes state changes. We use `Provider` here to manage state.

2. Domain Layer:
   The core of the application. It is completely independent of other layers.
   - Entities: Business objects (e.g., Post, Comment).
   - Use Cases: Encapsulate specific business rules (e.g., `AddPostUseCase`).
   - Repository Interfaces: Define the contract for data operations without knowing the implementation details.

3. Data Layer:
   Responsible for data retrieval and storage.
   - Models: Data transfer objects that extend Entities (handle JSON/Firestore serialization).
   - Data Sources: Interact with external agencies (Firebase, Local Storage).
   - Repositories: Implement the interfaces defined in the Domain layer, coordinating data from sources.

## Why Clean Architecture?

We chose Clean Architecture to build a scalable and maintainable application with clear separation of concerns.

Key benefits:
- Separation of concerns between UI, business logic, and data layers.
- Easier testing of business logic without relying on UI or external services.
- Flexibility to change the UI, database, or frameworks without impacting core logic.
- Better scalability as the application grows.
- Improved maintainability and easier collaboration for developers.

## Why Clean Architecture?

We chose Clean Architecture to build a scalable and maintainable application with clear separation of concerns.


Key benefits:
- Separation of concerns between UI, business logic, and data layers.
- Easier testing of business logic without relying on UI or external services.
- Flexibility to change the UI, database, or frameworks without impacting core logic.
- Better scalability as the application grows.
- Improved maintainability and easier collaboration for developers.
