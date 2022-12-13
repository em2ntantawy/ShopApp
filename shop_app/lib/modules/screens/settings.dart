import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/shared/constants.dart';

import '../../network/local/cache_helper.dart';
import '../../shared/components.dart';
import '../login/bloc.dart';
import '../login/login.dart';

class settings extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopCubit, shopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = shopCubit.get(context).UserModel;
        nameController.text = model.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;
        return ConditionalBuilder(
          condition: shopCubit.get(context).UserModel != null,
          builder: (context) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is shopLoadingUpdateUserDataState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: nameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                          label: Text('Name')),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'name must not be empty';
                        }
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                          label: Text('Email address')),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Email must not be empty';
                        }
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.phone),
                          label: Text('Phone')),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Phone must not be empty';
                        }
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextButton(
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          shopCubit.get(context).UpdateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                              );
                        }
                      },
                      child: Container(
                          color: defaultColor,
                          height: 50,
                          width: double.infinity,
                          child: Center(
                              child: Text(
                            ' UPDATE',
                            style: TextStyle(color: Colors.white),
                          ))),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextButton(
                      onPressed: () {
                        CacheHelper.RemoveData(key: 'token').then((value) {
                          if (value) {
                            navigateAndFinish(context, Login());
                          }
                        });
                      },
                      child: Container(
                          color: defaultColor,
                          height: 50,
                          width: double.infinity,
                          child: Center(
                              child: Text(
                            'LOG OUT',
                            style: TextStyle(color: Colors.white),
                          ))),
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
