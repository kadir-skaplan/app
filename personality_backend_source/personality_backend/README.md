# Personality App Backend

Node.js ve Express.js ile oluşturulan AI destekli backend servisi.

## 🚀 Başlangıç

### Kurulum

```bash
npm install
```

### Çalıştırma

```bash
npm start
```

Server `http://localhost:3000` adresinde çalışacaktır.

## 📋 API Endpoints

### Health Check
```
GET /api/health
```

Sunucunun durumunu kontrol eder.

**Yanıt:**
```json
{
  "status": "ok",
  "message": "Server is running"
}
```

### Chat
```
POST /api/chat
```

Kişilik türüne uygun AI yanıtı alır.

**İstek:**
```json
{
  "message": "Nasıl başlamalıyım?",
  "personalityType": "The Leader"
}
```

**Yanıt:**
```json
{
  "response": "Option 1: ...",
  "personalityType": "The Leader",
  "category": "first_message",
  "timestamp": "2024-01-01T12:00:00Z"
}
```

### Optimize
```
POST /api/optimize
```

Mesajı optimize eder ve öneriler sunar.

**İstek:**
```json
{
  "message": "Merhaba",
  "personalityType": "The Leader"
}
```

**Yanıt:**
```json
{
  "originalMessage": "Merhaba",
  "optimizedMessage": "Merhaba (This shows genuine interest)",
  "suggestions": [
    "Keep it short and genuine",
    "Show authentic interest",
    "Respect their personality type"
  ],
  "timestamp": "2024-01-01T12:00:00Z"
}
```

### Premium Status
```
GET /api/premium/:userId
```

Kullanıcının premium durumunu kontrol eder.

**Yanıt:**
```json
{
  "userId": "user123",
  "isPremium": false,
  "expiresAt": null,
  "features": ["chat", "videos", "premium_content"]
}
```

## 🔧 Ortam Değişkenleri

`.env` dosyasında ayarlanır:

```
PORT=3000
NODE_ENV=development
OPENAI_API_KEY=sk-test-key-placeholder
API_BASE_URL=http://localhost:3000
```

## 📦 Bağımlılıklar

- **express**: Web framework
- **cors**: Cross-Origin Resource Sharing
- **dotenv**: Ortam değişkenleri
- **axios**: HTTP istekleri

## 🎯 Kişilik Türleri

Backend aşağıdaki 6 kişilik türünü destekler:

1. **The Leader** - Lider
2. **The Creative** - Yaratıcı
3. **The Protector** - Koruyucu
4. **The Intellectual** - Entelektüel
5. **The Adventurer** - Macera Arayıcı
6. **The Romantic** - Romantik

Her türün özel yanıt şablonları vardır.

## 🔐 Güvenlik

- CORS etkindir (tüm originler kabul edilir)
- API anahtarları `.env` dosyasında saklanır
- Giriş doğrulaması yapılır
- Hata yönetimi uygulanır

## 📝 Proje Yapısı

```
personality_backend/
├── server.js          # Ana sunucu dosyası
├── package.json       # Bağımlılıklar
├── .env              # Ortam değişkenleri
└── README.md         # Dokümantasyon
```

## 🚀 Üretim Dağıtımı

Üretim için öneriler:

1. Ortam değişkenlerini güvenli şekilde ayarlayın
2. CORS'u kısıtlayın
3. Rate limiting ekleyin
4. Logging ve monitoring ayarlayın
5. SSL/TLS kullanın

## 📞 Destek

Sorunlar için GitHub issues'ı kullanın.
