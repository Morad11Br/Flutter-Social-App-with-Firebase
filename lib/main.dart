import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_app/layout/social_layout.dart';

import './network/cache_helper.dart';
import './network/dio_helper.dart';
import './styles/themes.dart';
import 'components/constants.dart';
import 'cubit/bloc_observer.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'package:firebase_core/firebase_core.dart';

import 'modules/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  Diohelper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.getData(key: 'isDark');
  // bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  uId = CacheHelper.getData(key: 'uId');
  // print('TOKEN = $token');
  Widget widget;
  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = LoginScreen();
  }
  // if (onBoarding != null) {
  //   if (token != null) {
  //     widget = ShopLayout();
  //   } else
  //     widget = LoginScreen();
  // } else
  //   widget = OnBoardingScreen();
  runApp(
    MyApp(
      isDark: isDark,
      startWidget: widget,
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  const MyApp({this.isDark, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialCubit()
        ..getUserData()
        ..getPosts(),
      // ..changeAppTheme(fromShared: isDark),
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, states) {},
        builder: (context, states) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
