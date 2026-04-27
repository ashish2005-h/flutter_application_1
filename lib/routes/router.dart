import 'package:flutter_application_1/views/watchlist_screen.dart';
import 'package:flutter_application_1/views/watchlist_edit_sceen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const WatchlistScreen(),
      ),
      GoRoute(
        path: '/edit',
        builder: (context, state) => const EditWatchlistScreen(),
      ),
    ],
  );
}