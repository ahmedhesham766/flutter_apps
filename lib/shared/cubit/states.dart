import 'package:todo_app/shared/cubit/states.dart';

abstract class  Appstates {
}
//create states
class initialAppstate extends Appstates {}

class ChangeNavBarState extends Appstates{}

class CreateDatabaseState extends Appstates{}

class GetDatabaseState extends Appstates{}

class GetDatabaseLoadingState extends Appstates{}

class InsertDatabaseState extends Appstates{}

class UpdateDatabaseState extends Appstates{}

class DeleteDatabaseState extends Appstates{}

class ChangeBottomSheetState extends Appstates{}

class AppChangeModeState extends Appstates{}