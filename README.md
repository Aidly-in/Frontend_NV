# Aidly - Healthcare & Medical Services Application 🩺🏥

**Aidly** is a cross-platform mobile application built with **Flutter**, designed to provide seamless access to healthcare services, doctor bookings, care plans, medical dashboards, and homecare assistance.

---

## 🚀 Key Features

### 🔐 Authentication & Onboarding
- **Welcome & Splash Screen**: Interactive splash and landing flow.
- **Account Management**: User registration, login, and profile creation.
- **Security & Password Recovery**: OTP code verification (`sendcode` & `entercode`), password reset, and secure login flows.

### 👨‍⚕️ Doctor Appointments & Consultations
- **Doctor Discovery**: Browse doctors by specialty, ratings, and availability.
- **Detailed Profiles**: Doctor credentials, experience, reviews, and consultation rates.
- **Booking Flow**: Multi-step appointment scheduling with instant confirmation (`AppointBooked`).

### 🏥 Homecare & Care Plans
- **Care Plans**: Custom care packages tailored to patient needs.
- **Pickup & Delivery Services**: Homecare pickup scheduling and tracking.
- **Quick Services**: On-demand emergency and home visit booking.

### 💊 Medical Dashboard & Payments
- **Medication Dashboard**: Track prescriptions, health records, and medical schedules.
- **In-App Checkout & Payments**: Secure checkout with doctor payment options, review summaries, and payment gateways.
- **Map & Location Integration**: Locate nearby clinics, pharmacies, and service centers.

---

## 🛠️ Tech Stack & Packages

- **Framework**: [Flutter](https://flutter.dev/) (SDK ^3.7.2)
- **Language**: [Dart](https://dart.dev/)
- **UI & Layout**:
  - `flutter_screenutil` (5.9.3) – Responsive screen design & scaling
  - `flutter_svg` (2.0.9) – Vector graphics rendering
  - `font_awesome_flutter` & `cupertino_icons` – Icon sets
  - `flutter_arc_text` & `flip_card` – Interactive visual UI components
- **Icons Generator**: `flutter_launcher_icons`

---

## 📁 Project Structure

```text
lib/
├── main.dart             # App entry point & ScreenUtil initialization
├── Aidly.dart            # Splash / Landing page & timer navigation
├── welcometoaidly.dart   # Welcome onboard screen
│
├── # 🔐 Authentication
├── sign_up.dart          # User registration screen
├── cr_account.dart       # Create account screen
├── LoginAccount.dart     # User login screen
├── logincomplete.dart    # Login success confirmation
├── sendcode.dart         # Send OTP verification code
├── entercode.dart        # Enter & verify OTP code
├── setnewpassword.dart   # Password reset screen
├── passwordchange.dart   # Password updated confirmation
├── account_created.dart  # Account creation success screen
│
├── # 🏡 Home & Dashboard
├── Home.dart             # Main dashboard navigation & summary
├── quickserivice.dart    # Quick healthcare services
├── Service Offered.dart  # List of offered medical services
├── MedDashboard.dart     # Medical records & health dashboard
├── Map.dart              # Interactive location map
│
├── # 👨‍⚕️ Doctor Booking & Profiles
├── Doctorlist.dart       # Search & list available doctors
├── DocProfile.dart       # Doctor profile detail view
├── DocProfile2.dart      # Alternative doctor profile layout
├── BookProcess.dart      # Appointment booking workflow
├── AppointBooked.dart    # Booking confirmation screen
├── docpayment.dart       # Doctor fee payment screen
│
├── # 🏠 Homecare & Care Plans
├── homecare.dart         # Homecare services overview
├── careplan.dart         # Health care plan selection
├── pickup.dart           # Home pickup scheduling
├── pickup1.dart          # Pickup confirmation & details
│
└── # 💳 Checkout & Reviews
    ├── Review.dart       # Order/Service review page
    ├── payment.dart      # Payment methods & processing
    └── checkout.dart     # Final checkout summary
```

---

## 📦 Getting Started

### Prerequisites

Ensure you have the following installed on your machine:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (v3.7.2 or higher)
- [Dart SDK](https://dart.dev/get-dart)
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/) with Flutter extension
- An Android Emulator, iOS Simulator, or physical test device

### Installation Steps

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/Aidly_Frontend.git
   cd Aidly_Frontend
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Generate app launcher icons (optional):**
   ```bash
   flutter pub run flutter_launcher_icons
   ```

4. **Run the application:**
   ```bash
   flutter run
   ```

---

## 🧪 Testing & Code Analysis

To check for static code analysis errors and run standard unit tests:

```bash
# Run static analysis
flutter analyze

# Run unit tests
flutter test
```

---

## 📄 License

This project is proprietary and intended for internal use.
