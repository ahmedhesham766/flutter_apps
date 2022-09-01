import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/social_layout/cubit/cubit.dart';
import 'package:todo_app/layout/social_layout/cubit/state.dart';
import 'package:todo_app/models/social_app/message_model.dart';
import 'package:todo_app/models/social_app/social_user_model.dart';
import 'package:todo_app/shared/styles/icon_broken.dart';

import '../../../shared/styles/color.dart';


class ChatDetailsScreen extends StatelessWidget {

 late Social_User_Model model;
 ChatDetailsScreen(
 {
   required this.model,
  });
 var messagetext = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).GetMessage
          (receiverId: model.uId);
        return BlocConsumer<SocialCubit,SocialStates>(
          listener: (context,state){},
          builder: (context,state){
            return Scaffold(
                appBar: AppBar(
                  titleSpacing: 0.0,
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(model.image!),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(model.name!,)
                    ],
                  ),
                ),
                body: ConditionalBuilder(
                  condition:  SocialCubit.get(context).messages.length > 0,
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                              itemBuilder: (context,index)
                              {
                                var message = SocialCubit.get(context).messages[index];
                                if(SocialCubit.get(context).model!.uId == message.senderId)
                                  return buildmymessage(context,message);
                                return buildusermessage(context,message);
                              },
                              separatorBuilder: (context,index) => SizedBox(
                                height: 15.0,),
                              itemCount: SocialCubit.get(context).messages.length),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey[300]!,
                                  width: 1.0
                              ),

                              borderRadius: BorderRadius.circular(15.0)
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0,
                                  ),
                                  child: TextFormField(
                                    controller: messagetext,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      hintText: 'type your message here ...',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 50.0,
                                color: DefaultColor,
                                child: MaterialButton(
                                  onPressed: ()
                                  {
                                    SocialCubit.get(context).SendMessage(
                                        receiverId: model.uId!,
                                        datetime: DateTime.now().toString(),
                                        text: messagetext.text);
                                  },
                                  minWidth: 1,
                                  height: 1,
                                  child: Icon(
                                    IconBroken.Send,
                                    size: 25.0,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  fallback: (context) => Center(child: Text('no messages yet')),
                )
            );

          },
        );
      }
    );
  }
}
Widget buildusermessage(context,MessageModel model) => Align(
  alignment: AlignmentDirectional.centerStart,
  child: Container(
    padding: EdgeInsets.all(15.0),
    child: Text(model.text!),
    decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(30.0),
          topEnd: Radius.circular(30.0),
          topStart: Radius.circular(30.0),
        )
    ),
  ),
);

Widget buildmymessage(context,MessageModel model) => Align(
  alignment: AlignmentDirectional.centerEnd,
  child: Container(
    padding: EdgeInsets.all(15.0),
    child: Text(model.text!),
    decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(30.0),
          topEnd: Radius.circular(30.0),
          topStart: Radius.circular(30.0),
        )
    ),
  ),
);
