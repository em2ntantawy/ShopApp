// @dart=2.9
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/shared/constants.dart';

import '../../models/home_model.dart';

class Products extends StatelessWidget {
  const Products({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopCubit, shopStates>(listener: (context, state) {
      if (state is shopSuccessChangeFavoritesState) {
        if (!state.model.status) {
          showToast(text: state.model.message, state: toastStates.ERROR);
        }
      }
    }, builder: (context, state) {
      return ConditionalBuilder(
        condition: shopCubit.get(context).homeModel != null &&
            shopCubit.get(context).categoriesModel != null,
        builder: (context) => productsBuilder(shopCubit.get(context).homeModel,
            shopCubit.get(context).categoriesModel, context),
        fallback: (context) => Center(child: CircularProgressIndicator()),
      );
    });
  }
}

Widget productsBuilder(
        HomeModel model, CategoriesModel categoryModel, context) =>
    SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model.data.banners
                  .map(
                    (e) => CachedNetworkImage(
                      imageUrl: e.image,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  )
                  .toList(),

              /**
                     * //changed becose loading erorr cose of connection close
                     * .map(
                      (e) => Image(
                        image: NetworkImage(e.image),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    )
                    .toList(),
                     */

              options: CarouselOptions(
                height: 250,
                aspectRatio: 1 / 2,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              )),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildCategoryItem(categoryModel.data.data[index]),
                      separatorBuilder: (context, index) => SizedBox(
                            width: 10,
                          ),
                      itemCount: categoryModel.data.data.length),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Products',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.8,
                children: List.generate(
                    model.data.products.length,
                    (index) =>
                        buildGridProduct(model.data.products[index], context))),
          )
        ],
      ),
    );
Widget buildGridProduct(productModel model, context) => Container(
      color: Colors.white,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image),
                width: double.infinity,
                height: 200,
                // fit: BoxFit.cover,
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, height: 1.3),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: defaultColor),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          shopCubit.get(context).changeFavorites(model.id);
                          print(model.id);
                        },
                        icon: CircleAvatar(
                            radius: 15,
                            backgroundColor:
                                shopCubit.get(context).Favorites[model.id]
                                    ? defaultColor
                                    : Colors.grey,
                            child: Icon(
                              Icons.favorite,
                              size: 14,
                              color: Colors.white,
                            )))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

Widget buildCategoryItem(DataModel model) => Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.image),
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Container(
          width: 100,
          color: Colors.black.withOpacity(.6),
          child: Text(
            model.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
