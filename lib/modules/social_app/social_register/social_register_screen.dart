import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/social_layout/social_layout.dart';

import '../../../shared/components/components.dart';
import '../social_login/social_login_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class Social_Register_Screen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (context,state) {
             if(state is SocialCreateUserSuccessState)
              {
                navigateandfinish(context, Social_Layout_Screen());
              }
        },
        builder: (context,state) {
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
                        'Register now to communicate with friends',
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
                          suffixIcon: SocialRegisterCubit
                              .get(context)
                              .suffix,
                          obscure: SocialRegisterCubit
                              .get(context)
                              .isPassword,
                          suffixOnPressed: () {
                            SocialRegisterCubit.get(context)
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
                        condition: state is! SocialRegisterLoadingState,
                        builder: (context) =>  defaultButton(
                            function: () {
                                 if (formkey.currentState!.validate()) {
                            SocialRegisterCubit.get(context)
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
                                navigateTo(context, Social_Login_screen());
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
