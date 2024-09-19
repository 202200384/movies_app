
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/Ui/MovieDetails(homeTab)/movie_details_screen.dart';
import 'package:movies_app/Ui/SplashSceen/splash_screen.dart';
import 'package:movies_app/Ui/Utils/my_theme_data.dart';
import 'package:movies_app/Ui/homeScreen/home_screen.dart';
import 'package:movies_app/Ui/tabs/BrowserTab/Widget/browser_tab_screen.dart';
import 'package:movies_app/Ui/tabs/HomeTab/Widgets/homeTab.dart';
import 'package:movies_app/Ui/tabs/SearchTab/search_screen_tab.dart';
import 'package:movies_app/Ui/tabs/WatchTab/watch_list_Tab.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 892),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: HomeScreen.routeName,
          routes: {
            HomeScreen.routeName: (context) => HomeScreen(),
            SplashScreen.routeName: (context) => SplashScreen(),
            HomeTab.routeName: (context) => HomeTab(),
            SearchScreenTab.routeName: (context) =>SearchScreenTab(),
            WatchlistTab.routeName: (context) => WatchlistTab(),
            BrowserTabScreen.routeName: (context) =>BrowserTabScreen(),
            MovieDetailsScreen.routeName:(context) =>MovieDetailsScreen(
                movieId:ModalRoute.of(context)!.settings.arguments as int)
          },
          theme: MyThemeData.lightTheme,
        );
      },
    );
  }
}