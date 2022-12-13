import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/changeFavoritesModel.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/screens/categories.dart';
import 'package:shop_app/modules/screens/favorites.dart';
import 'package:shop_app/modules/screens/products.dart';
import 'package:shop_app/modules/screens/settings.dart';
import 'package:shop_app/network/endPoints.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/shared/constants.dart';

import '../models/login_model.dart';

class shopCubit extends Cubit<shopStates> {
  shopCubit() : super(shopInitialState());
  static shopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreens = [
    Products(),
    categories(),
    favorites(),
    settings()
  ];
  void changeBottomNav(int index) {
    currentIndex = index;
    emit(shopChangeBottomNavState());
  }

  HomeModel homeModel;
  Map<int, bool> Favorites = {};

  void getHomeData() {
    emit(shopLoadingHomeDataState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      for (var element in homeModel.data.products) {
        Favorites.addAll({element.id: element.inFavorite});
      }
      // homeModel!.data.products.forEach((element) {
      //   Favorites.addAll({element.id: element.inFavorite});
      //   print(Favorites.toString());
      // });
      // printFullText(homeModel!.data.banners.toString());
      // printFullText('home model banners test ${homeModel!.toString()}');

      print(homeModel.toString());
      emit(shopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(shopErrorHomeDataState());
    });
  }

  CategoriesModel categoriesModel;
  void getCategories() {
    DioHelper.getData(
      url: CATEGORIES,
      //token: token/// what is this
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      print(categoriesModel.toString());
      emit(shopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(shopErrorCategoriesState());
    });
  }

  FavoritesModel favoritesModel;
  void getFavorites() {
    emit(shopLoadingGetFavoritesState());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      printFullText(value.data.toString());
      print(favoritesModel.toString());
      emit(shopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(shopErrorGetFavoritesState());
    });
  }

  ChangeFavoritesModel changeFavoritesModel;
  void changeFavorites(int productId) {
    Favorites[productId] = !Favorites[productId];
    emit(shopChangeFavoritesState());
    DioHelper.postData(
            url: FAVORITES,
            data: {
              'product_id': productId,
            },
            token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if (changeFavoritesModel.status == false) {
        Favorites[productId] = !Favorites[productId];
      } else {
        getFavorites();
      }
      emit(shopSuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((error) {
      print(error.toString());
      if (changeFavoritesModel.status == false) {
        Favorites[productId] = !Favorites[productId];
      }
      emit(shopErrorChangeFavoritesState());
    });
  }

  LoginModel UserModel;
  void getSettings() {
    emit(shopLoadingUserDataState());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      UserModel = LoginModel.fromJson(value.data);
      printFullText(value.data.toString());
      print(UserModel.toString());
      emit(shopSuccessUserDataState(UserModel));
    }).catchError((error) {
      print(error.toString());
      emit(shopErrorUserDataState());
    });
  }

  //LoginModel UpdateUserModel;
  void UpdateUserData({
    @required String name,
    @required String email,
    @required String phone,
  }) {
    emit(shopLoadingUpdateUserDataState());
    DioHelper.putData(
        url: UPDATE,
        token: token,
        data: {'name': name, 'email': email, 'phone': phone}).then((value) {
      UserModel = LoginModel.fromJson(value.data);
      printFullText(value.data.toString());
      print(UserModel.toString());
      emit(shopSuccessUpdateUserDataState(UserModel));
    }).catchError((error) {
      print(error.toString());
      emit(shopErrorUpdateUserDataState());
    });
  }
}
