import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/news_layout/cubit/states.dart';
import 'package:todo_app/shared/components/components.dart';

import '../../modules/news_app/search/search.dart';
import '../../shared/cubit/cubit.dart';
import 'cubit/cubit.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Newscubit,NewsStates>(
        listener: (context,state){},
        builder: (context,state) {
          var cubit = Newscubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('News App'),
              actions: [
                IconButton(
                    onPressed: (){
                      navigateTo(context, Search());
                    },
                    icon: const Icon(
                      Icons.search,
                    ),
                ),
                IconButton(
                  onPressed: (){
                    Appcubit.get(context).changeAppMode();
                  },
                  icon: Appcubit.get(context).isDark ? const Icon(Icons.sunny,color: Colors.amber,): const Icon(Icons.brightness_2)

                )
              ],
            ),
            body: cubit.screens[cubit.currentindex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentindex,
              onTap: (index)
              {
                cubit.ChangeNavBottom(index);
              },
                items: cubit.BottomItems,
            ),
          );
        });
  }
}
