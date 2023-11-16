import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:wysowl/src/features/routes/route_names.dart';
import 'package:wysowl/src/features/screens/home_screen.dart';
import 'package:wysowl/src/features/screens/login_screen.dart';
import 'package:wysowl/src/features/screens/mobile_verification_screen.dart';
import 'package:wysowl/src/features/screens/new_password_screen.dart';
import 'package:wysowl/src/features/screens/otp_verification_screen.dart';
import 'package:wysowl/src/features/screens/sign_up_screen.dart';
import 'package:wysowl/src/features/screens/welcome_screen.dart';

String get initialPath {
  // TODO: Provide the login state

  bool isLoggedIn = false;
  final String initalScreen = isLoggedIn ? '/home' : '/welcome';
  return initalScreen;
}

final GoRouter router = GoRouter(
  initialLocation: initialPath,
  routes: [
    GoRoute(
      name: RouteNames.welcome,
      path: '/welcome',
      pageBuilder: (BuildContext context, GoRouterState state) =>
          const MaterialPage(child: WelcomeScreen()),
    ),
    GoRoute(
      name: RouteNames.login,
      path: '/login',
      pageBuilder: (BuildContext context, GoRouterState state) =>
          const MaterialPage(child: LoginScreen()),
    ),
    GoRoute(
      name: RouteNames.numberVerfication,
      path: '/number_verfication/:route',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        child: MobileVerficationScreen(
          route: state.pathParameters['route']!,
        ),
      ),
    ),
    GoRoute(
      name: RouteNames.otpVerfication,
      path: '/opt_verification/:route/:number',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        child: OtpVerificationScreen(
          route: state.pathParameters['route']!,
          number: state.pathParameters['number']!,
        ),
      ),
    ),
    GoRoute(
      name: RouteNames.signUp,
      path: '/signup/:number',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        child: SignUpScreen(
          number: state.pathParameters['number']!,
        ),
      ),
    ),
    GoRoute(
      name: RouteNames.newPassword,
      path: '/newPassword/:number/:name/:age/:region',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        child: NewPasswordScreen(
          number: state.pathParameters['number']!,
          name: state.pathParameters['name']!,
          age: state.pathParameters['age']!,
          region: state.pathParameters['region']!,
        ),
      ),
    ),
    GoRoute(
      name: RouteNames.home,
      path: '/home',
      pageBuilder: (BuildContext context, GoRouterState state) =>
          const MaterialPage(child: HomeScreen()),
    ),
  ],
);

void popUntil(context, page) {
  final router = GoRouter.of(context);
  final GoRouterDelegate delegate = router.routerDelegate;
  final routes = delegate.currentConfiguration.routes;
  for (var i = 0; i < routes.length; i++) {
    final route = routes[i] as GoRoute;
    if (route.name == page) break;
    try{
      GoRouter.of(context).pop();
    }
    catch (e) {
      GoRouter.of(context).pushNamed(RouteNames.welcome);
    }
  }
}
