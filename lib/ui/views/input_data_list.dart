import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tekido_homeautomation/models/model_data1.dart';
import 'package:tekido_homeautomation/ui/shared/ui_helper.dart';
import 'package:tekido_homeautomation/viewmodels/paired_device_view_model.dart';

class InputDataList extends StatefulWidget {
  const InputDataList({Key? key}) : super(key: key);

  @override
  _InputDataListState createState() => _InputDataListState();
}

class _InputDataListState extends State<InputDataList> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PairedDeviceViewModel>.reactive(
      viewModelBuilder: () => PairedDeviceViewModel(),
      onModelReady: (model) {
        model.initState();
      },
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('List Device Input'),
          ),
          body: Container(
            color: Colors.white,
            margin: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    height: MediaQuery.of(context).size.height / 1.3,
                    width: MediaQuery.of(context).size.width,
                    child: FutureBuilder(
                      future: model.getInputDataList(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Device1>> snapshot) {
                        if (snapshot.hasData) {
                          List<Device1>? devices = snapshot.data;
                          return Container(
                            child: ListView(
                              children: devices!
                                  .map((Device1 device) => Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: OutlinedButton(
                                      onPressed: () {model.saveInputData(device.alias, device.guid, device.mac, device.minor, device.name, device.quantity, device.type, device.version);},
                                      child: Text(device.alias))))
                                  .toList(),
                            ),
                          );
                        } else {
                          return Center(
                            child: Container(
                              child: Text("Device not detected"),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
