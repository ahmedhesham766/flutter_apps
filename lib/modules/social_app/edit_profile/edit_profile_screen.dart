import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/layout/social_layout/cubit/cubit.dart';
import 'package:todo_app/layout/social_layout/cubit/state.dart';
import 'package:todo_app/shared/styles/icon_broken.dart';

import '../../../shared/components/components.dart';


class Edit_profile_Screen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state) {},
        builder: (context,state) {

          dynamic userModel = SocialCubit.get(context).model;
          var profileImage  = SocialCubit.get(context).profileimage;
          var profileCover = SocialCubit.get(context).profilecover;

          nameController.text = userModel.name;
          bioController.text = userModel.bio;
          phoneController.text = userModel.phone;
          return Scaffold(
            appBar: defaultAppBar(
                context: context,
                title: 'Edit profile',
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 20.0
                    ),
                    child: TextButton(
                        onPressed: ()
                        {
                          SocialCubit.get(context).UpdateUser(
                              name: nameController.text,
                              bio:  bioController.text,
                              phone: phoneController.text);
                        },
                        child: Text(
                          'UPDATE',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.red,
                              fontSize: 15.0
                          ),
                        )
                    ),
                  )
                ]
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if(state is SocialUserUpdateLoadingState)
                      LinearProgressIndicator(),
                      SizedBox(
                        height: 10.0,
                      ),
                    Container(
                      height: 200.0,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height: 160.0,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(4.0,),
                                          topRight: Radius.circular(4.0,)

                                      ),
                                      image: DecorationImage(
                                        image: (profileCover == null) ? NetworkImage('${userModel.image}') : FileImage(File(profileCover.path)) as ImageProvider,
                                        fit: BoxFit.cover,
                                      )
                                  ),
                                ),
                                IconButton(
                                    onPressed: (){
                                      SocialCubit.get(context).getCover();
                                    },
                                    icon: CircleAvatar(
                                      radius: 20.0,
                                      backgroundColor: Colors.red,
                                      child: Icon(
                                        IconBroken.Camera,
                                        size: 20.0,

                                      ),
                                    ))
                              ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 64,
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 60.0,
                                  backgroundImage: (profileImage == null) ? NetworkImage('${userModel?.image}') : FileImage(File(profileImage.path)) as ImageProvider,
                                ),
                              ),
                              IconButton(
                                  onPressed: (){
                                          SocialCubit.get(context).getImage();
                                  },
                                  icon: CircleAvatar(
                                    radius: 20.0,
                                    backgroundColor: Colors.red,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 20.0,
                                    ),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultTextFormField(
                        prefixIcon: IconBroken.User,
                        label: 'Name',
                      validate: (value)
                        {
                          if(value!.isEmpty)
                            {
                              return 'name must not be empty';
                            }
                          return null;
                        },
                      controller: nameController
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    defaultTextFormField(
                        prefixIcon: IconBroken.Info_Circle,
                        label: 'Bio',
                        validate: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'bio must not be empty';
                          }
                          return null;
                        },
                        controller: bioController
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    defaultTextFormField(
                        prefixIcon: IconBroken.Call,
                        label: 'Phone',
                        validate: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'phone must not be empty';
                          }
                          return null;
                        },
                        controller: phoneController
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
