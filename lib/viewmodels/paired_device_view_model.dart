import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tekido_homeautomation/constants/const.dart';
import 'package:tekido_homeautomation/constants/route_name.dart';
import 'package:tekido_homeautomation/models/model_data.dart';
import 'package:tekido_homeautomation/models/model_data1.dart';
import 'package:tekido_homeautomation/models/model_data2.dart';
import 'package:tekido_homeautomation/models/model_data_paired.dart';
import 'package:tekido_homeautomation/models/model_device_input.dart';
import 'package:tekido_homeautomation/services/local_storage_service.dart';

import 'package:tekido_homeautomation/locator.dart';
import 'package:tekido_homeautomation/services/navigation_service.dart';
import 'package:tekido_homeautomation/services/storage_service.dart';
import 'package:tekido_homeautomation/ui/views/paired_device_view.dart';
import 'package:tekido_homeautomation/viewmodels/base_model.dart';

class PairedDeviceViewModel extends BaseModel {
  PairedDevice? pairedDevice;
  Device1? device1;
  late Device2 device2;
  final StorageService _storageService = locator<StorageService>();
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();
  final NavigationService _navigationService = locator<NavigationService>();
  TextEditingController inputNameController = TextEditingController();
  TextEditingController outputNameController = TextEditingController();
  List<Device1> inputDevice = [];
  List<Device2> outputDevice = [];
  List<ModelDeviceInput> modelDeviceInput = [];

  // ModelDeviceInput? modelDeviceInput;
  String inputSelection = '';
  String outputSelection = '';
  String inputNameData = '';
  String outputNameData = '';
  String inputGuidData = '';
  String outputGuidData = '';

  Future<void> initState() async {
    showData();
    // modelDeviceInput.add(ModelDeviceInput(
    //     guid: "12",
    //     mac: "asep",
    //     type: "trisna",
    //     quantity: "quantity",
    //     name: "name",
    //     version: "version",
    //     minor: "minor",
    //     status: "status"));
    // print('oh ya:${modelDeviceInput}');
    // inputNameData = modelDeviceInput!.name;
    //await getInputDataList();
    // await getOutputDataList();
    //fetchData();
    // print('table $inputDevice');
    //print(outputDevice);
  }

  void showData() async {
    var inputName =
        await _storageService.getString(localInputNameDataTemporary);
    var outputName =
        await _storageService.getString(localOutputNameDataTemporary);
    inputNameController.text = inputName!;
    outputNameController.text = outputName!;
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

  Future<List<Device2>> getOutputDataList() async {
    final Future<Database> dbFuture =
        _localStorageService.getDatabaseInstance();
    await dbFuture.then((databaseOPEN) async {
      Future<List<Device2>> outputListFuture =
          _localStorageService.getOutputDevice();
      outputDevice = await outputListFuture.then((value) => value);
    });
    // print(outputList);
    return outputDevice;
  }

  // void fetchData() async {
  //   inputDevice.add(device1!);
  //   inputGuidData = device1!.guid;
  //   inputNameData = device1!.name;
  //   //outputGuidData = device2.guid;
  //   // outputNameData = device2.name;
  //   print(inputGuidData);
  //   // print(outputGuidData);
  // }
  //
  // Future<void> onChangedInput(String value) async {
  //   setBusy(true);
  //   inputSelection = value;
  //   setBusy(false);
  // }
  //
  // Future<void> onChangedOutput(String value) async {
  //   setBusy(true);
  //   outputSelection = value;
  //   setBusy(false);
  // }

  // void deleteInputData(Device1 device1, context) async {
  //   await _localStorageService.deleteDevice(device1.guid);
  //   print('${device1.name} has not available');
  // }

  void saveInputData(String name, String guid) async {
    await _storageService.setString(localInputNameDataTemporary, name);
    await _storageService.setString(localInputGuidDataTemporary, guid);
    _navigationService.navigateTo(PairedDeviceViewRoute);
  }

  void saveOutputData(String name, String guid) async {
    await _storageService.setString(localOutputNameDataTemporary, name);
    await _storageService.setString(localOutputGuidDataTemporary, guid);
    _navigationService.navigateTo(PairedDeviceViewRoute);
  }

  void savePairedData() async {
    var inputGuid =
        await _storageService.getString(localInputGuidDataTemporary);
    var inputName =
        await _storageService.getString(localInputNameDataTemporary);
    var outputGuid =
        await _storageService.getString(localOutputGuidDataTemporary);
    var outputName =
        await _storageService.getString(localOutputNameDataTemporary);

    pairedDevice =
        PairedDevice(inputGuid!, outputGuid!, inputName!, outputName!);
    print ('[guid input] $inputGuid');
    print ('[name input] $inputName');
    print ('[guid output] $outputGuid');
    print ('[name output] $outputName');
    await _localStorageService.addPairedDevice(pairedDevice!);
    await _localStorageService.deleteDevice(inputGuid, tableInput);
    await _localStorageService.deleteDevice(outputGuid, tableOutput);
    await _storageService.clearStorage();
    _navigationService.replaceTo(DashboardViewRoute);
  }

  void movePage(String routeName) {
    _navigationService.navigateTo(routeName);
  }
}
