import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/social_layout/social_layout.dart';

import '../../../shared/components/components.dart';

import '../../../shared/network/local/cache_helper.dart';
import '../social_register/social_register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class Social_Login_screen extends StatelessWidget {
 var emailController = TextEditingController();
 var passwordController = TextEditingController();

  var formkey =GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (context,state){
          if(state is SocialLoginErrorState)
            {
              showToast(text: state.error, state: ToastState.ERROR);
            }
          else if(state is SocialLoginSuccessState)
            {
              Cache_Helper.saveData(key: 'uid', value: state.uid).then((value)
              {

                navigateandfinish(context,Social_Layout_Screen());
              });
            }
        },
        builder: (context,state) {
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
                        'Login now to communicate with friends',
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
                          suffixIcon: SocialLoginCubit.get(context).suffix,
                          obscure: SocialLoginCubit.get(context).isPassword,
                          suffixOnPressed: ()
                          {
                            SocialLoginCubit.get(context).ChangePasswordState();
                          },
                          onsubmit: (value)
                          {
                            if(formkey.currentState!.validate())
                            {
                              SocialLoginCubit.get(context).UserLogin(
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
                        condition: state is! SocialLoginLoadingState,
                        builder: (context) => defaultButton(
                            function: (){
                              if(formkey.currentState!.validate())
                          {
                            SocialLoginCubit.get(context).UserLogin(
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
                                navigateTo(context,  Social_Register_Screen());
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
