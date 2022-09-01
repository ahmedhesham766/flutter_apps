import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/layout/shop_layout/shop_layouy.dart';
import 'package:todo_app/modules/shop_app/shop_login/cubit/cubit.dart';
import 'package:todo_app/modules/shop_app/shop_login/cubit/states.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/components/constants.dart';
import 'package:todo_app/shared/network/local/cache_helper.dart';

import '../shop_register/register_screen.dart';

class ShopLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formkey = GlobalKey<FormState>();
   ShopLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state) {
          if(state is ShopLoginSuccessState)
            {
              if(state.loginmodel.status == true)
                {
                  print(state.loginmodel.message);
                  print(state.loginmodel.data?.token);
                  Cache_Helper.saveData(key: 'token', value: state.loginmodel.data?.token).then((value)
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
        builder: (context,state)
        {
          return Scaffold(
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
                        'Login',
                        style: Theme.of(context).textTheme.headline3?.copyWith(
                            color: Colors.black
                        ),
                      ),
                      Text(
                        'Login now to browse our hot offers',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defaultTextFormField(
                          prefixIcon: Icons.email,
                          label: 'Email Address',
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          validate: (value)
                          {
                            if(value!.isEmpty)
                            {
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
                          validate: (String? value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'password is too short';
                            }
                          },
                          suffixIcon: ShopLoginCubit.get(context).suffix,
                          obscure: ShopLoginCubit.get(context).isPassword,
                          suffixOnPressed: ()
                          {
                            ShopLoginCubit.get(context).ChangePasswordState();
                          },
                        onsubmit: (value)
                          {
                            if(formkey.currentState!.validate())
                            {
                              ShopLoginCubit.get(context).UserLogin(
                                  email: emailController.text,
                                  password: passwordController.text
                              );
                            }
                          }
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopLoginLoadingState,
                        builder: (context) => defaultButton(
                            function: (){
                              if(formkey.currentState!.validate())
                                {
                                  ShopLoginCubit.get(context).UserLogin(
                                      email: emailController.text,
                                      password: passwordController.text
                                  );
                                }
                            },
                            text: 'Login',
                            isUpperCase: true),
                        fallback: (context) => Center(child: CircularProgressIndicator()),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account?'),
                          TextButton(
                              onPressed: (){
                                navigateTo(context,  RegisterScreen());
                              },
                              child: Text('Register'.toUpperCase()))
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
