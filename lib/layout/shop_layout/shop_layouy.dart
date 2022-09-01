import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/shop_layout/cubit/cubit.dart';
import 'package:todo_app/layout/shop_layout/cubit/states.dart';
import 'package:todo_app/modules/shop_app/search/search_screen.dart';
import 'package:todo_app/modules/shop_app/shop_login/shop_login_screen.dart';
import 'package:todo_app/shared/network/local/cache_helper.dart';

import '../../modules/shop_app/search/cubit/cubit.dart';
import '../../shared/components/components.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (BuildContext context) => ShopSearchCubit(),
        ),
        BlocProvider(
        create: (BuildContext context) => ShopCubit()..GetHomeData()..GetCategoryData()..GetFavourites()..GetProfile(),)
      ],

        child: BlocConsumer<ShopCubit,ShopState>(
          listener: (context,state) {},
          builder: (context,state)
          {
            var cubit = ShopCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                    'Market'
                ),
                actions: [
                  IconButton(
                      onPressed: ()
                      {
                          Navigator.push(context,
                              CupertinoPageRoute(builder: (context) => BlocProvider.value(
                                  value: context.read<ShopSearchCubit>(),
                                  child: SearchScreen())));
                      },
                      icon: const Icon(Icons.search))
                ],

              ),
              body: cubit.screens[cubit.currentindex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentindex,
                onTap: (index)
                {
                  cubit.ChangeBottomNavItem(index);
                },
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home_filled),label: 'Home'),
                  BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Categories'),
                  BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorite'),
                  BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
                ],
              ),
            );
          },

        ),
    );

  }
}
