import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout.dart';
import 'package:shop_app/modules/Register/Register.dart';
import 'package:shop_app/modules/login/bloc.dart';
import 'package:shop_app/modules/login/states.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/components.dart';
import '../../shared/constants.dart';

class Login extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => LoginCubit(),
        child:
            BlocConsumer<LoginCubit, LoginStates>(listener: (context, state) {
          if (state is LoginSuccessState) {
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
                      Text('LOGIN',
                          style: Theme.of(context).textTheme.headline5),
                      SizedBox(
                        height: 30,
                      ),
                      Text('Login now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.grey)),
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
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                        obscureText: LoginCubit.get(context).isPassword,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: InkWell(
                                onTap: () =>
                                    LoginCubit.get(context).changePassword(),
                                child: Icon(LoginCubit.get(context).suffix)),
                            label: Text('Password')),
                        onFieldSubmitted: (value) {
                          if (formKey.currentState.validate()) {
                            LoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text);
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
                      Container(
                        child: ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => Container(
                              height: 50,
                              width: double.infinity,
                              color: defaultColor,
                              child: TextButton(
                                  onPressed: () {
                                    if (formKey.currentState.validate()) {
                                      LoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  },
                                  child: Center(
                                      child: Text(
                                    'LOGIN',
                                    style: TextStyle(color: Colors.white),
                                  )))),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Dont have an account?',
                              style: Theme.of(context).textTheme.bodyText1),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => Register())));
                            },
                            child: Text('Register now',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(color: defaultColor)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }
}

///////////////////
void showToast({@required String text, @required toastStates state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);
//enum
enum toastStates { SUCCESS, ERROR, WARNING }
Color chooseToastColor(toastStates state) {
  Color color;
  switch (state) {
    case toastStates.SUCCESS:
      color = Colors.green;
      break;
    case toastStates.ERROR:
      color = Colors.red;
      break;
    case toastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}
