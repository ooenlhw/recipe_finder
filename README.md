# 🥗 Flutter Recipe Finder & Meal Planner App

A modern and intuitive Flutter app that helps users find recipes based on ingredients they have at home, save their favorite meals, and plan weekly menus. Powered by the Spoonacular API, it supports offline access, local storage, and data caching.

---

## 📦 Features

### 🔍 Ingredient-Based Recipe Search
- Input ingredients you have at home
- Search recipes via Spoonacular API
- Display recipes with thumbnails, titles, and summaries

### 📖 Recipe Details
- View detailed recipe information
  - Ingredients
  - Step-by-step instructions
  - Nutritional info (if available)
- Recipe image display

### ⭐ Favorites
- Save your favorite recipes locally
- Accessible offline

### 🗓️ Weekly Meal Plan
- Add saved recipes to a weekly planner
- View and edit planned meals
- Stored locally with offline support

### 📶 Offline Mode
- View saved recipes and plans without internet access

### 🧠 Smart Caching
- Cache Spoonacular API responses
- Refresh cache only every 30 minutes to save bandwidth

---

## 🚀 Getting Started

### 1. Prerequisites

Ensure you have the following installed:
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Dart SDK (bundled with Flutter)
- Android Studio or VS Code
- A device (Android)

### 2. Clone the Repository

```bash
git clone https://github.com/ooenlhw/recipe_finder.git
cd recipe_finder
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Add Spoonacular API Key

1. Go to [Spoonacular API](https://spoonacular.com/food-api) and create a free account.
2. Get your API key.
3. Add it in Data Source when we run the app in dev mode.

4. Ensure the app uses the API key by loading it during startup.

### 5. Run the App

#### Only Android Device:

```bash
flutter run
```

## 📁 Project Structure

Follows Clean Architecture & TDD principles:

```
lib/
├── core/
│   ├── error/
│   ├── network/
│   ├── routing/
│   ├── widgets/
│   ├── theme.dart
├── features/
│   ├── favorites/
│   ├── meal_plan/
│   ├── recipe/
└── main.dart
```

---

## ✅ Testing not included

Testing: not included

---

## 📌 Notes

- API responses are cached locally and refreshed every 30 minutes.
- Favorite recipes and meal plans are stored using a local storage sharedPreferences.
- Offline mode is supported using local storage and cache.

---

## 📸 Screenshots

> Add screenshots here for key screens: Search, Recipe List, Details, Favorites, Meal Plan.

---

## 📃 License

MIT License

---

## 💬 Support

For any issues or suggestions, feel free to open an [Issue](https://github.com/ooenlhw/recipe_finder/issues).
