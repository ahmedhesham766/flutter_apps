import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/news_layout/cubit/cubit.dart';
import 'package:todo_app/layout/news_layout/cubit/states.dart';

import '../../../shared/components/components.dart';



class Business_Screen extends StatelessWidget {
  const Business_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Newscubit,NewsStates>(
        listener: (context,state){},
        builder: (context,state){
          var list = Newscubit.get(context).business;
      return articleBuilder(list);
    });
  }
}
