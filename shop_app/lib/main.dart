import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/cubit/bloc_observer.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/layout.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/modules/onBoarding/onboarding.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/styles/themes.dart';

import 'network/remote/dio_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  //bool isDark = CacheHelper.getData(key: 'isDark');
  bool onBoarding = CacheHelper.getBoolean(key: 'onBoarding');
  print(onBoarding);

  String token = CacheHelper.getData(key: 'token');
  print(token);
  Widget startWidget;

  if (onBoarding != false) {
    if (token != null)
      startWidget = shopLayout();
    else {
      startWidget = Login();
    }
  } else {
    startWidget = onBoardingScreen();
  }
  print(onBoarding);

  runApp(MyApp(startWidget));

  // Use cubits...

  blocObserver:
  MyBlocObserver();
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp(this.startWidget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => shopCubit()
        ..getHomeData()
        ..getCategories()
        ..getFavorites()
        ..getSettings(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: darkTheme,
        darkTheme: lightTheme,
        home: startWidget,
        //  themeMode: changeAppMode.isDark
        //      ? ThemeMode.dark
        //      : ThemeMode.light,
      ),
    );
  }
}

bool isDark = false;
void changeAppMode({bool fromShared}) {
  if (fromShared != null)
    isDark = fromShared;
  else
    isDark = !isDark;
  CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
    // emit(AppChangeModeState());
  });
  print(isDark);
}
