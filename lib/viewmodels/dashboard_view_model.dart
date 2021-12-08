import 'package:tekido_homeautomation/locator.dart';
import 'package:tekido_homeautomation/services/local_storage_service.dart';
import 'package:tekido_homeautomation/services/navigation_service.dart';
import 'package:tekido_homeautomation/viewmodels/base_model.dart';

class DashboardViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final LocalStorageService _localStorageService = locator<LocalStorageService>();

  void movePage(String routeName){
    _navigationService.navigateTo(routeName);
  }

  void initState() async{
    await _localStorageService.database;
  }
}