# Personality Insights App

A production-ready mobile application that provides personality-based relationship insights using AI.

## 📱 Tech Stack

### Frontend (Mobile)
- **Flutter** (Dart)
- **Provider** for state management
- Runs on iOS and Android

### Backend
- **Node.js** with Express.js
- RESTful API
- OpenAI integration for AI chat

## 🚀 Features

### Core Functionality
1. **Personality Analysis** - Enter birth date + gender to get detailed personality profile
2. **AI Chat Assistant** - Get personalized messaging advice
3. **Video Content** - Short-form educational videos (first free, rest premium)
4. **Premium System** - Unlock advanced insights and features

### Screens
- **Home Screen** - Date picker, gender selection, analyze button
- **Loading Screen** - Fake analysis animation (2-3 seconds)
- **Result Screen** - Expandable accordion cards with free/premium content
- **Chat Screen** - AI-powered conversation assistant with quick actions

### UX Features
- Dark mode premium design
- Smooth animations
- Storytelling-style content
- Emotional hooks throughout
- Copy-to-clipboard for AI messages
- Social media loop integration

## 📁 Project Structure

```
flutter_app/
├── lib/
│   ├── main.dart                 # App entry point
│   ├── models/
│   │   └── models.dart           # Data models
│   ├── providers/
│   │   └── app_provider.dart     # State management
│   ├── screens/
│   │   ├── home_screen.dart      # Input screen
│   │   ├── result_screen.dart    # Analysis results
│   │   └── chat_screen.dart      # AI chat interface
│   ├── services/
│   │   └── api_service.dart      # API calls
│   └── widgets/
│       ├── accordion_card.dart   # Expandable cards
│       ├── video_carousel.dart   # Horizontal video list
│       └── premium_overlay.dart  # Premium lock system
└── assets/
    ├── images/
    └── videos/

nodejs_backend/
├── server.js                     # Express server
├── data.json                     # Personality data
├── package.json
└── .env                          # Environment variables
```

## 🔧 Setup Instructions

### Backend Setup

```bash
cd nodejs_backend

# Install dependencies
npm install

# Create .env file
cp .env.example .env

# Add your OpenAI API key to .env
# OPENAI_API_KEY=your_key_here

# Start server
npm start
```

Server runs on `http://localhost:3000`

### Flutter App Setup

```bash
cd flutter_app

# Install dependencies
flutter pub get

# Run on device/emulator
flutter run
```

## 🎯 API Endpoints

### POST /analyze
Analyze personality based on birth date and gender

```json
{
  "day": 15,
  "month": 6,
  "gender": "male"
}
```

### POST /chat
Get AI-powered chat response

```json
{
  "message": "Help me write a first message",
  "personalityType": "The Charismatic Communicator",
  "topics": ["Stories", "Humor"],
  "turnOff": "Silence and emotional distance"
}
```

### POST /optimize
Optimize a message for better impact

```json
{
  "originalMessage": "Hey, how are you?",
  "personalityType": "The Visionary Leader",
  "goal": "maximum impact"
}
```

### GET /videos
Get all video content

## 💎 Premium Features

Locked content includes:
- Dating ideas
- Present suggestions
- Keep the spark alive tips
- After breakup strategies
- Most video content
- Unlimited AI chat usage

## 🎨 Design System

- **Primary Color**: `#6C5CE7` (Purple)
- **Background**: `#0A0A0F` (Dark)
- **Premium Accent**: Amber/Orange gradient
- **Font**: Poppins

## 📊 Personality Types

The app includes 12 personality types × 2 genders = 24 unique profiles:

1. January - The Visionary Leader / Ambitious Queen
2. February - The Intuitive Thinker / Mysterious Muse
3. March - The Adventurous Spirit / Free Soul
4. April - The Dynamic Achiever / Radiant Star
5. May - The Sensual Protector / Nurturing Goddess
6. June - The Charismatic Communicator / Social Butterfly
7-12. Additional months follow similar patterns

## 🔐 Security Notes

- API keys stored in backend `.env` only
- Never expose API keys to mobile app
- Use HTTPS in production
- Implement proper authentication for premium features

## 🚀 Production Deployment

### Backend
- Deploy to Heroku, AWS, or DigitalOcean
- Set environment variables securely
- Enable CORS for your domain
- Use rate limiting

### Mobile
- Update API base URL in `api_service.dart`
- Configure app icons and splash screens
- Set up Firebase for analytics (optional)
- Implement in-app purchases for premium
- Submit to App Store and Google Play

## 📝 License

This is a commercial application. All rights reserved.

---

Built with ❤️ for meaningful connections
