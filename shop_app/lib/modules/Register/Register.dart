import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/Register/bloc.dart';
import 'package:shop_app/modules/Register/states.dart';
import 'package:shop_app/modules/login/login.dart';

import '../../layout.dart';
import '../../network/local/cache_helper.dart';
import '../../shared/components.dart';
import '../../shared/constants.dart';
import '../login/bloc.dart';
import '../login/states.dart';

class Register extends StatelessWidget {
  //const Register({Key key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {
        if (state is RegisterSuccessState) {
          if (state.model.status) {
            print(state.model.message);
            print(state.model.data.token);
            CacheHelper.saveData(
              key: 'token',
              value: state.model.data.token,
            ).then(
              (value) {
                token = state.model.data.token;
                navigateAndFinish(context, shopLayout());
              },
            );
            showToast(text: state.model.message, state: toastStates.SUCCESS);
          } else {
            print(state.model.message);
            showToast(text: state.model.message, state: toastStates.ERROR);
          }
        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('REGISTER',
                        style: Theme.of(context).textTheme.headline5),
                    SizedBox(
                      height: 30,
                    ),
                    Text('Register now to browse our hot offers',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Colors.grey)),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: nameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                          label: Text('User Name')),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'please enter your name';
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
                          label: Text('Email')),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'please enter your email address';
                        }
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      obscureText: RegisterCubit.get(context).isPassword,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: InkWell(
                              onTap: () =>
                                  RegisterCubit.get(context).changePassword(),
                              child: Icon(RegisterCubit.get(context).suffix)),
                          label: Text('Password')),
                      onFieldSubmitted: (value) {
                        if (formKey.currentState.validate()) {
                          RegisterCubit.get(context).userRegister(
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text,
                              phone: phoneController.text);
                        }
                      },
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'please enter your Password';
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
                          return 'please enter your Phone number';
                        }
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: ConditionalBuilder(
                        condition: state is! RegisterLoadingState,
                        builder: (context) => Container(
                            height: 50,
                            width: double.infinity,
                            color: defaultColor,
                            child: TextButton(
                                onPressed: () {
                                  if (formKey.currentState.validate()) {
                                    RegisterCubit.get(context).userRegister(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text,
                                        phone: phoneController.text);
                                  }
                                },
                                child: Center(
                                    child: Text(
                                  'Register',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )))),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
