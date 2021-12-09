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
        await _storageService.getString(localInputAliasDataTemporary);
    var outputName =
        await _storageService.getString(localOutputAliasDataTemporary);
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

  void saveInputData(String alias, String guid, String mac, String minor, String name, String quantity, String type, String version) async {
    await _storageService.setString(localInputAliasDataTemporary, alias);
    await _storageService.setString(localInputGuidDataTemporary , guid);
    await _storageService.setString(localInputMacDataTemporary, mac);
    await _storageService.setString(localInputTypeDataTemporary, type);
    await _storageService.setString(localInputNameDataTemporary, name);
    await _storageService.setString(localInputVersionDataTemporary, version);
    await _storageService.setString(localInputMinorDataTemporary, minor);
    await _storageService.setString(localInputQtyDataTemporary, quantity);
    _navigationService.navigateTo(PairedDeviceViewRoute);
  }

  void saveOutputData(String alias, String guid, String mac, String minor, String name, String quantity, String type, String version) async {
    await _storageService.setString(localOutputAliasDataTemporary, alias);
    await _storageService.setString(localOutputGuidDataTemporary , guid);
    await _storageService.setString(localOutputMacDataTemporary, mac);
    await _storageService.setString(localOutputTypeDataTemporary, type);
    await _storageService.setString(localOutputNameDataTemporary, name);
    await _storageService.setString(localOutputVersionDataTemporary, version);
    await _storageService.setString(localOutputMinorDataTemporary, minor);
    await _storageService.setString(localOutputQtyDataTemporary, quantity);
    _navigationService.navigateTo(PairedDeviceViewRoute);
  }

  void savePairedData() async {
    var inputGuid =
        await _storageService.getString(localInputGuidDataTemporary);
    var inputName =
        await _storageService.getString(localInputNameDataTemporary);
    var inputQty = await _storageService.getString(localOutputQtyDataTemporary);
    var outputGuid =
        await _storageService.getString(localOutputGuidDataTemporary);
    var outputName =
        await _storageService.getString(localOutputNameDataTemporary);
    var outputQty =
        await _storageService.getString(localOutputQtyDataTemporary);
    pairedDevice = PairedDevice(inputGuid!, outputGuid!, inputName!,
        outputName!, inputQty!, outputQty!);
    print('[guid input] $inputGuid');
    print('[name input] $inputName');
    print('[guid output] $outputGuid');
    print('[name output] $outputName');
    await _localStorageService.addPairedDevice(pairedDevice!);
    updateInputData();
    await _localStorageService.deleteDevice(outputGuid, tableOutput);
    await _storageService.clearStorage();
    _navigationService.replaceTo(DashboardViewRoute);
  }

  void updateInputData () async {
    var alias = await _storageService.getString(localInputAliasDataTemporary);
    var guid = await _storageService.getString(localInputGuidDataTemporary);
    var mac = await _storageService.getString(localInputMacDataTemporary);
    var type = await _storageService.getString(localInputTypeDataTemporary);
    var name = await _storageService.getString(localInputNameDataTemporary);
    var version = await _storageService.getString(localInputVersionDataTemporary);
    var minor = await _storageService.getString(localInputMinorDataTemporary);
    var quantity = await _storageService.getString(localInputQtyDataTemporary);
    device1 = Device1(alias!, guid!, mac!, minor!, name!, quantity!, '0', type!, version!);
    await _localStorageService.updateInputDevice(device1!, tableInput);
    print('[updateInputData] $type, $alias');
  }

  void updateOutputData () async {
    var alias = await _storageService.getString(localOutputAliasDataTemporary);
    var guid = await _storageService.getString(localOutputGuidDataTemporary);
    var mac = await _storageService.getString(localOutputMacDataTemporary);
    var type = await _storageService.getString(localOutputTypeDataTemporary);
    var name = await _storageService.getString(localOutputNameDataTemporary);
    var version = await _storageService.getString(localOutputVersionDataTemporary);
    var minor = await _storageService.getString(localOutputMinorDataTemporary);
    var quantity = await _storageService.getString(localOutputQtyDataTemporary);
    device2 = Device2(alias!, guid!, mac!, minor!, name!, quantity!, '0', type!, version!);
    await _localStorageService.updateOutputDevice(device2!, tableInput);
    print('[updateInputData] $type, $alias');
  }
  void movePage(String routeName) {
    _navigationService.navigateTo(routeName);
  }
}
