import 'package:flutter/material.dart';

import 'package:lib/src/features/auth/presentation/views/forgot_password_screen.dart';
import 'package:lib/src/features/auth/presentation/views/login_screen.dart';
import 'package:lib/src/features/auth/presentation/views/phone_entry_screen.dart';
import 'package:lib/src/features/auth/presentation/views/register_screen.dart';
import 'package:lib/src/features/auth/presentation/views/reset_password_screen.dart';
import 'package:lib/src/features/auth/presentation/views/verify_code_screen.dart';
import 'package:lib/src/features/chat/presentation/views/chat_dashboard_screen.dart';
import 'package:lib/src/features/chat/presentation/views/chat_room_screen.dart';
import 'package:lib/src/features/chat/presentation/views/chatbot_management_screen.dart';
import 'package:lib/src/features/history/presentation/views/chat_history_screen.dart';
import 'package:lib/src/features/home/presentation/views/home_shell.dart';
import 'package:lib/src/features/home/presentation/views/welcome_home_screen.dart';
import 'package:lib/src/features/instructions/presentation/views/instructions_screen.dart';
import 'package:lib/src/features/invites/presentation/views/invite_friends_screen.dart';
import 'package:lib/src/features/onboarding/presentation/views/onboarding_screen.dart';
import 'package:lib/src/features/payments/presentation/views/add_card_screen.dart';
import 'package:lib/src/features/payments/presentation/views/card_details_screen.dart';
import 'package:lib/src/features/payments/presentation/views/card_settings_screen.dart';
import 'package:lib/src/features/preferences/presentation/views/preferences_screen.dart';
import 'package:lib/src/features/profile/presentation/views/profile_screen.dart';
import 'package:lib/src/features/services/presentation/views/services_screen.dart';
import 'package:lib/src/features/splash/presentation/views/splash_screen.dart';
import 'package:lib/src/features/subscriptions/presentation/views/subscription_screen.dart';
import 'package:lib/src/features/support/presentation/views/support_screen.dart';

import 'routes.dart';

class AppRouter {
  const AppRouter();

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return _materialRoute(const SplashScreen(), settings);
      case AppRoutes.onboarding:
        return _materialRoute(const OnboardingScreen(), settings);
      case AppRoutes.login:
        return _materialRoute(const LoginScreen(), settings);
      case AppRoutes.register:
        return _materialRoute(const RegisterScreen(), settings);
      case AppRoutes.phoneEntry:
        return _materialRoute(const PhoneEntryScreen(), settings);
      case AppRoutes.verifyPhone:
        return _materialRoute(const VerifyCodeScreen(isPhoneFlow: true), settings);
      case AppRoutes.verifyEmail:
        return _materialRoute(const VerifyCodeScreen(isPhoneFlow: false), settings);
      case AppRoutes.forgotPassword:
        return _materialRoute(const ForgotPasswordScreen(), settings);
      case AppRoutes.resetPassword:
        return _materialRoute(const ResetPasswordScreen(), settings);
      case AppRoutes.home:
        return _materialRoute(const HomeShell(), settings);
      case AppRoutes.welcomeHome:
        return _materialRoute(const WelcomeHomeScreen(), settings);
      case AppRoutes.chatDashboard:
        return _materialRoute(const ChatDashboardScreen(), settings);
      case AppRoutes.chatRoom:
        return _materialRoute(const ChatRoomScreen(), settings);
      case AppRoutes.chatbots:
        return _materialRoute(const ChatbotManagementScreen(), settings);
      case AppRoutes.history:
        return _materialRoute(const ChatHistoryScreen(), settings);
      case AppRoutes.subscriptions:
        return _materialRoute(const SubscriptionScreen(), settings);
      case AppRoutes.addCard:
        return _materialRoute(const AddCardScreen(), settings);
      case AppRoutes.cardDetails:
        return _materialRoute(const CardDetailsScreen(), settings);
      case AppRoutes.cardSettings:
        return _materialRoute(const CardSettingsScreen(), settings);
      case AppRoutes.services:
        return _materialRoute(const ServicesScreen(), settings);
      case AppRoutes.preferences:
        return _materialRoute(const PreferencesScreen(), settings);
      case AppRoutes.profile:
        return _materialRoute(const ProfileScreen(), settings);
      case AppRoutes.support:
        return _materialRoute(const SupportScreen(), settings);
      case AppRoutes.invites:
        return _materialRoute(const InviteFriendsScreen(), settings);
      case AppRoutes.instructions:
        return _materialRoute(const InstructionsScreen(), settings);
      default:
        return _materialRoute(const SplashScreen(), settings);
    }
  }

  Route<dynamic> _materialRoute(Widget page, RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => page, settings: settings);
  }
}
