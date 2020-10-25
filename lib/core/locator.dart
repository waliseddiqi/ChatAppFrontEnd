import 'connectivity_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() async {

  locator.registerLazySingleton(() => ConnectivityService());


}