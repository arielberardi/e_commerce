# E-Commerce Flutter Project

Welcome to the E-Commerce Flutter project readme. This project is an E-Commerce mobile application developed using the Flutter framework, offering a user-friendly fashion e-shopping experience. Below, you will find detailed information about the project, its features, and technical aspects.

**Project Overview**

E-Commerce is a mobile app designed to provide a seamless and delightful shopping experience for fashion enthusiasts. The app allows users to browse, search, and purchase a variety of clothing items. The design of the app is based on a Figma prototype, ensuring a visually appealing and user-friendly interface.

Base on Figma Design: [Ecommerce Mobile App UI](https://www.figma.com/file/eA9r02jSUyQ5or9SAqueVo/Ecommerce-Mobile-App-UI-kit-(Community)?type=design&node-id=0-1&mode=design&t=X7qVBORInaqELXy4-0)

## User Features
* Sign Up/In and Sign Out
* Product Listings with Top list, view all and categories
* Filter of product and search of products
* Favorites List
* Shopping Cart and Checkout
* Product Details with size selection, color selection plus detailed description

## Technical Features

1. Firebase Authentication

Firebase Authentication is used to handle user registration, login, and account management. Users can sign in with their email and password, Google account, or Facebook account.

2. Stripe Payment

The app uses the Stripe payment gateway to securely process payments from users.
This ensures a smooth and secure checkout experience for customers.

3. State Management with Provider

The project utilizes the Provider package to manage the app's state effectively.

4. Clean Code and Code Reusability

The project emphasizes clean and maintainable code, making it easier for developers to work on and extend the application. Code reusability is promoted throughout the project to reduce redundancy and improve efficiency.

5. Environment Variables

Sensitive data and configuration settings are managed using environment variables to enhance security and flexibility.

6. Animations

The app includes animations to provide a visually engaging and interactive user experience.

**References**

Flutter: https://flutter.dev/

Firebase Authentication: https://firebase.google.com/products/auth

Stripe: https://stripe.com/

Provider Package: https://pub.dev/packages/provide

### Setting Up

1. Clone this repo
2. Install all the pub packages
3. Install Firebase Auth and Console to setup the project (this should create google-services.json and GoogleServices.Info.plist)
4. Edit any .sample file with the requested information and remove the ".sample" ending
5. Use your favorite code editor and run the Flutter App