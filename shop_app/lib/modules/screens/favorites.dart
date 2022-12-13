// @dart=2.9
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:shop_app/models/favorites_model.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../shared/components.dart';
import '../../shared/constants.dart';

class favorites extends StatelessWidget {
  const favorites({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopCubit, shopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: state is! shopLoadingGetFavoritesState,
            builder: (context) => ListView.separated(
              itemBuilder: (context, index) => buildListProduct(
                  shopCubit
                      .get(context)
                      .favoritesModel
                      .data
                      .data[index]
                      .product,
                  context),
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  height: 1,
                  color: Colors.black,
                ),
              ),
              itemCount: shopCubit.get(context).favoritesModel.data.data.length,
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        });
  }
}
