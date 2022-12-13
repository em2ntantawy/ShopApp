import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/Register_model.dart';
import 'package:shop_app/modules/Register/Register.dart';
import 'package:shop_app/modules/Register/states.dart';
import 'package:shop_app/network/endPoints.dart';
import 'package:shop_app/network/remote/dio_helper.dart';

import '../../models/login_model.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  LoginModel model;
  userRegister({
    @required String email,
    @required String password,
    @required String name,
    @required String phone,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
    }).then((value) {
      print(value.data);
      print(value.data['message']);
      model = LoginModel.fromJson(value.data);
      print(model.message);
      print(model.data);
      print(model.status);

      emit(RegisterSuccessState(model));
    }).catchError((error) {
      emit(RegisterErrorState(
        error.toString(),
      ));
      print(error.toString());
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePassword() {
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    isPassword = !isPassword;
    emit(RegisterPasswordState());
  }
}
