import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tekido_homeautomation/constants/const.dart';
import 'package:tekido_homeautomation/models/model_data.dart';
import 'package:tekido_homeautomation/models/model_data1.dart';
import 'package:tekido_homeautomation/models/model_data2.dart';
import 'package:tekido_homeautomation/models/model_data_paired.dart';
import 'package:tekido_homeautomation/models/model_device_input.dart';

class LocalStorageService {
  static LocalStorageService? _localStorageService;
  static Database? _database;
  List<ModelDeviceInput> data = [];

  // Device1 dataresult;

  LocalStorageService._createObject();

  factory LocalStorageService() {
    _localStorageService ??= LocalStorageService._createObject();
    return _localStorageService!;
  }

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    Directory? directory = await getExternalStorageDirectory();
    String path = join(directory!.path, 'database');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int verion) async {
      await db.execute(
          "CREATE TABLE inputDevice(guid TEXT PRIMARY KEY, mac TEXT, type TEXT, quantity TEXT, name TEXT, version TEXT, minor TEXT, status TEXT, alias TEXT)");
      await db.execute(
          "CREATE TABLE outputDevice(guid TEXT PRIMARY KEY, mac TEXT, type TEXT, quantity TEXT, name TEXT, version TEXT, minor TEXT, status TEXT, alias TEXT)");
      await db.execute(
          "CREATE TABLE paired(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, inputGuid TEXT, outputGuid TEXT, inputName TEXT, outputName TEXT, inputQty TEXT, outputQty TEXT)");
    });
  }

  Future<void> addDevice(Device device, String tb) async {
    final Database? db = await database;
    await db!.insert(
      tb,
      device.toMap(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  Future<void> addPairedDevice(PairedDevice pairedDevice) async {
    final Database? db = await database;
    await db!.insert(
      'paired',
      pairedDevice.toMap(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  Future<void> cobagetInputDevice() async {
    final db = await database;
    var response = await db!.query(tableInput);
    var result = jsonEncode(response);
    // print("json:${result}");
  }

  Future<List<Device1>> getInputDevice() async {
    final db = await database;
    var response = await db!.query(tableInput);
    List<Device1> list = response.map((c) => Device1.fromMap(c)).toList();
    print('$response');
    return list;
  }

  Future<List<Device2>> getOutputDevice() async {
    final db = await database;
    var response = await db!.query(tableOutput);
    List<Device2> list = response.map((c) => Device2.fromMap(c)).toList();
    print('$response');
    return list;
  }

  Future<List<PairedDevice>> getPairedDevice() async {
    final db = await database;
    var response = await db!.query('paired');
    List<PairedDevice> list =
        response.map((c) => PairedDevice.fromMap(c)).toList();
    print('$response');
    return list;
  }

  Future<int> updateInputDevice(
    Device1 device1,
    String tb,
  ) async {
    final db = await database;
    return await db!.update(
      tb,
      device1.toMap(),
      where: 'guid = ?',
      whereArgs: [device1.guid],
    );
  }

  Future<int> updateOutputDevice(
    Device2 device2,
    String tb,
  ) async {
    final db = await database;
    return await db!.update(
      tb,
      device2.toMap(),
      where: 'guid = ?',
      whereArgs: [device2.guid],
    );
  }

// fungsi hapus data
  Future<int> deleteDevice(String guid, String tb) async {
    Database? db = await this.database;
    int count = await db!.delete(tb, where: 'guid=?', whereArgs: [guid]);
    return count;
  }
}
