import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/shop_app/shop_login/shop_login_screen.dart';
import 'package:todo_app/modules/shop_app/shop_register/cubit/cubit.dart';
import 'package:todo_app/modules/shop_app/shop_register/cubit/states.dart';

import '../../../layout/shop_layout/shop_layouy.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../shop_login/cubit/cubit.dart';
import '../shop_login/cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (BuildContext context) => ShopRegisterCubit(),
        child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
          listener: (context,state) {
              if(state is ShopRegisterSuccessState)
              {
                    if(state.loginmodel.status == true)
                    {
                        print(state.loginmodel.message);
                        print(state.loginmodel.data?.token);
                        Cache_Helper.saveData(key: 'token', value: state.loginmodel.data?.token)
                        .then((value)
                          {
                                cache_token = state.loginmodel.data?.token;
                                navigateandfinish(context,ShopLayout());
                          });
                        showToast(text: state.loginmodel.message, state: ToastState.SUCCESS);

                    }
                    else
                      {
                        print(state.loginmodel.message);
                        showToast(text: state.loginmodel.message, state: ToastState.ERROR);
                      }
              }
              },
          builder: (context, state) {
            return Scaffold (
              appBar: AppBar(),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline3
                              ?.copyWith(
                              color: Colors.black
                          ),
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultTextFormField(
                          prefixIcon: Icons.person,
                          label: 'User Name',
                          controller: nameController,
                          textInputType: TextInputType.name,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your name';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFormField(
                          prefixIcon: Icons.email,
                          label: 'Email Address',
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFormField(
                            prefixIcon: Icons.lock,
                            label: 'Password',
                            controller: passwordController,
                            textInputType: TextInputType.visiblePassword,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'password is too short';
                              }
                            },
                            suffixIcon: ShopRegisterCubit
                                .get(context)
                                .suffix,
                            obscure: ShopRegisterCubit
                                .get(context)
                                .isPassword,
                            suffixOnPressed: () {
                              ShopRegisterCubit.get(context)
                                  .ChangePasswordState();
                            },
                            onsubmit: (value) {

                            }
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFormField(
                          prefixIcon: Icons.phone,
                          label: 'Phone',
                          controller: phoneController,
                          textInputType: TextInputType.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your phone';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) =>  defaultButton(
                                  function: () {
                                    if (formkey.currentState!.validate()) {
                                      ShopRegisterCubit.get(context)
                                          .UserRegister(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          phone: phoneController.text
                                      );
                                    }
                                  },
                                  text: 'Register',
                                  isUpperCase: true),
                          fallback: (context) => Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('have already account'),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, ShopLoginScreen());
                                },
                                child: Text('Login'.toUpperCase()))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );

        },
        ),
    );

  }
}
