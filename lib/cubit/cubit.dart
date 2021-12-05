import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_news/cubit/states.dart';
import 'package:today_news/modules/business/business_screen.dart';
import 'package:today_news/modules/science/science_screen.dart';
import 'package:today_news/modules/settings/settings_screen.dart';
import 'package:today_news/modules/sports/sports_screen.dart';
import 'package:today_news/shared/network/local/cache_helper.dart';
import 'package:today_news/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);



  int currentIndex = 0;

  List<Widget> screens = [
    BusinessScreen(),
    ScienceScreen(),
    SportsScreen(),
  ];

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'business'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'science'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'sports'),
  ];

  bool? isDark = false;

   void changeAppMode({required bool? fromShared}){
     if(fromShared != null){
       isDark = fromShared;
     }else{
       isDark = !isDark!;
     }
    CacheHelper.putData('isDark', isDark).then((value){
      emit(AppChangeModeState());
    });
  }

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) {
      getScience();
    } else if (index == 2) {
      getSports();
    } else if (index == 3) {
      //settings
    }
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'AE',
      'category': 'business',
      'apiKey': 'a2d2e598ef064e3e9a4a628ac2cdb815',
    }).then((value) {
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessStateSuccess());
    }).catchError((onError) {
      print(onError);
      emit(NewsGetBusinessStateFail(onError.toString()));
    });
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'AE',
        'category': 'science',
        'apiKey': 'a2d2e598ef064e3e9a4a628ac2cdb815',
      }).then((value) {
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceStateSuccess());
      }).catchError((onError) {
        print(onError);
        emit(NewsGetScienceStateFail(onError.toString()));
      });
    } else {
      emit(NewsGetScienceStateSuccess());
    }
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'AE',
        'category': 'sports',
        'apiKey': 'a2d2e598ef064e3e9a4a628ac2cdb815',
      }).then((value) {
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsStateSuccess());
      }).catchError((onError) {
        print(onError);
        emit(NewsGetSportsStateFail(onError.toString()));
      });
    } else {
      emit(NewsGetSportsStateSuccess());
    }
  }
}
