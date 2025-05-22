# Parish Directory Flutter App

## Introduction

This is a **Parish Directory** mobile application built with Flutter. The app is designed for parishioners to browse family directories, view church units, committees, and access parish information. It also provides a secure login system, password reset, and a direct way to contact the administrator for account issues.

---

## Features

- **User Authentication:** Secure login with username and password.
- **Password Reset:** Users with default passwords are prompted to reset.
- **Family Directory:** Browse and search parish families, filter by church unit.
- **Family Profiles:** View detailed family and member information.
- **Church Units & Committees:** Explore all units and committees with images.
- **Admin Contact Page:** Direct contact details for admin support.
- **Modern UI:** Clean, responsive, and visually appealing interface.
- **Persistent Login:** User metadata is stored locally for session persistence.

---

## Screens & Widgets

- `LoginScreen`: User login, password reset, and admin contact access.
- `AdminContactPage`: Contact details for admin support.
- `HomePage`: Main dashboard with banners, church units, and committees.
- `DirectoryScreen`: Searchable and filterable family directory.
- `FamilyProfile`: Detailed view of a family's members.
- `ResetPasswordScreen`: Secure password reset flow.
- `UnitDetails`, `CommiteeDetails`, `ChurchUnitTile`, `ChurchCommittees`, etc.: Various UI components for units and committees.
- `BottomNavBar`: Persistent navigation bar.

---

## Setup Instructions

### 1. Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.5.4 or higher recommended)
- Dart SDK (comes with Flutter)
- Android Studio or Xcode (for emulator/simulator or device deployment)

### 2. Clone the Repository

```sh
git clone <your-repo-url>
cd directory
```

### 3. Install Dependencies

```sh
flutter pub get
```

### 4. Assets

All required images and icons are included in the `assets/` directory and referenced in `pubspec.yaml`. No further action is needed unless you wish to update images.

### 5. Run the App

To run on an emulator or connected device:

```sh
flutter run
```

To run on a specific device:

```sh
flutter devices
flutter run -d <device_id>
```

### 6. Build for Release

For Android:

```sh
flutter build apk --release
```

For iOS:

```sh
flutter build ios --release
```

---

## Usage

- **Login:** Enter your username and password. If you have the default password, you will be prompted to reset it.
- **Forgot Credentials:** Click "Not able to sign in? Contact Administrator" to view admin contact details.
- **Browse Directory:** Use the bottom navigation to access the directory, search, and filter families.
- **View Family Details:** Tap on a family to see detailed member information.
- **Explore Units & Committees:** Scroll horizontally to view all church units and committees.

---

## State Management

- Uses the `provider` package for user metadata and authentication state.

---

## Dependencies

- `flutter`
- `http`
- `provider`
- `intl`
- `shared_preferences`
- `cupertino_icons`
- `google_fonts`

---

## Customization

- **Admin Contact:** Edit `lib/widgets/AdminContactPage.dart` to update admin phone numbers or email.
- **Assets:** Replace images in the `assets/` directory as needed and update `pubspec.yaml` if you add new assets.

---

## Troubleshooting

- If you add new assets, run `flutter pub get` again.
- For dependency issues, ensure your Flutter SDK matches the version in `pubspec.yaml`.
- For iOS, run `pod install` in the `ios/` directory if you encounter CocoaPods errors.

---

## License

This project is for internal parish use. Please contact the administrator for permissions or contributions.

---

**For any issues, please contact the administrator as shown in the app.**
