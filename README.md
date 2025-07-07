
# 🎬 Flutter Admin Panel for Movie & Series Upload

This Flutter admin application allows you to upload **Movies** and **TV Series** with all associated metadata (cast, episodes, torrent links, trailer, etc.) into **Firestore**. It features a modular design, dark-themed UI, dynamic form fields, and proper validation — perfect for content managers and media library curators.

---

## ✨ Features

- ✅ Upload Movies with:
  - Title, Poster URL, Banner URL
  - Description, Year, Rating, Genre
  - Trailer URL
  - Cast Members
  - Torrent Links (with quality and URL)

- ✅ Upload Series with:
  - Title, Poster, Banner, Description
  - Dynamic Episodes (title + number)
  - Per-episode Torrent Links
  - Cast Members

- 🎨 Beautiful dark UI using `FeatherIcons`, `Material`, and responsive layouts

- 🧼 Modular architecture with reusable widgets and helpers

- ✅ Form validation for required fields, URLs, rating, and year

---

---

## 🔧 Technologies

- [Flutter](https://flutter.dev/)
- [Firebase Firestore](https://firebase.google.com/)
- [Riverpod](https://riverpod.dev/)
- [FeatherIcons](https://pub.dev/packages/feather_icons)
- Modular design and dynamic forms

---

## 🚀 Getting Started

### 🔹 Prerequisites

- Flutter SDK installed (3.10+)
- Firebase project created
- Firestore enabled
- Firebase CLI and FlutterFire CLI installed

---

### 🔹 Firebase Setup

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project
3. Enable **Cloud Firestore**
4. Download:
   - `google-services.json` for Android
   - `GoogleService-Info.plist` for iOS/macOS
5. Place them in appropriate folders:
   - `android/app/google-services.json`
   - `ios/Runner/GoogleService-Info.plist`

6. Run:
   ```bash
   flutterfire configure
   ```

---

### 🔹 Install Dependencies

```bash
flutter pub get
```

---

### 🔹 Run the App

```bash
flutter run
```

Make sure you're using an emulator or connected device.

---

## 🧪 Form Validations

- ✅ Required fields
- 🌐 URL validation
- 📅 Year validation
- ⭐ Rating (0.0 - 10.0) validation
- 🎭 Per-cast validation
- 📺 Episode-level validation

---

## 🧱 UI Components

- `CustomInputField`: Reusable input fields with icons, validators
- `CastInputWidget`: Cast input with name and image
- `EpisodeInputWidget`: Dynamic form for episode + torrent links
- `SectionHeader`: For separating cast, episodes, etc.

---

## 🧩 Dynamic Form Management

- **Add / Remove Cast**:
  - Dynamically add or delete cast members

- **Add / Remove Episodes**:
  - Add episodes with title, number
  - Add multiple torrent links per episode

- **Stateful Management** using internal controller lists

---

## 📤 Submission Logic

Handled via:

- `MovieFormHelper.submitMovieForm()`
- `SeriesFormHelper.submitSeriesForm()`

These:
- Validate the form
- Parse input controllers into `Movie` or `Series` models
- Upload to Firestore via `MovieService` or `SeriesService`

---

## ✅ TODO Features (Suggestions)

- [ ] Firebase Auth for admin protection
- [ ] Cloud Storage for image uploads
- [ ] Dashboard summary view of uploaded content
- [ ] Tagging, category support
- [ ] Searchable content list screen

---

## 🖼️ Screenshots (Add Yours Here)

> _Screenshots coming soon..._

---

## 👨‍💻 Author

Made with ❤️ using Flutter and Firebase.

---

## 📜 License

This project is open source under the [MIT License](LICENSE).
