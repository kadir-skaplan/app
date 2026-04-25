# Personality App - Mobile Application

Kişilik türünü analiz eden ve AI destekli tavsiyeleri sunan premium mobil uygulama.

## 📱 Özellikler

- **Kişilik Analizi**: Doğum tarihi ve cinsiyet bilgilerine göre 24 farklı kişilik profili
- **AI Sohbet**: Kişilik türüne özel yapay zeka destekli tavsiyeler
- **Video İçeriği**: Kişilik türüne uygun kısa form videolar
- **Premium Sistem**: Ek içerik ve özelliklere erişim
- **Accordion Kartlar**: Genişletilebilir bilgi bölümleri
- **Dark Mode**: Modern ve premium görünüm

## 🏗️ Proje Yapısı

```
personality_app/
├── lib/
│   ├── models/          # Veri modelleri
│   ├── screens/         # Uygulama ekranları
│   ├── services/        # İş mantığı ve API servisleri
│   ├── widgets/         # Özel widget'lar
│   └── main.dart        # Ana uygulama dosyası
├── assets/
│   ├── data/            # JSON veri dosyaları
│   ├── images/          # Resim dosyaları
│   └── fonts/           # Font dosyaları
└── pubspec.yaml         # Bağımlılıklar
```

## 🎯 Ekranlar

### 1. Ana Ekran (Home Screen)
- Doğum tarihi seçici
- Cinsiyet seçimi (Erkek/Kadın)
- Analiz butonu

### 2. Yükleme Ekranı (Loading Screen)
- Animasyonlu yükleme göstergesi
- 3 aşamalı analiz mesajları
- 2-3 saniye süre

### 3. Sonuç Ekranı (Result Screen)
- Kişilik türü başlığı
- Video carousel
- Accordion kartlar (Ücretsiz ve Premium)
- Premium kilit sistemi

### 4. AI Sohbet Ekranı (Chat Screen)
- Hızlı sorular
- Mesaj gönderme/alma
- Kopyala butonu
- Sohbet geçmişi

### 5. Premium Ekranı (Premium Screen)
- Premium özellikleri listesi
- Fiyatlandırma
- Abone ol butonu

## 🔧 Teknoloji Stack

- **Frontend**: Flutter (Dart)
- **Backend**: Node.js + Express.js
- **State Management**: Provider
- **HTTP Client**: http package
- **Local Storage**: shared_preferences

## 🚀 Kurulum ve Çalıştırma

### Flutter Uygulaması

```bash
cd personality_app
flutter pub get
flutter run
```

### Node.js Backend

```bash
cd personality_backend
npm install
npm start
```

Backend `http://localhost:3000` adresinde çalışacaktır.

## 📋 API Endpoints

### POST /api/chat
Kişilik türüne uygun AI yanıtı alır.

### POST /api/optimize
Mesajı optimize eder.

### GET /api/premium/:userId
Premium durumunu kontrol eder.

## 🎨 Tasarım

- **Renk Şeması**: Dark mode (Mavi-Siyah)
- **Ana Renk**: #00d4ff (Cyan)
- **Arka Plan**: #1a1a2e (Koyu Mavi)
- **Vurgu**: #0f3460 (Orta Mavi)

## 📦 Bağımlılıklar

### Flutter Packages
- provider, http, intl, cached_network_image, flutter_spinkit, shared_preferences, uuid

### Node.js Packages
- express, cors, dotenv, axios

## 🔐 Güvenlik

- API anahtarları backend'de saklanır
- Mobil uygulama asla hassas veriler depolamaz
- CORS koruması etkindir

## 📝 Kişilik Türleri

1. The Leader (Lider)
2. The Creative (Yaratıcı)
3. The Protector (Koruyucu)
4. The Intellectual (Entelektüel)
5. The Adventurer (Macera Arayıcı)
6. The Romantic (Romantik)

Her türün erkek ve kadın versiyonu vardır (Toplam 12 × 2 = 24 profil).
