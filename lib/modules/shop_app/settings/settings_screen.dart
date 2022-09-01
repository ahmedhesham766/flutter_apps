import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/components/components.dart';

import '../../../layout/shop_layout/cubit/cubit.dart';
import '../../../layout/shop_layout/cubit/states.dart';
import '../../../shared/components/constants.dart';
import '../shop_register/cubit/cubit.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  //const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopState>(
        listener: (context,state) {},
        builder: (context,state)
        {
          var cubit = ShopCubit.get(context);
          nameController.text = cubit.getprofile!.data!.name;
          emailController.text = cubit.getprofile!.data!.email;
          phoneController.text = cubit.getprofile!.data!.phone;
          return SingleChildScrollView(
            child: ConditionalBuilder(
              condition: cubit.getprofile != null,
              builder: (BuildContext context) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      if(state is ShopUpdateProfileLoadingState)
                        const LinearProgressIndicator(),
                        const SizedBox(
                          height: 20,
                        ),
                      defaultTextFormField(
                        prefixIcon: Icons.person,
                        label: "Name",
                        controller: nameController,
                        validate: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'name must not be empty';
                          }
                          return null;
                        },
                        textInputType: TextInputType.name,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defaultTextFormField(
                        prefixIcon: Icons.email,
                        label: "Email",
                        controller: emailController,
                        validate: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'email must not be empty';
                          }
                          return null;
                        },
                        textInputType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defaultTextFormField(
                        prefixIcon: Icons.phone,
                        label: "Phone",
                        controller: phoneController,
                        validate: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'phone must not be empty';
                          }
                          return null;
                        },
                        textInputType: TextInputType.phone,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultButton
                        (function: (){

                          if(formkey.currentState!.validate())
                            {

                              ShopCubit.get(context).UpdateProfile(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text);
                            }
                      },
                          text: 'Update'),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultButton(
                          function: (){

                            signout(context);
                          },
                          text: 'Logout')
                    ],
                  ),
                ),
              ),
              fallback: (BuildContext context) => Center(child: CircularProgressIndicator()),

            ),
          );

        });
}
}
