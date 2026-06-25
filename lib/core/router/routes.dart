/// Importing necessary packages and modules.
library routes;

import 'package:ekang_flutter/core/di/injection.dart';
import 'package:ekang_flutter/core/router/router_utils.dart';
import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:ekang_flutter/features/library/library.dart';
import 'package:ekang_flutter/features/notifications/notifications.dart';
import 'package:fimber/fimber.dart';

import '../../features/main/main.dart';
import '../../features/quiz/quiz.dart';
import '../../features/splashcreen/splashscreen.dart';

/// The Router class is responsible for generating routes for the application.
class Router {
  /// The generateRoute method is responsible for generating routes based on the routeSettings.
  /// It returns a Route<dynamic> object which can be used by the Navigator to navigate to the appropriate page.
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    Fimber.d("generateRoute | route : ${routeSettings.name}");

    // Extracting the arguments from the routeSettings.
    dynamic args = routeSettings.arguments;

    switch (routeSettings.name) {
      /// If the route name is '/', navigate to the SplashPage.
      case '/':
        return RouterUtils.buildRoute(const SplashScreenPage());

      /// If the route name is MainPage.routeName, navigate to the MainPage.
      case MainPage.routeName:
        return RouterUtils.buildRouteGeneric3<MainBloc, LibraryBloc,
                NotificationsBloc>(
            blockForBloc1: () => getIt<MainBloc>()..add(GetCategories()),
            blockForBloc2: () => getIt<LibraryBloc>()..add(GetCsvLibrary()),
            blockForBloc3: () => getIt<NotificationsBloc>()..add(NotificationsEvent()),
            child: const MainPage());

      /// If the route name is QuizPage.routeName, navigate to the QuizPage.
      case QuizPage.routeName:
        return RouterUtils.buildRouteGeneric<QuizBloc>(
            block: () => getIt<QuizBloc>()..add(LoadQuizChooserEvent()),
            child: const QuizPage());

      /// If the route name is SettingsPage.routeName, navigate to the Settings page.
      /*case SettingsPage.routeName:
        return RouterUtils.buildRoute(const SettingsWidget());*/

      /// If the route name does not match any of the above, return a default route.
      default:
        return RouterUtils.buildRoute(
          Scaffold(
            body: Center(
              child: Text('No route defined for ${routeSettings.name}'),
            ),
          ),
        );
    }
  }
}
