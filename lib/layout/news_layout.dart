import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:today_news/cubit/cubit.dart';
import 'package:today_news/cubit/states.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key, required this.isDark}) : super(key: key);

  final bool? isDark;

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (BuildContext context) => NewsCubit()..getBusiness()..changeAppMode(fromShared:isDark),
        child: BlocConsumer<NewsCubit, NewsStates>(
          listener: (context, state) => {},
          builder: (context, state) {
            var cubit = NewsCubit.get(context);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: Colors.white,
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: Colors.white,
                  unselectedItemColor: Colors.grey,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  elevation: 20.0,
                ),
                appBarTheme: AppBarTheme(
                  iconTheme: IconThemeData(color: Colors.black),
                  titleTextStyle: TextStyle(
                      color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                ),
              ),
              darkTheme: ThemeData(
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: HexColor('333739'),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: HexColor('333739'),
                  unselectedItemColor: Colors.grey,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  elevation: 20.0,
                ),
                appBarTheme: AppBarTheme(
                  titleSpacing: 20.0,
                  iconTheme: IconThemeData(color: Colors.white),
                  titleTextStyle: TextStyle(
                      color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: HexColor('333739'),
                      statusBarIconBrightness: Brightness.light),
                  backgroundColor: HexColor('333739'),
                  elevation: 0.0,
                ),
              ),
              themeMode:cubit.isDark! ?ThemeMode.dark : ThemeMode.light,
              home: Scaffold(
                body: cubit.screens[cubit.currentIndex],
                appBar: AppBar(
                  titleSpacing: 20.0,
                  title: Text('Today News'),
                  actions: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                    IconButton(
                        onPressed: () {
                          cubit.changeAppMode(fromShared: cubit.isDark);
                        }, icon: Icon(Icons.brightness_4_rounded))
                  ],
                ),

                bottomNavigationBar: BottomNavigationBar(
                  items: cubit.bottomItems,
                  currentIndex: cubit.currentIndex,
                  onTap: (index) {
                    cubit.changeBottomNavBar(index);
                  },
                ),
              ),
            );
          },
        ),
      );
  }
}
