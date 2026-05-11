import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'route_names.dart';
import '../../features/auth/presentation/pages/splash_screen.dart';
import '../../features/auth/presentation/pages/sign_in_screen.dart';
import '../../features/dashboard/presentation/pages/main_shell.dart';
import '../../features/requests/presentation/pages/pending_requests_page.dart';
import '../../features/requests/presentation/pages/request_detail_page.dart';
import '../../features/results/presentation/pages/upload_results_page.dart';
import '../../features/analytics/presentation/pages/analytics_page.dart';
import '../../features/technicians/presentation/pages/technicians_list_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/settings/presentation/pages/test_catalog_page.dart';
import '../../features/requests/data/models/lab_request_model.dart';

import '../../features/results/presentation/pages/simplified_upload_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/sign-in',
        name: RouteNames.signIn,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        name: RouteNames.dashboard,
        builder: (context, state) => const MainShell(),
      ),
      GoRoute(
        path: '/pending-requests',
        name: RouteNames.pendingRequests,
        builder: (context, state) => const PendingRequestsPage(),
      ),
      GoRoute(
        path: '/request-detail',
        name: RouteNames.requestDetail,
        builder: (context, state) {
          final request = state.extra as LabRequest;
          return RequestDetailPage(request: request);
        },
      ),
      GoRoute(
        path: '/upload-results',
        name: RouteNames.uploadResults,
        builder: (context, state) {
          final request = state.extra as LabRequest;
          return UploadResultsPage(request: request);
        },
      ),
      GoRoute(
        path: '/simplified-upload',
        name: RouteNames.simplifiedUpload,
        builder: (context, state) => const SimplifiedUploadPage(),
      ),
      GoRoute(
        path: '/analytics',
        name: RouteNames.analytics,
        builder: (context, state) => const AnalyticsPage(),
      ),
      GoRoute(
        path: '/technicians',
        name: RouteNames.technicians,
        builder: (context, state) => const TechniciansListPage(),
      ),
      GoRoute(
        path: '/settings',
        name: RouteNames.settings,
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: '/test-catalog',
        name: 'test_catalog',
        builder: (context, state) => const TestCatalogPage(),
      ),
    ],
  );
});
