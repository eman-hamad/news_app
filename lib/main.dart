import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'layout/app_cubit/app_cubit.dart';
import 'layout/app_cubit/app_states.dart';
import 'layout/cubit/cubit.dart';
import 'layout/home_layout.dart';
import 'package:hexcolor/hexcolor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //ensure that every line in main completed first then run app
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.getData(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              AppCubit()..changeAppMode(save_in_sharedpreference: isDark),
        ),
        BlocProvider(
          create: (BuildContext context) => NewsCubit(),
          // you can get data when press on navbaritem of it or  gain all data when app open at same time by:
          //create: (BuildContext context) => NewsCubit()..getBusinessData()..getSportsData()..getScienceData(),),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            appBarTheme: AppBarTheme(
              titleSpacing: 20.0,
              color: Colors.white,
              elevation: 0.0,
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarBrightness: Brightness.dark,
              ),
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.white,
              selectedItemColor: Colors.amber[900],
              unselectedItemColor: Colors.grey[600],
              elevation: 20.0,
              type: BottomNavigationBarType.fixed,
            ),
            // floatingActionButtonTheme: FloatingActionButtonThemeData(
            //     backgroundColor: Colors.deepOrange),
            scaffoldBackgroundColor: Colors.white,
            textTheme: TextTheme(
              bodyText1: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          darkTheme: ThemeData(
            scaffoldBackgroundColor: Colors.black,

            primarySwatch: Colors.deepOrange,
            appBarTheme: AppBarTheme(
              // color: HexColor('333739'),
              titleSpacing: 20.0,
              color: Colors.black,
              elevation: 0.0,
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: HexColor('333739'),
                statusBarBrightness: Brightness.dark,
              ),
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.black,
              selectedItemColor: Colors.amber[900],
              unselectedItemColor: Colors.grey[400],
              
              elevation: 20.0,
              type: BottomNavigationBarType.fixed,
            ),
            //   floatingActionButtonTheme:
            //       FloatingActionButtonThemeData(backgroundColor: Colors.deepOrange),
            //    scaffoldBackgroundColor: Colors.white,
            // ),
            textTheme: TextTheme(
              bodyText1: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          themeMode:
              AppCubit.get(context).isDark ? ThemeMode.light : ThemeMode.dark,
          // if is Dark is true "have value"
          home: HomeLayout(),
        ),
      ),
    );
  }
}
