import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';

class categories extends StatelessWidget {
  const categories({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopCubit, shopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
              itemBuilder: (context, index) => buildCatItem(
                  shopCubit.get(context).categoriesModel.data.data[index]),
              separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      height: 1,
                      color: Colors.black,
                    ),
                  ),
              itemCount:
                  shopCubit.get(context).categoriesModel.data.data.length);
        });
  }
}

Widget buildCatItem(DataModel model) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(model.image),
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            model.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
