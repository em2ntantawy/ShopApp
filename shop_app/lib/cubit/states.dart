import 'package:shop_app/models/changeFavoritesModel.dart';
import 'package:shop_app/models/login_model.dart';

abstract class shopStates {}

class shopInitialState extends shopStates {}

class shopChangeBottomNavState extends shopStates {}

class shopLoadingHomeDataState extends shopStates {}

class shopSuccessHomeDataState extends shopStates {}

class shopErrorHomeDataState extends shopStates {}

class shopSuccessCategoriesState extends shopStates {}

class shopErrorCategoriesState extends shopStates {}

class shopChangeFavoritesState extends shopStates {}

class shopSuccessChangeFavoritesState extends shopStates {
  final ChangeFavoritesModel model;

  shopSuccessChangeFavoritesState(this.model);
}

class shopErrorChangeFavoritesState extends shopStates {}

class shopLoadingGetFavoritesState extends shopStates {}

class shopSuccessGetFavoritesState extends shopStates {}

class shopErrorGetFavoritesState extends shopStates {}

class shopLoadingUserDataState extends shopStates {}

class shopSuccessUserDataState extends shopStates {
  LoginModel loginModel;

  shopSuccessUserDataState(this.loginModel);
}

class shopErrorUserDataState extends shopStates {}

class shopLoadingUpdateUserDataState extends shopStates {}

class shopSuccessUpdateUserDataState extends shopStates {
  LoginModel loginModel;

  shopSuccessUpdateUserDataState(this.loginModel);
}

class shopErrorUpdateUserDataState extends shopStates {}
