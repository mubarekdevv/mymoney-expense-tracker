# MyMoney — Offline-First Expense Tracker

Offline-first Flutter mobile application for personal expense management built with secure local authentication, SQLite persistence, dynamic theming, and clean layered architecture.

---

# Features

## Secure PIN Authentication
- First-launch 4-digit PIN setup
- Secure PIN verification on every app launch
- PIN stored using `flutter_secure_storage`
- Full app reset with secure PIN wipe and database cleanup

## Expense Management (SQLite CRUD)
- Add expenses with amount, category, note, and date
- View all expenses sorted by newest first
- Edit existing expenses
- Swipe-to-delete with confirmation dialog
- Monthly expense total calculation using SQLite `SUM` query

## Persistent User Preferences
- Currency selection:
  - ETB
  - USD
  - EUR
- Light/Dark theme switching
- Preferences persist across app restarts

## Professional UI/UX
- Material 3 design
- Responsive layout
- Reusable widgets
- Empty-state UI
- Snackbar feedback
- Form validation
- Clean navigation flow

## Offline-First Architecture
All application features work completely offline without requiring internet connectivity.

---

# Tech Stack

## Flutter
Cross-platform UI toolkit for building Android applications.

## SQLite (`sqflite`)
Used for local expense persistence and CRUD operations.

## SharedPreferences
Used for storing lightweight app preferences such as:
- theme mode
- currency selection

## flutter_secure_storage
Used for securely storing the user's authentication PIN.

## intl
Used for date formatting and localization-friendly formatting utilities.

---

# Project Structure

```text
lib/
├── main.dart
├── models/
│   └── expense.dart
├── services/
│   ├── expenses_db.dart
│   ├── pin_vault.dart
│   └── prefs_service.dart
├── screens/
│   ├── expenses_screen.dart
│   ├── expense_editor.dart
│   ├── pin_screen.dart
│   └── settings_screen.dart
├── widgets/
│   ├── expense_tile.dart
│   └── monthly_total_card.dart
└── utils/
    └── currency_formatter.dart
```

---

# Architecture Decisions

## Why SQLite?
SQLite provides structured local persistence and efficient querying for expense records, making it ideal for offline-first financial tracking applications.

## Why flutter_secure_storage?
Authentication credentials should never be stored in plain text. `flutter_secure_storage` encrypts sensitive data securely on the device.

## Why SharedPreferences?
Application preferences such as theme mode and currency are lightweight key-value data and fit perfectly with SharedPreferences.

## Why Service Layer Separation?
The application follows clean separation of concerns:
- UI layer handles presentation
- Services layer handles storage and persistence
- Models handle data representation

This improves:
- maintainability
- scalability
- readability
- testing

---

