import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:recharge_buddy/features/beneficiaries/data/model/beneficiary_model.dart';
import 'package:recharge_buddy/features/beneficiaries/presentation/screens/widgets/add_beneficiary_screen.dart';
import '../../features/home/presentation/screens/home.dart';

class AppRouter {
  // all the route paths. So that we can access them easily  across the app
  static const root = '/';
  static const String beneficiaryFormRoute = '/beneficiaryForm';

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static BuildContext get context => _rootNavigatorKey.currentContext!;

  // push
  static Future<void> push(String path,
      {dynamic extra, BuildContext? context}) async {
    await GoRouter.of(context ?? _rootNavigatorKey.currentContext!).push(
      path,
      extra: extra,
    );
  }

  // until
  static Future<void> pushUntil(String path, {dynamic extra}) async {
    GoRouter.of(_rootNavigatorKey.currentContext!).pushReplacement(
      path,
      extra: extra,
    );
  }

  static GoRouter get router => _router;

  //get root navigator key
  static GlobalKey<NavigatorState> get rootNavigatorKey => _rootNavigatorKey;

  /// use this in [MaterialApp.router]
  static final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
          path: root,
          builder: (context, state) {
            return const Home();
          }),
      GoRoute(
          path: beneficiaryFormRoute,
          builder: (context, state) {
            final BeneficiaryModel?  beneficiaryModel = state.extra as BeneficiaryModel?;
            return BeneficiaryForm(
              beneficiaryModel: beneficiaryModel,
            );
          }),
    ],
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
  );
}
