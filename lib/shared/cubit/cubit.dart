
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:todo_app/shared/network/local/cache_helper.dart';

import '../../modules/todo_app/archived_tasks/archived_tasks.dart';
import '../../modules/todo_app/done_tasks/done_tasks.dart';
import '../../modules/todo_app/new_tasks/new_tasks.dart';

class Appcubit extends Cubit<Appstates>
{
  //variable ,methods
  Appcubit(): super(initialAppstate());

  static Appcubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  bool bottomsheet = false;

  IconData icono = Icons.edit;

  List <IconData> iconofApp =
  [
    Icons.menu,
    Icons.check,
    Icons.archive
  ];

  List<Widget> screens =
  [
    const newtasks(),
    const donetasks(),
    const archivetasks()
  ];

  List<String> titles =
  [
    'NEW_TASKS',
    'DONE_TASKS',
    'ARCHIVE_TASKS'
  ];

  void ChangedIndex (int index)
  {
    currentIndex = index;
    emit(ChangeNavBarState());
  }
  late Database db;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  void CreateDatabase()
  {
    openDatabase("todo.db", version: 1,
        onCreate: (db, version) {
          db.execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)').
          then((value)
          {
            print("table created");
          }).catchError((onError) {
            print("erroroo ${onError.toString()}");
          });
        }, onOpen: (db) {

          emit(CreateDatabaseState());

          GetfromDatabase(db);

          print("db opened");

        }).then((value)
        {
          db = value;
        }
    );
  }

 insertToDatabase(
      {
        required String title,
        required String time,
        required String date
      }
      )async
  {
     await db.transaction((txn)async{
      txn.rawInsert(
          "INSERT INTO tasks(title, date, time, status) VALUES('$title', '$date', '$time', 'new')")
          .then((value) {
        print('$value inserted successfully');

        emit(InsertDatabaseState());

        GetfromDatabase(db);

      }).catchError((onError) {
        print('exception on inserting new record ${onError.toString()}');
      });
    });
  }

  void GetfromDatabase(db) {
    newTasks =[];
    doneTasks=[];
    archivedTasks=[];
    emit(GetDatabaseLoadingState());
    db.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        }
        else if (element['status'] == 'done') {
          doneTasks.add(element);
        }
        else {
          archivedTasks.add(element);
        }
      });
      emit(GetDatabaseState());
    });
  }

  void UpdateDatabase({
          required String status,
          required int id
      })async
  {
    db.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?', ['$status', id])
        .then((value)
    {
      GetfromDatabase(db);
      emit(UpdateDatabaseState());
    });

  }

  void DeleteDatabase({
  required int id
      }) async
  {
    db.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value)
    {
      GetfromDatabase(db);
      emit(DeleteDatabaseState());
    });

  }

  void ChangeBottomSheet ({
    required bool isShow ,
    required IconData icon,
  })
  {
    bottomsheet = isShow;
    icono = icon;
    emit(ChangeBottomSheetState());
  }

  bool isDark = true;

  void changeAppMode({bool? fromshared})
  {
    if(fromshared != null)
    {
      isDark = fromshared;
    }
    else
    {
      isDark = !isDark;
      Cache_Helper.setBoolean(key: 'isDark', value: isDark).then((value)
      {
        emit(AppChangeModeState());
      });
    }
  }
}