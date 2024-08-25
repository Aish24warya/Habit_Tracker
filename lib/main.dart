import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habittrackerapp/feature/auth/navigatorscreen.dart';
import 'package:habittrackerapp/feature/auth/screens/LoginScreen.dart';
import 'package:habittrackerapp/feature/services/authwrapper.dart';
import 'package:habittrackerapp/theme/themechange.dart';
import 'feature/services/firebase_options.dart';
import 'package:provider/provider.dart';

void main()async{
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
 }
 class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      useInheritedMediaQuery: true,
      splitScreenMode: true,
      designSize: Size(375, 825),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: ThemeMode.system,
        home: AuthenticationWrapper(),
        routes: {
        '/home': (context) => Navigatorscreen(currentIndex: 3,),
        '/login': (context) => Loginscreen(),
      }
          
        ),
    );

  }
}