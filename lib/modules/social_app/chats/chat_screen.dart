import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/social_layout/cubit/state.dart';
import 'package:todo_app/models/social_app/social_user_model.dart';

import 'package:todo_app/shared/components/components.dart';

import '../../../layout/social_layout/cubit/cubit.dart';
import '../chat_details/chat_details.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return  ConditionalBuilder(
          condition: SocialCubit.get(context).users.length > 0,
          builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context,index) => buildChatItem(SocialCubit.get(context).users[index],context),
              separatorBuilder: (context,index) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 1.0,
                  width: double.infinity,
                  color: Colors.black,
                ),
              ),
              itemCount: SocialCubit.get(context).users.length
          ),
          fallback: (context) => Center(child: CircularProgressIndicator())

        );
      },
    );
  }

  Widget buildChatItem(Social_User_Model model,context) => InkWell(
    onTap: (){
          navigateTo(context, ChatDetailsScreen(model: model));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage('${model.image}'),
          ),
          SizedBox(
            width: 15.0,
          ),
          Expanded(
            child : Row(
              children: [
                Text(
                  "${model.name}",
                  style: TextStyle(
                      height: 1.3,
                      fontSize: 20.0
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
              ],
            ),
          )],
      ),
    ),
  );
}