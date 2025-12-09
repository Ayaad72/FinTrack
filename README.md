# FinTrack - Personal Finance Management Application

**A comprehensive Flutter-based mobile application for tracking personal finances, managing transactions, and analyzing spending patterns.**

---

## 📱 Project Overview

**FinTrack** is a cross-platform mobile application built with Flutter that empowers users to take control of their personal finances. The app provides intuitive transaction tracking, detailed analytics, wallet management, and comprehensive financial insights.

### Key Features
- 🔐 **User Authentication** - Secure login and signup system with local storage
- 💰 **Transaction Management** - Add, edit, and delete income/expense transactions
- 📊 **Analytics Dashboard** - Visual representation of spending patterns with charts
- 👛 **Wallet Management** - Track multiple accounts and balances
- 🔔 **Notifications** - Stay updated with financial activities
- 📈 **Reports & Insights** - Detailed transaction history and categorization
- 👤 **Profile Management** - Personalized user settings and preferences

### Technology Stack
- **Framework:** Flutter 3.9.0
- **Language:** Dart
- **State Management:** StatefulWidget with local state
- **Data Persistence:** SharedPreferences (local storage)
- **Charts:** fl_chart ^0.69.0
- **Image Handling:** image_picker ^1.2.0
- **UI Design:** Material Design with custom light theme

---

## 🎥 10-MINUTE VIDEO PRESENTATION SCRIPT

### **[0:00 - 0:30] Introduction (30 seconds)**

**Speaker 1 (Team Lead):**

> "Hello everyone! Welcome to our FinTrack project presentation. I'm [Name], and I'm joined by my team members [Names]. Today, we'll be presenting FinTrack - a personal finance management application built with Flutter. Over the next 10 minutes, we'll walk you through our application's architecture, demonstrate its features, and explain both the backend and frontend implementation. Let's get started!"

---

### **[0:30 - 2:00] Project Overview & Architecture (90 seconds)**

**Speaker 1 (Team Lead):**

> "FinTrack is designed to help users manage their personal finances efficiently. The application follows a clean architecture pattern with clear separation of concerns."

**[Show project structure on screen]**

> "Our project structure consists of:
> - **Models** - Data structures for transactions and user information
> - **Screens** - Nine main UI screens including login, dashboard, analytics, and more
> - **Widgets** - Reusable UI components
> - **Utils** - Helper classes for local storage and data management
> - **Theme** - Centralized theming system for consistent UI"

**Speaker 2 (Backend Developer):**

> "Let me explain the backend architecture. Although FinTrack is a mobile-first application, we've implemented a robust local backend system using SharedPreferences for data persistence."

**[Show code: lib/models/utils/local_storage.dart]**

> "Our backend layer handles:
> 1. **User Authentication** - Login state management with secure local storage
> 2. **Data Persistence** - All transactions, user profiles, and settings are stored locally
> 3. **Data Models** - We have structured models for transactions with properties like amount, category, date, type (income/expense), and description
> 4. **CRUD Operations** - Complete Create, Read, Update, Delete functionality for all entities"

---

### **[2:00 - 4:00] Backend Deep Dive (2 minutes)**

**Speaker 2 (Backend Developer):**

> "Let's dive deeper into our backend implementation."

**[Show code: lib/models/txn.dart]**

> "Our Transaction model is the core data structure. It includes:
> - Transaction ID for unique identification
> - Amount with decimal precision
> - Category (Food, Travel, Shopping, Health, etc.)
> - Transaction type (Income or Expense)
> - Date and time stamps
> - Optional notes and descriptions"

**[Show code: lib/models/utils/local_storage.dart]**

> "For data persistence, we use SharedPreferences which provides:
> - **Key-value storage** for user preferences
> - **JSON serialization** for complex objects
> - **Asynchronous operations** to prevent UI blocking
> - **Data encryption** capabilities for sensitive information"

> "Our authentication flow works as follows:
> 1. User enters credentials on the login screen
> 2. Credentials are validated against stored user data
> 3. Upon successful login, we store a session token
> 4. The app checks this token on startup to auto-login users
> 5. Users can logout, which clears the session data"

**[Show code: lib/main.dart lines 10-17]**

> "As you can see in our main.dart file, we check the login status before the app even starts, providing a seamless user experience."

---

### **[4:00 - 6:30] Frontend Implementation (2 minutes 30 seconds)**

**Speaker 3 (Frontend Developer):**

> "Now let's explore the frontend. FinTrack features a clean, modern UI with a light theme that's easy on the eyes."

**[Show code: lib/theme/app_theme.dart]**

> "We've implemented a centralized theming system using AppTheme class. This ensures consistency across all screens with:
> - Predefined color palette
> - Typography standards
> - Spacing and padding guidelines
> - Reusable component styles"

**[Show code: lib/models/screens/login_screens.dart]**

> "The Login Screen is our entry point. It features:
> - Clean, minimalist design
> - Input validation for email and password
> - Error handling with user-friendly messages
> - Smooth navigation to signup or dashboard
> - Remember me functionality"

**[Show code: lib/models/screens/dashboard_screen.dart]**

> "The Dashboard is the heart of our application. It displays:
> - **Total Balance** calculated in real-time
> - **Recent Transactions** with swipe-to-delete functionality
> - **Quick Action Buttons** for adding income or expenses
> - **Visual Summary** of financial status
> - **Bottom Navigation** for easy access to all features"

**[Show the transaction list implementation]**

> "We use ListView.builder for efficient rendering of transactions, which ensures smooth scrolling even with hundreds of entries."

**Speaker 4 (UI/UX Developer):**

