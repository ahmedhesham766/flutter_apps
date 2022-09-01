import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/shop_layout/cubit/cubit.dart';
import 'package:todo_app/layout/shop_layout/cubit/states.dart';
import 'package:todo_app/models/shop_app/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopState>(
       listener: (context,state) {},
      builder: (context,state)
        {
          var cubit = ShopCubit.get(context);
          return ListView.separated(
              itemBuilder: (context,index) => buildCatItem(cubit.categorymodel!.data.data[index]),
            separatorBuilder: (BuildContext context, int index) => Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 1.0,
                width: double.infinity,
                color: Colors.black,
              ),
            ),
            itemCount: cubit.categorymodel!.data.data.length,
              );
        }

    );
  }

  Widget buildCatItem(DataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:  [
        Image(image: NetworkImage(model.image),
          width: 120,
          height: 120,
          fit: BoxFit.cover,),
        SizedBox(
          width: 10,
        ),
        Text(
          model.name,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Icon(
            Icons.arrow_forward_ios
        )
      ],
    ),
  );
}