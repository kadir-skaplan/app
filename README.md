# Personality Insights - Mobile App

A personality-based mobile application built with Flutter (mobile only) and Node.js backend.

## 📱 Features

- **Home Screen**: Date picker, gender selection, premium UI
- **Loading Screen**: Fake analysis animation (2.5s)
- **Result Screen**: Expandable accordion cards with free/premium content
- **Chat Screen**: AI assistant with quick action buttons
- **Video System**: Horizontal carousel with lock/unlock
- **Premium System**: Blur overlays, lock icons, CTAs

## 🛠️ Tech Stack

**Frontend (Mobile Only)**:
- Flutter 3.x (Dart)
- Provider state management
- Dark mode premium design

**Backend**:
- Node.js + Express
- OpenAI API integration (with mock fallback)
- JSON data storage

## 📁 Project Structure

```
/workspace/
├── flutter_app/
│   ├── lib/
│   │   ├── main.dart
│   │   ├── models/models.dart
│   │   ├── providers/app_provider.dart
│   │   ├── screens/
│   │   │   ├── home_screen.dart
│   │   │   ├── result_screen.dart
│   │   │   └── chat_screen.dart
│   │   ├── services/api_service.dart
│   │   └── widgets/
│   │       ├── accordion_card.dart
│   │       ├── video_carousel.dart
│   │       └── premium_overlay.dart
│   └── assets/
│       ├── fonts/ (Poppins fonts)
│       ├── images/
│       └── videos/
├── nodejs_backend/
│   ├── server.js
│   ├── data.json (24 personalities)
│   ├── package.json
│   └── .env
└── README.md
```

## 🚀 How to Run

### Backend

```bash
cd /workspace/nodejs_backend
npm install
npm start
```

Server runs on: http://localhost:3000

### Flutter App

**Important**: Flutter SDK must be installed on your local machine.

```bash
cd /workspace/flutter_app
flutter pub get
flutter run
```

**Supported Platforms**:
- iOS (requires macOS with Xcode)
- Android (requires Android Studio)
- Windows Desktop
- Web (Chrome/Edge)

## 🔧 Fixes Applied

1. ✅ Created missing asset directories (images, videos, fonts)
2. ✅ Downloaded Poppins fonts (Regular, Medium, Bold)
3. ✅ Fixed `Icons.instagram` → `Icons.camera_alt` (Instagram icon not available in all Flutter versions)
4. ✅ Fixed `Icons.unlock` → `Icons.lock_open` (unlock icon not available in all Flutter versions)
5. ✅ Added `import 'dart:ui' show ImageFilter;` for blur effect
6. ✅ Added placeholder files to asset directories

## 📊 API Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/health` | GET | Health check |
| `/analyze` | POST | Analyze personality from DOB + gender |
| `/chat` | POST | AI chat with 3 options |
| `/optimize` | POST | Optimize message |
| `/videos` | GET | Get video list |

## 🎨 Design Features

- **Color Scheme**: Purple (#6C5CE7), Dark (#0A0A0F), Amber premium
- **Font**: Poppins (Regular, Medium, Bold)
- **Animations**: FadeInUp, FadeInDown
- **Storytelling**: Short paragraphs, emotional hooks
- **Premium UX**: Blur effects, lock icons, gradient buttons

## 💡 Usage Flow

1. User enters date of birth + gender
2. Sees loading animation (2.5s)
3. Views personality analysis (free sections)
4. Watches first video (FREE), others locked
5. Uses AI chat for advice
6. Premium upsell for locked content

## 🔐 Premium System

- Blur overlay on locked content
- Lock icons on videos (first FREE, rest LOCKED)
- Premium dialog with feature list
- CTA: "Don't Make This Mistake..."

## 📝 Notes

- Backend has mock data fallback if OpenAI API unavailable
- Set `OPENAI_API_KEY` in `.env` for real AI responses
- Flutter app requires local Flutter SDK installation
- For iOS: Run on Mac with Xcode
- For Android: Run with Android Studio emulator or device
