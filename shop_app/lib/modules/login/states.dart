import 'package:shop_app/models/login_model.dart';

import '../../models/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final LoginModel model;

  LoginSuccessState(this.model);

  ///something wrong here
}

class LoginErrorState extends LoginStates {
  final String error;
  LoginErrorState(this.error);
}

class LoginPasswordState extends LoginStates {}
