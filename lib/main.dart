import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recharge_buddy/core/routes/app_routes.dart';
import 'package:recharge_buddy/core/theme/app_theme.dart';
import 'package:recharge_buddy/features/beneficiaries/presentation/cubit/beneficiary_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //This provider has to be accessed globally for the user-story, so it has been added here.
        BlocProvider(
          create: (context) => BeneficiaryCubit(),
        ), // other providers
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        title: 'Recharge Buddy',
        theme: ThemeManager.lightTheme,
      ),
    );
  }
}
