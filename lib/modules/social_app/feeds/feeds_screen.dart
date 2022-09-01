import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/social_layout/cubit/cubit.dart';
import 'package:todo_app/layout/social_layout/cubit/state.dart';
import 'package:todo_app/models/social_app/post_model.dart';
import 'package:todo_app/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state) {},
      builder:  (context,state)
      {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.length > 0,
          builder :(context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5.0,
                  margin: EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children:   [
                      const Image(
                        image: NetworkImage('https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg'),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Communicate with friends',
                          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              color: Colors.white
                          ),
                        ),
                      )
                    ],

                  ),
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildPostItem(SocialCubit.get(context).posts[index],context,index),
                    separatorBuilder:(context, index) => SizedBox(
                      height: 1.0,
                    ),
                    itemCount: SocialCubit.get(context).posts.length)

              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
  Widget buildPostItem(Post_Model model,context, index) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    margin: EdgeInsets.all(8.0),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage('${model.image}'),
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
                          "${model.name}",
                          style: const TextStyle(
                              height: 1.3
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        const Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 16.0,
                        )
                      ],
                    ),
                    Text(
                      "${model.dateTime}",
                      style: Theme.of(context).textTheme.caption?.copyWith(
                          height: 1.3
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              IconButton(
                  onPressed: (){},
                  icon: const Icon(
                    Icons.more_horiz,
                  )
              )

            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Text(
            "${model.text}",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          /*Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 5.0
            ),
            child: Container(
              width: double.infinity,
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        end: 6.0
                    ),
                    child: Container(
                      height: 20.0,
                      child: MaterialButton(
                        onPressed: (){},
                        height: 20.0,
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        child: Text(
                            '#unlimited network',
                            style: Theme.of(context).textTheme.caption?.copyWith(
                              color: Colors.blue,
                            )
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        end: 6.0
                    ),
                    child: Container(
                      height: 20.0,
                      child: MaterialButton(
                        onPressed: (){},
                        height: 20.0,
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        child: Text(
                            '#unlimited network',
                            style: Theme.of(context).textTheme.caption?.copyWith(
                              color: Colors.blue,
                            )
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        end: 6.0
                    ),
                    child: Container(
                      height: 20.0,
                      child: MaterialButton(
                        onPressed: (){},
                        height: 20.0,
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        child: Text(
                            '#unlimited network',
                            style: Theme.of(context).textTheme.caption?.copyWith(
                              color: Colors.blue,
                            )
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        end: 6.0
                    ),
                    child: Container(
                      height: 20.0,
                      child: MaterialButton(
                        onPressed: (){},
                        height: 20.0,
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        child: Text(
                            '#unlimited network',
                            style: Theme.of(context).textTheme.caption?.copyWith(
                              color: Colors.blue,
                            )
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),*/
          if(model.postImage !=null)
          Padding(
              padding: const EdgeInsets.only(
                  top: 15.0
              ),
              child: Container(
                height: 160.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    image: DecorationImage(
                      image: NetworkImage('${model.postImage}'),
                      fit: BoxFit.cover,
                    )
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 10.0
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        const Icon(
                          IconBroken.Heart,
                          size: 16.0,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text('${SocialCubit.get(context).likes[index]}',
                            style: Theme.of(context).textTheme.caption
                        )
                      ],
                    ),
                    onTap: (){

                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          IconBroken.Chat,
                          size: 16.0,
                          color: Colors.amber,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text('0 comments',
                            style: Theme.of(context).textTheme.caption
                        )
                      ],
                    ),
                    onTap: (){

                    },
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                bottom: 10.0
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18.0,
                        backgroundImage: NetworkImage('${model.image}'),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text("Write a comment ...",
                        style: Theme.of(context).textTheme.caption?.copyWith(
                            height: 1.3
                        ),

                      )

                    ],
                  ),
                  onTap: ()
                  {

                  },
                ),
              ),
              InkWell(
                child: Row(
                  children: [
                    const Icon(
                      IconBroken.Heart,
                      size: 16.0,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text('Like',
                        style: Theme.of(context).textTheme.caption
                    )
                  ],
                ),
                onTap: (){
                     SocialCubit.get(context).LikePost(SocialCubit.get(context).postid[index]);
                },
              )
            ],
          )

        ],
      ),
    ),
  );
}
