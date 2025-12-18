
# 📝 Notes iOS App

![Swift](https://img.shields.io/badge/Swift-6.0-orange.svg)
![Platform](https://img.shields.io/badge/Platform-iOS%2013%2B-blue.svg)
![Architecture](https://img.shields.io/badge/Architecture-MVVM-green.svg)
![License](https://img.shields.io/badge/License-MIT-lightgrey.svg)

swift-tools-version: 6.1
The swift-tools-version declares the minimum version of Swift required to build this package.

A modern, **offline-first iOS application** built with **SwiftUI** and **Core Data**.  
This app demonstrates key mobile development concepts such as **networking, local persistence, pagination, and clean MVVM architecture**.

The app fetches a list of notes from a public API, caches them locally for offline access, and allows users to manage their notes seamlessly.

---

## ✨ Features

- ✅ **User Authentication**  
  Simple login screen to simulate user sessions against a local database.

- ✅ **Offline-First Caching**  
  Notes are fetched from an API and stored in Core Data, allowing full app usage without internet after initial sync.

- ✅ **Infinite Scrolling / Pagination**  
  Notes load page-by-page as the user scrolls for better performance with large datasets.

- ✅ **Pull-to-Refresh**  
  Refresh notes manually to sync latest data from the API.

- ✅ **Local Search**  
  Instantly search cached notes by title or description.

- ✅ **CRUD Operations**  
  Create, Read, and Delete notes.

- ✅ **Modern SwiftUI Interface**  
  Built entirely with SwiftUI using `NavigationStack`, `.task`, and `.refreshable`.

- ✅ **Custom Networking Layer**  
  Uses a separate Swift Package **MyNetworkingKit** for clean and reusable networking logic.

---

## 🏗 Architecture & Technology

The app follows the **Model–View–ViewModel (MVVM)** architecture for a clean separation of concerns.

### 🔹 View
- SwiftUI views responsible for rendering UI and forwarding user interactions  
- Examples: `NotesListView`, `LoginView`, `AddNoteView`

### 🔹 ViewModel
- Handles presentation logic and UI state  
- Uses `@Published` properties to update views  
- Examples: `NotesListViewModel`, `LoginViewModel`

### 🔹 Model
- Data layer using:
  - `Codable` structs for API responses (`NoteResponse`)
  - `NSManagedObject` subclasses for Core Data (`Note`, `Auth`)

---

## 🛠 Tech Stack

- **UI Framework:** SwiftUI  
- **Local Persistence:** Core Data  
- **Concurrency:** Swift Concurrency (`async/await`)  
- **Networking:** Custom Swift Package – **MyNetworkingKit** (SPM)  
- **State Management:** `@StateObject`, `@Published`, `@AppStorage`  

---

## 📦 Dependency

### MyNetworkingKit
- Integrated using **Swift Package Manager (SPM)**
- Responsible for:
  - API request handling
  - Response decoding
  - Error handling
- Promotes modular and reusable networking code

---

## 📁 Project Structure

```

Notes/
├── Core/
│   ├── App/              # App entry point, RootView, MainTabView
│   ├── Constants/        # API & string constants
│   ├── Models/           # Codable models & Core Data models
│   └── Storage/          # Core Data stack & StorageManager
└── Feature/
├── Authentication/  # Login (View & ViewModel)
├── Notes/            # Notes list, detail & add note
└── Settings/         # Settings screen

````

---

## 🚀 Getting Started

### Prerequisites
- Xcode **14+**
- iOS **13+**

### Installation

1. Clone the repository:
```bash
git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name
````

2. Open in Xcode:

```bash
open Notes.xcodeproj
```

> The networking dependency (**MyNetworkingKit**) is resolved automatically via Swift Package Manager.

3. Run the app:

* Select an iOS Simulator (e.g., iPhone 15 Pro)
* Press **Cmd + R**

---

## 🧠 Core Concepts Demonstrated

* **Offline-First Strategy**
  Prioritizes Core Data cache for smooth UX even without internet.

* **Efficient Data Loading**
  Pagination prevents memory and performance issues.

* **Graceful Error Handling**
  Proper handling of `CancellationError` and network failures.

* **Singleton Pattern**
  `StorageManager` provides a shared Core Data access point.

* **Swift Package Manager Integration**
  Demonstrates clean dependency management using a custom package.

---

## 📄 License

This project is licensed under the **MIT License**.
See the `LICENSE` file for details.

---
