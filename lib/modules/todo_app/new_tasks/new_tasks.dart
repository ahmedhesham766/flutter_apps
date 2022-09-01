import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/components/constants.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class newtasks extends StatelessWidget {
  const newtasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit,Appstates>(
        listener: (context,state) {},
        builder: (context,state) {

          List<Map> tasks = Appcubit.get(context).newTasks;
          IconData icon = Appcubit.get(context).iconofApp[Appcubit.get(context).currentIndex];
          return tasksBuilder(tasks: tasks,icono: icon);
        });
  }

}
