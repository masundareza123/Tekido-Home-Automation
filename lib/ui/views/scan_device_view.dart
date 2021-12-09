import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tekido_homeautomation/constants/route_name.dart';
import 'package:tekido_homeautomation/ui/shared/ui_helper.dart';
import 'package:tekido_homeautomation/viewmodels/scan_device_view_model.dart';

class ScanDeviceView extends StatefulWidget {
  const ScanDeviceView({Key? key}) : super(key: key);

  @override
  _ScanDeviceViewState createState() => _ScanDeviceViewState();
}

class _ScanDeviceViewState extends State<ScanDeviceView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ScanDeviceViweModel>.reactive(
        viewModelBuilder: () => ScanDeviceViweModel(),
        onModelReady: (model) => model.getTask(),
        builder: (context, model, child) => SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text(
                    'Scan Device Page'
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      model.movePage(QrViewRoute);
                    },
                    icon: Icon(Icons.qr_code_scanner),
                    iconSize: 25,
                    color: Colors.white,
                  )
                ],
              ),
              body: Container(
                  margin: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: TextButton(
                            onPressed: () {
                              model.movePage(QrViewRoute);
                            },
                            child: const Text(
                              "Scan QR Code",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        verticalSpaceLarge,
                        TextField(
                          enabled: false,
                          controller: model.guidController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "GUID"),
                        ),
                        verticalSpaceMedium,
                        TextField(
                          enabled: true,
                          controller: model.aliasController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Device Alias"),
                        ),
                        verticalSpaceMedium,
                        TextField(
                          enabled: false,
                          controller: model.nameController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Device Name"),
                        ),
                        verticalSpaceMedium,
                        TextField(
                          enabled: false,
                          controller: model.typeController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Type Device"),
                        ),
                        verticalSpaceMedium,
                        TextButton(
                          onPressed: () {
                            model.registerDevice(context);
                          },
                          child: const Text(
                            "Save Data Device",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
        ),
    );
  }
}
