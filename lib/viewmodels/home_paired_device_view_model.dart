import 'package:sqflite/sqflite.dart';
import 'package:tekido_homeautomation/locator.dart';
import 'package:tekido_homeautomation/models/model_data1.dart';
import 'package:tekido_homeautomation/models/model_data_paired.dart';
import 'package:tekido_homeautomation/services/local_storage_service.dart';
import 'package:tekido_homeautomation/services/navigation_service.dart';
import 'package:tekido_homeautomation/services/storage_service.dart';
import 'package:tekido_homeautomation/viewmodels/base_model.dart';

class HomePairedDeviceViewModel extends BaseModel{
  // PairedDevice? pairedDevice;
  final StorageService _storageService = locator<StorageService>();
  final LocalStorageService _localStorageService =
  locator<LocalStorageService>();
  final NavigationService _navigationService = locator<NavigationService>();
  List<PairedDevice> pairedDevice = [];
  List<Device1> inputDevice = [];

  void movePage(String routeName) {
    _navigationService.navigateTo(routeName);
  }

  Future<List<PairedDevice>> getPairedDataList() async {
    final Future<Database> dbFuture =
    _localStorageService.getDatabaseInstance();
    await dbFuture.then((databaseOPEN) async {
      Future<List<PairedDevice>> deviceListFuture =
      _localStorageService.getPairedDevice();
      pairedDevice = await deviceListFuture.then((value) => value);
    });
    return pairedDevice;
  }
  Future<List<Device1>> getInputDataList() async {
    final Future<Database> dbFuture =
    _localStorageService.getDatabaseInstance();
    await dbFuture.then((databaseOPEN) async {
      Future<List<Device1>> inputListFuture =
      _localStorageService.getInputDevice();
      inputDevice = await inputListFuture.then((value) => value);
    });
    return inputDevice;
  }
}