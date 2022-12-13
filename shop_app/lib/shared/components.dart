import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/on_boarding_model.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/cubit/cubit.dart';

Widget BuildBoardingItem(onBoardingModel model) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Image(image: AssetImage('${model.image}'))),
        SizedBox(
          height: 30,
        ),
        Text(
          '${model.title}',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          '${model.body}',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      ],
    );
void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => widget), (route) {
      return false;
    });

navigateTo(
  context,
  Widget,
) =>
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Widget),
    );

Widget buildListProduct(model, context) => Container(
      height: 150,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
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
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, height: 1.3),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price.toString()}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12, color: defaultColor),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice.toString()}',
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
      ),
    );
