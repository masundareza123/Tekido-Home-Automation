import 'dart:convert' as convert;

import 'package:flutter/cupertino.dart';
import 'package:tekido_homeautomation/constants/const.dart';
import 'package:tekido_homeautomation/constants/route_name.dart';
import 'package:tekido_homeautomation/locator.dart';
import 'package:tekido_homeautomation/models/model_data.dart';
import 'package:tekido_homeautomation/services/alert_service.dart';
import 'package:tekido_homeautomation/services/local_storage_service.dart';
import 'package:tekido_homeautomation/services/navigation_service.dart';
import 'package:tekido_homeautomation/services/storage_service.dart';
import 'package:tekido_homeautomation/viewmodels/base_model.dart';



class ScanDeviceViweModel extends BaseModel{
  final NavigationService _navigationService = locator<NavigationService>();
  final LocalStorageService _localStorageService = locator<LocalStorageService>();
  final StorageService _storageService = locator<StorageService>();
  final AlertService _alertService = locator<AlertService>();

  TextEditingController guidController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController macController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController versionController = TextEditingController();
  TextEditingController minorController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController aliasController = TextEditingController();

  Device? device;

  Future<void> getTask() async {
    showData();
    // print('OnMode');
  }

  void showData() async {
    String? data = await _storageService.getString(localDataTemporary);

    var result = convert.jsonDecode(data!);
    print(result);

    var guid = result['guid'];
    var name = result['name'];
    var type = result['type'];
    var mac = result['mac'];
    var quantity = result['quantity'];
    var version = result['version'];
    var minor = result['minor'];

    guidController.text = guid;
    nameController.text = name;
    typeController.text = type;
    macController.text = mac;
    quantityController.text = quantity;
    versionController.text = version;
    minorController.text = minor;
  }

  void registerDevice(BuildContext context) async {
    var guid = guidController.text;
    var mac = macController.text;
    var type = typeController.text;
    var quantity = quantityController.text;
    var name = nameController.text;
    var version = versionController.text;
    var minor = minorController.text;
    var status = "1";
    var alias = aliasController.text;

    device = Device(alias, guid, mac, minor, name, quantity, status, type, version);

    // device = Device(guid, mac, minor, name, quantity, status, type, version, alias);
    try{
      if(guidController.text.isNotEmpty && typeController.text == 'AI' && aliasController.text.isNotEmpty){
        await _localStorageService.addDevice(device!, tableInput);
        _alertService.showSuccess(context, "Success", "Input device added successfully", () {
          _navigationService.replaceTo(DashboardViewRoute);
        });
        await _storageService.clearStorage();
      } else if (guidController.text.isNotEmpty && typeController.text == 'AO' && aliasController.text.isNotEmpty){
        await _localStorageService.addDevice(device!, tableOutput);
        _alertService.showSuccess(context, "Success", "Output device added successfully", () {
          _navigationService.replaceTo(DashboardViewRoute);
        });
        await _storageService.clearStorage();
      } else {
        _alertService.showWarning("Warning", "Please fill all field", () {
          _navigationService.pop();
        });
      }
    }catch(e){
      _alertService.showError(context, "Error", "Device has been registered",
              ()async {
                _navigationService.replaceTo(DashboardViewRoute);
                await _storageService.clearStorage();
          });
    }
  }

  void movePage(String routeName){
    _navigationService.navigateTo(routeName);
  }
}