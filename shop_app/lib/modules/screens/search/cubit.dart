import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/screens/search/states.dart';
import 'package:shop_app/network/endPoints.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/shared/constants.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel model;
  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(url: SEARCH, token: token, data: {'text': text})
        .then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccesslState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
