import 'package:bloc/bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/app_cubit/app_states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeAppMode({bool save_in_sharedpreference}) {
    if (save_in_sharedpreference != null) {
      isDark = save_in_sharedpreference;
      // emit(AppChangeModeState());
       print('saved' );
    } 
    
    else {
      isDark = !isDark;

      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        print('saved' + value.toString());

        emit(AppChangeModeState());
      });
    }
  }

}
