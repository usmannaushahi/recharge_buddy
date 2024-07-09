# recharge_buddy - An app that allows you to add beneficiaries and top-up their wallet

# Project Summary 
- CLEAN Architecture by Uncle Bob
- Cubit/Bloc for State Management
- Built on latest Flutter 3.22.2 with null safety
- All the data has been managed by state
- Mock HTTP Requests using Dio added, but not called


# Packages used

- flutter_bloc: ^8.1.6 -> For State Management, Cubit has been used.
- equatable: ^2.0.5 -> To compare objects, it is a good approach to use equatable in dart.
- go_router: ^14.2.0 -> To use Flutter's Navigation 2.0. It also support deep linking, data-driver routes, and more.
- uuid: ^3.0.6 -> To create unique uuid in the app in order to handle logics.
- dio: ^5.5.0+1 -> For Mock HTTP Requests
- dartz: ^0.10.1 -> For functional programming. 



## Build and Run the App.

# Clean build folder
flutter clean

# Download packages and dependencies
flutter pub get

# to install the app on connected device
flutter run

# to build the app for a specific environment (Dev/Prod)
flutter build apk --release


