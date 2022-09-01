import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/news_layout/cubit/cubit.dart';
import '../../../layout/news_layout/cubit/states.dart';
import '../../../shared/components/components.dart';


class Science_Screen extends StatelessWidget {
  const Science_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Newscubit,NewsStates>(
        listener: (context,state){},
        builder: (context,state){

          var list = Newscubit.get(context).science;
          return articleBuilder(list);
        });
  }
}