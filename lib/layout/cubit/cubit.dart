import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/settings/settings_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  int current = 0;
  List<BottomNavigationBarItem> bottom_nav_items = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business_center,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports_baseball,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science_rounded,
      ),
      label: 'Sience',
    ),
    // BottomNavigationBarItem(
    //   icon: Icon(
    //     Icons.settings,
    //   ),
    //   label: 'Settings',
    // ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen(),
  ];

  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  void changeBottomNavItem(int index) {
    current = index;
    if (index == 0) {
      getBusinessData();
    } else if (index == 1) {
      getSportsData();
    } else if (index == 2) {
      getScienceData();
    }

    emit(NewsBottomNavState());
  }

  List<dynamic> business_data = [];

  void getBusinessData() {
    emit(NewsGetBusinessLoadingState());
    if (business_data.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query_parameters: {
          'country': 'eg',
          'category': 'business',
          'apiKey': 'abffe2c097c04e43a9ee223118129a1f'
        },
      ).then((value) {
        //print(value.data['articles'][0]['source']['name'].toString());
        business_data = value.data['articles'];
        emit(NewsGetBusinessSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetBusinessErorrState(error.toString()));
      });
    } else {
      emit(NewsGetBusinessSuccessState());
    }
  }

  List<dynamic> sports_data = [];

  void getSportsData() {
    emit(NewsGetSportsLoadingState());

    if (sports_data.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query_parameters: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': 'abffe2c097c04e43a9ee223118129a1f'
        },
      ).then((value) {
        print(value.data['articles'][0]['source']['name'].toString());
        sports_data = value.data['articles'];
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErorrState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science_data = [];

  void getScienceData() {
    emit(NewsGetScienceLoadingState());

    if (science_data.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query_parameters: {
          'country': 'eg',
          'category': 'science',
          'apiKey': 'abffe2c097c04e43a9ee223118129a1f'
        },
      ).then((value) {
        print(value.data['articles'][0]['source']['name'].toString());
        science_data = value.data['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSciencesErorrState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search_data = [];

  void getSearchData(String value) {
    emit(NewsGetSearchLoadingState());
    search_data = [];

    if (search_data.length == 0) {
      DioHelper.getData(
        url: 'v2/everything',
        query_parameters: {
          'q': '${value}',
          'apiKey': 'abffe2c097c04e43a9ee223118129a1f'
        },
      ).then((value) {
        print(value.data['articles'][0]['source']['name'].toString());
        search_data = value.data['articles'];
        emit(NewsGetSearchSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSearchErorrState(error.toString()));
      });
    } else {
      emit(NewsGetSearchSuccessState());
    }
  }
}
