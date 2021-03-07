import 'package:chat_app/models/current_state.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setUpLocator() 
{

locator.registerLazySingleton<CurrentState>(() =>CurrentState());

}