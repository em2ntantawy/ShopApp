import 'package:shop_app/models/Register_model.dart';

import '../../models/login_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final LoginModel model;

  RegisterSuccessState(this.model);

  ///something wrong here
}

class RegisterErrorState extends RegisterStates {
  final String error;
  RegisterErrorState(this.error);
}

class RegisterPasswordState extends RegisterStates {}
