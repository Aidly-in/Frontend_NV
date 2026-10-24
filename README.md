# Aidly – Payment Feature 💳

## Overview

The **Payment** feature in Aidly is responsible for handling payments for healthcare services, including doctor consultations, appointment bookings, care plans, and other eligible services. It provides users with a clear checkout experience, payment method selection, order review, and payment status feedback.

This feature is developed using **Flutter and Dart** and is organized using a feature-based **Domain-Driven Design (DDD) / Clean Architecture** approach to improve maintainability, testability, and separation of concerns.

## Key Features

- **Payment Methods:** Display available payment options.
- **Doctor Consultation Payments:** Support the doctor fee payment flow.
- **Checkout Summary:** Display service details, pricing, and the total amount payable.
- **Order and Service Review:** Allow users to review their selected healthcare service before payment.
- **Payment Processing:** Initiate payment requests through the configured payment provider or backend API.
- **Payment Status:** Handle pending, successful, and failed payment states.
- **Error Handling:** Provide appropriate feedback for network errors and unsuccessful transactions.
- **Maintainable Architecture:** Separate UI, business rules, and external data operations.

> Note: The payment methods and gateway integrations available in the application depend on the actual implementation.

## Tech Stack

- **Framework:** Flutter
- **Programming Language:** Dart
- **UI Components:** Flutter widgets and responsive layouts
- **Architecture:** DDD-inspired Clean Architecture
- **State Management:** To be configured according to the project
- **Payment Integration:** Backend API or payment gateway, as applicable

## Project Structure

```text
lib/
└── features/
    └── payment/
        ├── presentation/
        │   ├── pages/
        │   │   └── payment_page.dart
        │   ├── widgets/
        │   │   ├── payment_method_card.dart
        │   │   └── payment_summary.dart
        │   └── bloc/
        │       ├── payment_bloc.dart
        │       ├── payment_event.dart
        │       └── payment_state.dart
        │
        ├── domain/
        │   ├── entities/
        │   │   └── payment.dart
        │   ├── repositories/
        │   │   └── payment_repository.dart
        │   └── usecases/
        │       ├── create_payment.dart
        │       └── get_payment_status.dart
        │
        └── data/
            ├── datasources/
            │   └── payment_remote_data_source.dart
            ├── models/
            │   └── payment_model.dart
            └── repositories/
                └── payment_repository_impl.dart
```

*The structure above is a recommended layout. Keep only the files and state-management components that exist or are required in your implementation.*

## Architecture

The Payment feature is divided into three layers.

### 1. Presentation Layer

Responsible for the user interface and interaction.

- Payment screens and reusable widgets
- Payment method selection
- Checkout and payment summaries
- Loading, success, pending, and failure states
- State management and user actions

### 2. Domain Layer

Contains the core payment business logic and rules.

- **Entities:** Represent payment information and status.
- **Repository Contracts:** Define the operations required by the business logic.
- **Use Cases:** Represent operations such as creating a payment and retrieving payment status.

The domain layer should remain independent of Flutter UI, API clients, and payment-provider implementations.

### 3. Data Layer

Responsible for communicating with external systems.

- **Data Sources:** Communicate with backend APIs or payment services.
- **Models:** Map external responses to application data structures.
- **Repository Implementations:** Implement the repository contracts defined by the domain layer.

## Payment Flow

1. The user selects a healthcare service or doctor consultation.
2. The application displays the checkout summary and payable amount.
3. The user selects an available payment method.
4. The presentation layer invokes the appropriate domain use case.
5. The data layer sends the payment request to the configured backend or provider.
6. The payment provider processes the transaction.
7. The backend verifies the payment and returns the appropriate status.
8. The application displays the payment result and updates the relevant booking or order state.

## Getting Started

### Prerequisites

- Flutter SDK compatible with the project's `pubspec.yaml`
- Dart SDK
- Android Studio or VS Code
- An Android emulator or physical test device
- Backend API credentials and payment-provider configuration, if required

### Installation

From the project root, install dependencies:

```bash
flutter pub get
```

Run static analysis:

```bash
flutter analyze
```

Run the project's tests:

```bash
flutter test
```

Run the application:

```bash
flutter run
```

### Integration

Before enabling real transactions, configure the required backend endpoints, payment-provider settings, dependency injection, and state management. Keep secret credentials on the server and verify payment results on the backend.

## Testing

The Payment feature should be tested for:

- Valid and invalid payment requests
- Correct amount and currency handling
- Payment success, failure, and pending states
- Network timeouts and API errors
- Duplicate requests and repeated payment attempts
- Correct booking or order status after payment verification

## Security Considerations

- Never store sensitive card details unnecessarily.
- Never embed secret payment-provider credentials in the Flutter application.
- Verify payment status on the backend using trusted provider responses or webhooks.
- Validate the amount and order details on the server.
- Use HTTPS for network communication.
- Prevent duplicate transaction processing through appropriate backend safeguards.

## License

This feature is part of the proprietary Aidly healthcare application and is intended for internal use.
