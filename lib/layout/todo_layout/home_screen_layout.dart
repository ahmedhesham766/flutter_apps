
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';


class Homelayout extends StatelessWidget {

  var titleTextController = TextEditingController();
  var timeTextController = TextEditingController();
  var dateTextController = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) => Appcubit()..CreateDatabase(),
      child: BlocConsumer<Appcubit,Appstates>(
        listener: (context,state) {
          if(state is InsertDatabaseState)
            {
              Navigator.pop(context);
              Appcubit.get(context).ChangeBottomSheet(icon: Icons.edit,isShow: false);
            }
        },
        builder: (context,state)
        {
          Appcubit cubit = Appcubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
              elevation: 18.0,
            ),
            body:   ConditionalBuilder(
              condition: state is! GetDatabaseLoadingState,
              builder: (context)=>cubit.screens[cubit.currentIndex],
              fallback:(context)=> const Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: cubit.currentIndex == 0 ? FloatingActionButton(
              child: Icon(
                cubit.icono,
              ),
              onPressed: () {
                if(cubit.bottomsheet)
                {
                  if(formkey.currentState!.validate())
                  {
                    cubit.insertToDatabase(
                        title: titleTextController.text,
                        time: timeTextController.text,
                        date: dateTextController.text);
                  }
                }
                else{
                  scaffoldKey.currentState?.showBottomSheet((context) => GestureDetector(
                    onVerticalDragStart: (dragInfo) {
                      Navigator.pop(context);
                      cubit.ChangeBottomSheet(icon: Icons.edit,isShow: false);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      color: Colors.white,
                      child: Form(
                        key: formkey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            defaultTextFormField(
                              controller: titleTextController,
                              label: 'Title',
                              prefixIcon: Icons.title,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "Title must not be empty";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            defaultTextFormField(
                              controller: timeTextController,
                              textInputType: TextInputType.datetime,
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  timeTextController.text = value!.format(context).toString();
                                });
                              },
                              label: 'Time',
                              prefixIcon: Icons.watch_later_outlined,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "Time must not be empty";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            defaultTextFormField(
                              controller: dateTextController,
                              textInputType: TextInputType.datetime,
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2022-30-12'),
                                ).then((value) {
                                  dateTextController.text = DateFormat.yMMMd().format(value!);
                                });
                              },
                              label: 'Date',
                              prefixIcon: Icons.date_range_outlined,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "Date must not be empty";
                                }
                                return null;
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                  ).closed.then((value)
                  {
                    cubit.ChangeBottomSheet(isShow: false, icon: Icons.edit);
                  });
                  cubit.ChangeBottomSheet(isShow: true, icon: Icons.add);
                }
              },

            ): null,
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey,
              currentIndex:cubit.currentIndex,
              onTap: (index)
              {
                cubit.ChangedIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu),
                    label: 'TASKS'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.done),
                    label: 'Done'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive),
                    label: 'Archive'
                )
              ],
            ) ,

          );
        },
      ),
    );
  }


}








