import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/shop_layout/cubit/cubit.dart';
import 'package:todo_app/layout/shop_layout/cubit/states.dart';

import '../../../models/shop_app/get_favourite.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/color.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopState>
      (
        listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: state is! ShopGetFavouritesLoadingState || ShopCubit.get(context).getfav != null,
          builder: (BuildContext context) =>  ListView.separated(
              itemBuilder: (context,index) => buildListItems(ShopCubit.get(context).getfav!.data!.data![index].product,context),
              separatorBuilder: (BuildContext context, int index) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 1.0,
                  width: double.infinity,
                  color: Colors.black,
                ),
              ),
              itemCount: ShopCubit.get(context).getfav!.data!.data!.length),
          fallback: (BuildContext context) => Center(child: CircularProgressIndicator()),
        );
      });
  }


}