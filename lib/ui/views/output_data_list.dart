import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tekido_homeautomation/models/model_data1.dart';
import 'package:tekido_homeautomation/models/model_data2.dart';
import 'package:tekido_homeautomation/viewmodels/paired_device_view_model.dart';

class OutputDataList extends StatefulWidget {
  const OutputDataList({Key? key}) : super(key: key);

  @override
  _OutputDataListState createState() => _OutputDataListState();
}

class _OutputDataListState extends State<OutputDataList> {
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
                      future: model.getOutputDataList(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Device2>> snapshot) {
                        if (snapshot.hasData) {
                          List<Device2>? devices = snapshot.data;
                          return Container(
                            child: ListView(
                              children: devices!
                                  .map((Device2 device) => Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: OutlinedButton(
                                          onPressed: () {
                                            model.saveOutputData(
                                                device.alias,
                                                device.guid,
                                                device.mac,
                                                device.minor,
                                                device.name,
                                                device.quantity,
                                                device.type,
                                                device.version);
                                          },
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
