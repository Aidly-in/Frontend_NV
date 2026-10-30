# 🩺 Aidly – Smart Healthcare & Medical Services App

**Aidly** is a cross-platform healthcare application developed using Flutter to make healthcare services more accessible, convenient, and user-friendly. The application provides a unified platform for doctor appointments, healthcare plans, homecare services, medical record management, and online payments.

With an intuitive interface and a structured service flow, Aidly aims to simplify the process of finding healthcare providers and managing essential medical services from a single application.

---

## 🚀 Features & Functionalities

### 🔐 1. User Authentication & Account Management
- **Splash Screen & Welcome Interface:** Provides an engaging introduction to the application.
- **User Registration & Login:** Enables users to create accounts and securely access their profiles.
- **OTP Verification:** Includes verification screens for account authentication and password recovery.
- **Password Management:** Supports password reset and password update confirmation flows.
- **Account Creation:** Provides confirmation screens after successful registration.

### 👨‍⚕️ 2. Doctor Discovery & Appointment Booking
- **Doctor Search:** Explore doctors based on their specialties, ratings, and availability.
- **Doctor Profiles:** View professional qualifications, experience, patient reviews, and consultation fees.
- **Appointment Scheduling:** Follow a structured, multi-step process to book consultations.
- **Booking Confirmation:** Displays appointment details after completing the booking process.
- **Doctor Fee Payment:** Provides a dedicated interface for consultation payments.

### 🏥 3. Homecare Services & Healthcare Plans
- **Personalized Care Plans:** Browse healthcare packages designed for different care requirements.
- **Homecare Services:** Explore available home-based healthcare options.
- **Pickup Scheduling:** Schedule pickups and view relevant booking details.
- **Quick Services:** Access healthcare services through a simplified booking interface.
- **Service Management:** Navigate between available healthcare offerings and related information.

### 💊 4. Medical Dashboard & Health Management
- **Medical Dashboard:** Access a centralized interface for medical information and health-related activities.
- **Medication Tracking:** Provides UI support for viewing medication schedules and prescription-related information.
- **Health Records:** Organizes medical information through a dedicated dashboard interface.
- **Location-Based Services:** Includes map integration to help users locate nearby healthcare facilities and service centers.

### 💳 5. Checkout, Payments & Reviews
- **Checkout Summary:** Review selected services and booking details before proceeding.
- **Payment Interface:** Navigate through available payment methods and payment-related screens.
- **Service Reviews:** Provide feedback on healthcare services.
- **Order Summary:** Review relevant service information before completing the checkout flow.

---

## 🛠️ Technology Stack

Aidly uses Flutter and Dart to deliver a consistent mobile application experience across supported platforms.

| Technology / Package | Purpose |
|---|---|
| **Flutter** | Cross-platform application development |
| **Dart** | Application programming language |
| `flutter_screenutil` 5.9.3 | Responsive layouts and screen scaling |
| `flutter_svg` 2.0.9 | Rendering SVG assets |
| `font_awesome_flutter` | Font Awesome icon integration |
| `cupertino_icons` | iOS-style icons |
| `flutter_arc_text` | Curved text UI elements |
| `flip_card` | Interactive flip-card components |
| `flutter_launcher_icons` | Application launcher icon generation |

**Framework Requirement:** Flutter SDK compatible with the project's configured Dart version.

---

## 📁 Project Structure

The application source code is organized into separate files based on screens and functional modules.

```text
lib/
│
├── main.dart
├── Aidly.dart
├── welcometoaidly.dart
│
├── Authentication/
│   ├── sign_up.dart
│   ├── cr_account.dart
│   ├── LoginAccount.dart
│   ├── logincomplete.dart
│   ├── sendcode.dart
│   ├── entercode.dart
│   ├── setnewpassword.dart
│   ├── passwordchange.dart
│   └── account_created.dart
│
├── Home & Dashboard/
│   ├── Home.dart
│   ├── quickserivice.dart
│   ├── Service Offered.dart
│   ├── MedDashboard.dart
│   └── Map.dart
│
├── Doctor Booking/
│   ├── Doctorlist.dart
│   ├── DocProfile.dart
│   ├── DocProfile2.dart
│   ├── BookProcess.dart
│   ├── AppointBooked.dart
│   └── docpayment.dart
│
├── Homecare & Care Plans/
│   ├── homecare.dart
│   ├── careplan.dart
│   ├── pickup.dart
│   └── pickup1.dart
│
└── Checkout & Payments/
    ├── Review.dart
    ├── payment.dart
    └── checkout.dart
```

*Note: The directory names above illustrate a logical grouping of the application's features. They are not necessarily existing folders in the repository. The original filenames are retained for reference.*

---

## ⚙️ Getting Started

Follow these instructions to set up and run Aidly on your local machine.

### Prerequisites

Install the following tools before starting development:

- **Flutter SDK:** A version compatible with the project's dependencies.
- **Dart SDK:** Included with Flutter.
- **Android Studio or Visual Studio Code:** For development and debugging.
- **Flutter and Dart Extensions:** Required when using VS Code.
- **Android Emulator or Physical Device:** For running and testing the application.

Useful resources:

- Flutter Documentation: https://docs.flutter.dev/
- Dart Documentation: https://dart.dev/
- Android Studio: https://developer.android.com/studio

### Installation & Setup

**Step 1: Clone the Repository**

```bash
git clone https://github.com/your-username/Aidly_Frontend.git
```

Navigate to the project directory:

```bash
cd Aidly_Frontend
```

**Step 2: Install Dependencies**

Download the packages required by the project:

```bash
flutter pub get
```

**Step 3: Configure Launcher Icons (Optional)**

If the launcher icon configuration is available in `pubspec.yaml`, generate the application icons:

```bash
dart run flutter_launcher_icons
```

**Step 4: Launch the Application**

Connect an emulator or physical device and execute:

```bash
flutter run
```

The application will start on the selected device.

---

## 🧪 Testing & Code Quality

Flutter provides built-in tools for checking code quality and running automated tests.

### Static Code Analysis

Identify potential errors, warnings, and code quality issues:

```bash
flutter analyze
```

### Run Tests

Execute the project's configured Flutter tests:

```bash
flutter test
```

These commands help identify issues and maintain code quality during development.

---

## 🔒 Security & Privacy

Aidly includes interfaces for authentication, OTP verification, password recovery, and payment-related workflows.

Actual security depends on the backend implementation, authentication mechanisms, payment gateway configuration, and data protection measures. Production deployments should use secure API communication, appropriate access controls, and verified payment processing.

---

## 🔮 Future Enhancements

Potential improvements to the application include:

- Integration with live doctor availability and appointment scheduling APIs.
- Secure backend authentication and user profile management.
- Integration with verified payment gateway services.
- Real-time appointment and homecare booking updates.
- Push notifications for appointments and medication reminders.
- Improved accessibility and multilingual support.
- Secure synchronization of medical records across devices.

---

## 📄 License

**Proprietary Software – Internal Use Only**

Aidly is intended for proprietary use. Redistribution, modification, or commercial use should be governed by the project's applicable permissions and licensing terms.

---

## 💙 About Aidly

Aidly aims to bring essential healthcare services together in one convenient digital platform. By combining doctor discovery, appointment booking, homecare options, and medical management interfaces, the application provides a foundation for a more accessible and organized healthcare experience.

**Aidly – Simplifying Healthcare, One Step at a Time.**