import 'package:flutter/material.dart';

import '../../features/auth/presentation/views/forgot_password_screen.dart';
import '../../features/auth/presentation/views/login_screen.dart';
import '../../features/auth/presentation/views/phone_entry_screen.dart';
import '../../features/auth/presentation/views/register_screen.dart';
import '../../features/auth/presentation/views/reset_password_screen.dart';
import '../../features/auth/presentation/views/verify_code_screen.dart';
import '../../features/chat/presentation/views/chat_dashboard_screen.dart';
import '../../features/chat/presentation/views/chat_room_screen.dart';
import '../../features/chat/presentation/views/chatbot_management_screen.dart';
import '../../features/history/presentation/views/chat_history_screen.dart';
import '../../features/home/presentation/views/home_shell.dart';
import '../../features/home/presentation/views/welcome_home_screen.dart';
import '../../features/instructions/presentation/views/instructions_screen.dart';
import '../../features/invites/presentation/views/invite_friends_screen.dart';
import '../../features/onboarding/presentation/views/onboarding_screen.dart';
import '../../features/payments/presentation/views/add_card_screen.dart';
import '../../features/payments/presentation/views/card_details_screen.dart';
import '../../features/payments/presentation/views/card_settings_screen.dart';
import '../../features/preferences/presentation/views/preferences_screen.dart';
import '../../features/profile/presentation/views/profile_screen.dart';
import '../../features/services/presentation/views/services_screen.dart';
import '../../features/splash/presentation/views/splash_screen.dart';
import '../../features/subscriptions/presentation/views/subscription_screen.dart';
import '../../features/support/presentation/views/support_screen.dart';

import 'routes.dart';

class AppRouter {
  const AppRouter();

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return _buildRoute(const SplashScreen(), settings);
      case AppRoutes.onboarding:
        return _buildRoute(const OnboardingScreen(), settings);
      case AppRoutes.login:
        return _buildRoute(const LoginScreen(), settings);
      case AppRoutes.register:
        return _buildRoute(const RegisterScreen(), settings);
      case AppRoutes.phoneEntry:
        return _buildRoute(const PhoneEntryScreen(), settings);
      case AppRoutes.verifyPhone:
        return _buildRoute(const VerifyCodeScreen(isPhoneFlow: true), settings);
      case AppRoutes.verifyEmail:
        return _buildRoute(const VerifyCodeScreen(isPhoneFlow: false), settings);
      case AppRoutes.forgotPassword:
        return _buildRoute(const ForgotPasswordScreen(), settings);
      case AppRoutes.resetPassword:
        return _buildRoute(const ResetPasswordScreen(), settings);
      case AppRoutes.home:
        return _buildRoute(const HomeShell(), settings);
      case AppRoutes.welcomeHome:
        return _buildRoute(const WelcomeHomeScreen(), settings);
      case AppRoutes.chatDashboard:
        return _buildRoute(const ChatDashboardScreen(), settings);
      case AppRoutes.chatRoom:
        return _buildRoute(const ChatRoomScreen(), settings);
      case AppRoutes.chatbots:
        return _buildRoute(const ChatbotManagementScreen(), settings);
      case AppRoutes.history:
        return _buildRoute(const ChatHistoryScreen(), settings);
      case AppRoutes.subscriptions:
        return _buildRoute(const SubscriptionScreen(), settings);
      case AppRoutes.addCard:
        return _buildRoute(const AddCardScreen(), settings);
      case AppRoutes.cardDetails:
        return _buildRoute(const CardDetailsScreen(), settings);
      case AppRoutes.cardSettings:
        return _buildRoute(const CardSettingsScreen(), settings);
      case AppRoutes.services:
        return _buildRoute(const ServicesScreen(), settings);
      case AppRoutes.preferences:
        return _buildRoute(const PreferencesScreen(), settings);
      case AppRoutes.profile:
        return _buildRoute(const ProfileScreen(), settings);
      case AppRoutes.support:
        return _buildRoute(const SupportScreen(), settings);
      case AppRoutes.invites:
        return _buildRoute(const InviteFriendsScreen(), settings);
      case AppRoutes.instructions:
        return _buildRoute(const InstructionsScreen(), settings);
      default:
        return _buildRoute(const SplashScreen(), settings);
    }
  }

  PageRouteBuilder<dynamic> _buildRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder<dynamic>(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 320),
      reverseTransitionDuration: const Duration(milliseconds: 240),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(0, 0.04),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutQuad));
        final fade = CurvedAnimation(parent: animation, curve: Curves.easeOut);
        return FadeTransition(
          opacity: fade,
          child: SlideTransition(position: offsetAnimation, child: child),
        );
      },
    );
  }
}
