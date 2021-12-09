import 'package:get_it/get_it.dart';
import 'package:tekido_homeautomation/services/alert_service.dart';
import 'package:tekido_homeautomation/services/local_storage_service.dart';
import 'package:tekido_homeautomation/services/navigation_service.dart';
import 'package:tekido_homeautomation/services/storage_service.dart';

GetIt locator = GetIt.instance;

 void setupLocator() {
   locator.registerLazySingleton(() => NavigationService());
   locator.registerLazySingleton(() => StorageService());
   locator.registerLazySingleton(() => LocalStorageService());
   locator.registerLazySingleton(() => AlertService());
 }