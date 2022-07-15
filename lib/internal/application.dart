import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quotex/internal/pages/splash_screen/splash_screen.dart';
import 'package:quotex/internal/pages/workspace.dart';
import 'package:quotex/internal/services/settings.dart';
import 'package:quotex/internal/utils/infrastructure.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, _) => MaterialApp(
        title: Settings.appName,
        theme: ThemeData(
          scaffoldBackgroundColor: backgroundColor,
          fontFamily: 'Arial',
        ),
        onGenerateRoute: (routeSettings) {
          Route? route;

          switch (routeSettings.name) {
            case '/':
              route = MaterialPageRoute(builder: (context) => const SplashScreen());
              break;
            case '/workspace':
              route = MaterialPageRoute(builder: (context) => const Workspace());
              break;
          }

          return route;
        },
      ),
    );
  }
}
