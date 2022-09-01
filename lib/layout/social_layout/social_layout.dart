import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/layout/social_layout/cubit/cubit.dart';
import 'package:todo_app/layout/social_layout/cubit/state.dart';
import 'package:todo_app/modules/social_app/new_posts/new_posts_screen.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/styles/icon_broken.dart';

class Social_Layout_Screen extends StatelessWidget {
  const Social_Layout_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>
        (
        listener: (context,state) {
          if(state is SocialNewPostState)
            {
              navigateTo(context, NewPostsScreen());
            }
        },
        builder: (context,state) {

          var cubit = SocialCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                cubit.title[cubit.currentIndex],
              ),
              actions: [
                IconButton(
                    onPressed: ()
                    {

                    },
                    icon:const Icon(IconBroken.Notification)),
                IconButton(
                    onPressed: ()
                    {

                    },
                    icon:const Icon(IconBroken.Search)),
              ],
            ),
            body: cubit.Screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index)
              {
                cubit.ChangeBottomNav(index);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(
                    IconBroken.Home,

                ),
                label:  "Home"),
                BottomNavigationBarItem(icon: Icon(
                  IconBroken.Chat,
                ),
                label: "Chat"),
                BottomNavigationBarItem(icon: Icon(
                  IconBroken.Paper_Upload,

                ),
                    label:  "Post"),
                BottomNavigationBarItem(icon: Icon(
                  IconBroken.Location,
                ) ,
                label: "Users"),
                BottomNavigationBarItem(icon: Icon(
                  IconBroken.Setting,
                ),
                label: "Settings")
              ],

            ),
          );
        }
      );

  }
}
