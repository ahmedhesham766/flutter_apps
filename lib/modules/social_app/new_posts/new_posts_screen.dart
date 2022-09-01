import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/social_layout/cubit/cubit.dart';
import 'package:todo_app/layout/social_layout/cubit/state.dart';
import 'package:todo_app/shared/styles/icon_broken.dart';

import '../../../shared/components/components.dart';




class NewPostsScreen extends StatelessWidget {
  var textController = TextEditingController();
  var now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        print("timeofpost:");
        print(now);
        return Scaffold(
          appBar: defaultAppBar(
              context: context,
              title: 'Add post',
              actions: [
                TextButton(
                    onPressed: (){
                  if(SocialCubit.get(context).postimage == null)
                    {
                      SocialCubit.get(context).CreatePost(
                          dateTime: now.toString(),
                          text: textController.text);
                    }
                  else
                    {
                      SocialCubit.get(context).UploadPostImage(
                          dateTime: now.toString(),
                          text: textController.text);
                    }
                },
                    child: Text(
                      'POST',
                    ))
              ]
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostUserLoadingState)
                  LinearProgressIndicator(),
                if(state is SocialCreatePostUserLoadingState)
                  SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage('${SocialCubit.get(context).model!.image}'),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${SocialCubit.get(context).model!.name}",
                                style: TextStyle(
                                    height: 1.3
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'What is on your mind ...'),
),
                ),
                SizedBox(
                  height: 20.0,
                ),
                if(SocialCubit.get(context).postimage != null)
                  Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 160.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image: DecorationImage(
                            image: FileImage(SocialCubit.get(context).postimage!),
                            fit: BoxFit.cover,
                          )
                      ),
                    ),
                    IconButton(
                        onPressed: (){
                              SocialCubit.get(context).removePostImage();
                        },
                        icon: CircleAvatar(
                          radius: 20.0,
                          backgroundColor: Colors.red,
                          child: Icon(
                            Icons.close,
                            size: 20.0,
                          ),
                        ))
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: (){
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconBroken.Image
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'add photo'
                              )
                            ],
                          )),
                    ),
                    Expanded(
                      child: TextButton(onPressed: (){},
                            child:  Text(
                                  '# tags'
                              )
                          )
                    ),
                  ],
                ),

              ],
            ),
          ),
        );
      },

    );
  }
}
