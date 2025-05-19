
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:site/presentation/pages/pages.dart';
import 'package:site/presentation/pages/privacy_page.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return  SplashPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: Pages.privacy.name,
          builder: (BuildContext context, GoRouterState state) {
            return PrivacyPage();
          },
        ),
      ],
    ),
  ],
);

enum Pages{
  home(''),
  privacy('/privacy'),

  ;

const  Pages(this.name);
final  String name;
}
