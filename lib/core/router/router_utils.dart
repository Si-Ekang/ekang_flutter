import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

class RouterUtils {
  static final RouterUtils _singleton = RouterUtils._();

  factory RouterUtils() => _singleton;

  RouterUtils._();

  /// The _buildRouteGeneric method is a helper method that creates a MaterialPageRoute with a BlocProvider for the given Cubit(s).
  static MaterialPageRoute _buildRouteGeneric(
    List<SingleChildWidget> blocProviders,
    Widget child,
  ) {
    return MaterialPageRoute(builder: (_) {
      return MultiBlocProvider(
        providers: blocProviders,
        child: child,
      );
    });
  }

  /// The _buildRouteGeneric method is a helper method that creates a MaterialPageRoute with a BlocProvider for the given Cubit(s).
  static MaterialPageRoute
      buildRouteGeneric3<B extends Bloc, C extends Bloc, D extends Bloc>({
    required Function() blockForBloc1,
    required Function() blockForBloc2,
    required Function() blockForBloc3,
    required Widget child,
  }) =>
          _buildRouteGeneric(
            [
              BlocProvider<B>(create: (context) => blockForBloc1()),
              BlocProvider<C>(create: (context) => blockForBloc2()),
              BlocProvider<D>(create: (context) => blockForBloc3())
            ],
            child,
          );

  /// The _buildRouteGeneric method is a helper method that creates a MaterialPageRoute with a BlocProvider for the given Cubit(s).
  static MaterialPageRoute buildRouteGeneric2<B extends Bloc, C extends Bloc>({
    required Function() blockForBloc1,
    required Function() blockForBloc2,
    required Widget child,
  }) =>
      _buildRouteGeneric(
        [
          BlocProvider<B>(create: (context) => blockForBloc1()),
          BlocProvider<C>(create: (context) => blockForBloc2())
        ],
        child,
      );

  /// The _buildRouteGeneric method is a helper method that creates a MaterialPageRoute with a BlocProvider for the given Cubit(s).
  static MaterialPageRoute buildRouteGeneric<B extends Bloc>({
    required Function() block,
    required Widget child,
  }) =>
      _buildRouteGeneric(
        [BlocProvider<B>(create: (context) => block())],
        child,
      );

  ///  The _buildRoute method is a helper method that creates a MaterialPageRoute with the given child widget.
  static MaterialPageRoute buildRoute(Widget child) => MaterialPageRoute(
        builder: (_) => child,
      );
}
