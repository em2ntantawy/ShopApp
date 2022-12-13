import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/modules/login/states.dart';
import 'package:shop_app/network/endPoints.dart';
import 'package:shop_app/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  LoginModel model;
  userLogin({
    @required String email,
    @required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      print(value.data);
      print(value.data['message']);
      model = LoginModel.fromJson(value.data);
      print(model.message);
      print(model.data);
      print(model.status);

      emit(LoginSuccessState(model));
    }).catchError((error) {
      emit(LoginErrorState(
        error.toString(),
      ));
      print(error.toString());
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = false;
  void changePassword() {
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    isPassword = !isPassword;
    emit(LoginPasswordState());
  }
}