> "Let me highlight our Analytics Screen."

**[Show code: lib/models/screens/analytics_screen.dart]**

> "The Analytics Screen provides powerful insights using fl_chart library:
> - **Pie Chart** showing income vs expense distribution
> - **Category Breakdown** with color-coded segments
> - **Time Period Filters** (Daily, Weekly, Monthly, Yearly)
> - **Interactive Charts** that respond to user touch
> - **Percentage Calculations** for each category"

> "We also have dedicated screens for:
> - **Wallet Management** - Track multiple accounts
> - **Transaction History** - Detailed view with filters
> - **Notifications** - Financial alerts and reminders
> - **Profile Settings** - User customization options
> - **Help & Support** - FAQs and contact information"

---

### **[6:30 - 9:00] Live Demonstration (2 minutes 30 seconds)**

**Speaker 1 (Team Lead):**

> "Now, let's see FinTrack in action!"

**[Start app demonstration]**

**1. Login Flow (20 seconds)**
> "First, I'll demonstrate the login process. Notice the smooth animations and input validation. If I enter incorrect credentials, we get a clear error message. Let me login with valid credentials... and we're in!"

**2. Dashboard Overview (30 seconds)**
> "Here's our dashboard. You can see:
> - My current balance of [amount]
> - Recent transactions listed below
> - The floating action button for quick transaction entry
> - Bottom navigation for all major features"

**3. Adding a Transaction (40 seconds)**
> "Let me add a new expense. I'll tap the '+' button...
> - Select 'Expense'
> - Enter amount: $50
> - Choose category: Food
> - Add description: 'Lunch with team'
> - Select today's date
> - Tap 'Save'
> 
> And there it is! The transaction appears immediately, and our balance updates in real-time."

**4. Analytics View (30 seconds)**
> "Now let's check the Analytics screen. Here you can see:
> - A beautiful pie chart showing spending distribution
> - Food takes up 30% of my expenses
> - Travel is 25%
> - I can switch between different time periods
> - The chart animates smoothly when data changes"

**5. Transaction Management (20 seconds)**
> "Back to the dashboard, I can swipe left on any transaction to delete it. Watch... swipe... confirm... and it's gone! The balance updates automatically."

**6. Other Features (20 seconds)**
> "Let me quickly show you:
> - The Wallet screen with account balances
> - Notifications center
> - Profile settings where users can update their information
> - The Help & Support section with FAQs"

---

### **[9:00 - 9:45] Technical Highlights & Challenges (45 seconds)**

**Speaker 2 (Backend Developer):**

> "Some technical highlights of our implementation:
> - **Data Integrity:** We ensure all calculations are accurate using Dart's decimal precision
> - **Performance:** Efficient data structures and lazy loading for smooth performance
> - **Security:** User data is stored securely with encryption capabilities
> - **Scalability:** Our architecture supports easy migration to cloud storage if needed"

**Speaker 3 (Frontend Developer):**

> "On the frontend:
> - **Responsive Design:** Works seamlessly on different screen sizes
> - **State Management:** Efficient state updates prevent unnecessary rebuilds
> - **User Experience:** Smooth animations and intuitive navigation
> - **Accessibility:** Clear labels and proper contrast ratios"

---

### **[9:45 - 10:00] Conclusion (15 seconds)**

**Speaker 1 (Team Lead):**

> "Thank you for watching our FinTrack presentation! We've demonstrated a fully functional personal finance management application with robust backend architecture, beautiful frontend design, and practical features. Our app helps users take control of their finances with ease. We're happy to answer any questions!"

**[All team members together]:**

> "Thank you!"

---

## 📝 Video Recording Tips

### Before Recording:
1. **Test the app thoroughly** - Ensure all features work smoothly
2. **Prepare sample data** - Have realistic transactions ready
3. **Check screen recording** - Test audio and video quality
4. **Rehearse timing** - Practice to stay within 10 minutes
5. **Prepare backup** - Have a backup device ready

### During Recording:
1. **Clear audio** - Use a good microphone
2. **Screen capture** - Use high-quality screen recording software
3. **Smooth transitions** - Practice switching between speakers
4. **Show code clearly** - Zoom in on important code sections
5. **Demonstrate features** - Actually interact with the app

### Recommended Tools:
- **Screen Recording:** OBS Studio, Camtasia, or built-in screen recorder
- **Video Editing:** DaVinci Resolve, Adobe Premiere, or iMovie
- **Audio:** Audacity for audio cleanup if needed

---

## 👥 Team Member Responsibilities

### Speaker 1 (Team Lead):
- Introduction
- Project overview
- Live demonstration
- Conclusion

### Speaker 2 (Backend Developer):
- Backend architecture explanation
- Data models and persistence
- Authentication flow
- Technical highlights

### Speaker 3 (Frontend Developer):
- Frontend implementation
- Screen-by-screen breakdown
- State management
- UI/UX features

### Speaker 4 (UI/UX Developer):
- Analytics and charts
- Visual design elements
- User experience features
- Accessibility considerations

---

## 🚀 Running the Project

```bash
# Install dependencies
flutter pub get

# Run on connected device/emulator
flutter run

# Build for Android
flutter build apk

# Build for iOS
flutter build ios
```

---

## 📚 Additional Resources

- **SRS Document:** `SRS Fintrack Release Version 5.3.0.pdf`
- **Defense Questions:** `SRE_Defense_Questions.md`
- **Flutter Documentation:** https://docs.flutter.dev/

---

## 📄 License

This project is developed as part of academic coursework for Software Requirement Engineering.

---

**Good luck with your presentation! 🎉**
