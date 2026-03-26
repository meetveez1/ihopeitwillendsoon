import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/news/presentation/news_detail_screen.dart';
import '../../features/onboarding/presentation/interface_choice_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/onboarding/presentation/role_choice_screen.dart';
import '../../features/onboarding/presentation/theme_choice_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../../features/settings/providers/settings_provider.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final settings = ref.watch(settingsProvider).settings;

  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
      GoRoute(path: '/welcome', builder: (_, __) => const OnboardingScreen()),
      GoRoute(path: '/role', builder: (_, __) => const RoleChoiceScreen()),
      GoRoute(path: '/interface', builder: (_, __) => const InterfaceChoiceScreen()),
      GoRoute(path: '/theme', builder: (_, __) => const ThemeChoiceScreen()),
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/register', builder: (_, __) => const RegisterScreen()),
      GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
      GoRoute(path: '/news/:id', builder: (_, state) => NewsDetailScreen(newsId: state.pathParameters['id']!)),
    ],
    redirect: (_, state) {
      final atSplash = state.uri.path == '/splash';
      if (atSplash) return null;

      final done = settings.onboardingCompleted;
      final logged = settings.loggedIn;

      if (!done && state.uri.path != '/welcome' && state.uri.path != '/role' && state.uri.path != '/interface' && state.uri.path != '/theme') {
        return '/welcome';
      }

      if (done && !logged && state.uri.path != '/login' && state.uri.path != '/register') {
        return '/login';
      }

      if (logged && (state.uri.path == '/login' || state.uri.path == '/register' || state.uri.path == '/welcome')) {
        return '/home';
      }

      return null;
    },
  );
});
