Notes iOS App
![alt text](https://img.shields.io/badge/Swift-5.0-orange.svg)

![alt text](https://img.shields.io/badge/Platform-iOS%2013%2B-blue.svg)

![alt text](https://img.shields.io/badge/Architecture-MVVM-green.svg)

![alt text](https://img.shields.io/badge/License-MIT-lightgrey.svg)

A modern, offline-first iOS application built with SwiftUI and Core Data. This app demonstrates key concepts in mobile development including networking, local persistence, pagination, and a clean MVVM architecture. It fetches a list of notes from a public API, caches them locally for offline access, and allows users to manage their notes.

📸 Screenshots

Login Screen	Notes List	Add Note

✨ Features
✅ User Authentication: Simple login screen to simulate user sessions against a local database.
✅ Offline-First Caching: Fetches notes from an API and saves them to a local Core Data database, making the app fully functional without an internet connection after the initial fetch.
✅ Infinite Scrolling / Pagination: The notes list loads data in pages as the user scrolls, ensuring efficient performance with large datasets.
✅ Pull-to-Refresh: Users can pull down on the notes list to refresh the data from the remote API, updating the local cache.
✅ Local Search: Instantly search through all cached notes by title or description.
✅ CRUD Operations: Users can Create new notes, Read them in a detail view, and Delete existing ones from the list.
✅ Modern SwiftUI Interface: A clean and responsive UI built entirely with SwiftUI, including NavigationStack, .task, and .refreshable.
✅ Custom Networking Layer: Utilizes a separate Swift Package (MyNetworkingKit) for handling network requests cleanly.
🏗️ Architecture & Technology
The app is built using the Model-View-ViewModel (MVVM) pattern to ensure a clean separation of concerns.

View: The UI layer, built with SwiftUI. Views are responsible for displaying data and forwarding user interactions to the ViewModel. (NotesListView, LoginView, AddNoteView).
ViewModel: The presentation logic layer. It prepares data from the Model for the View, handles user input, and manages the state of the UI (@Published properties). (NotesListViewModel, LoginViewModel).
Model: The data layer, consisting of Codable structs for API responses (NoteResponse) and NSManagedObject subclasses for the local database (Note, Auth).
🛠️ Tech Stack
UI Framework: SwiftUI (for building the user interface declaratively).
Local Persistence: Core Data (for creating a robust, offline-first database).
Asynchronous Operations: Swift Concurrency (async/await) (for handling network requests and background tasks).
Networking: A custom MyNetworkingKit Swift Package, demonstrating dependency management via Swift Package Manager (SPM).
State Management: @StateObject, @Published, and @AppStorage for managing UI state and user sessions.
📁 Project Structure
The project is organized into logical groups to promote scalability and maintainability.

code
Code

download

content_copy

expand_less
Notes/
├── Core/
│   ├── App/          # App entry point, RootView, MainTabView
│   ├── Constants/    # API and String constants
│   ├── Models/       # Data models (Codable & Core Data .xcdatamodeld)
│   └── Storage/      # Core Data stack (CorePersistence) and data manager (StorageManager)
└── Feature/
    ├── Authentication/ # Login screen (View & ViewModel)
    ├── Notes/          # Notes List, Detail, Add Note (View, ViewModel, Service)
    └── Settings/       # Settings screen (View & ViewModel)
🚀 Getting Started
To run this project, you will need Xcode 14 or later.

Clone the repository:
code
Bash

download

content_copy

expand_less
git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name
Open the project in Xcode:
The project uses Swift Package Manager for its networking dependency, which will be resolved automatically by Xcode upon opening.
code
Bash

download

content_copy

expand_less
open Notes.xcodeproj
Run the application:
Select an iOS simulator (e.g., iPhone 15 Pro) and click the "Run" button (or press Cmd+R).
🧠 Core Concepts Demonstrated
This project serves as a practical example for several important iOS development concepts:

Offline-First Strategy: The app prioritizes showing data from the local Core Data cache, providing a seamless user experience even with a poor or non-existent internet connection.
Efficient Data Loading: Pagination is implemented in NotesListViewModel to avoid loading hundreds of items at once, which is critical for performance and memory management.
Graceful Error Handling: The networking layer properly handles different types of errors, including CancellationError, ensuring that user-initiated cancellations (like switching tabs during a network request) don't result in a confusing error message.
Singleton Pattern: StorageManager uses a singleton pattern (.manager) to provide a single, shared point of access to the Core Data database throughout the app.
Swift Package Manager Integration: Demonstrates how to integrate and use an external, reusable library (MyNetworkingKit) for a core function like networking.
📄 License
This project is licensed under the MIT License. See the LICENSE file for details.
