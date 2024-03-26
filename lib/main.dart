import 'package:chat_gpt_task/features/OnBoarding/on_boarding_screen.dart';
import 'package:chat_gpt_task/shared/providers/chats_provider.dart';
import 'package:chat_gpt_task/shared/providers/models_provider.dart';
import 'package:chat_gpt_task/shared/style/enum/enum.dart';
import 'package:chat_gpt_task/shared/style/themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ScreenUtil.ensureScreenSize();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('isDark $isDark');
    }
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ModelsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
      ],
      child: ScreenUtilInit(
          designSize: ScreenUtil.defaultSize,
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              title: 'Chat GPT',
              theme: getThemeData[AppTheme.lightTheme],
              darkTheme: getThemeData[AppTheme.darkTheme],
              themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home: const OnBoardingScreen(),
            );
          }),
    );
  }
}
