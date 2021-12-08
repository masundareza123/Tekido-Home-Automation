import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tekido_homeautomation/constants/route_name.dart';
import 'package:tekido_homeautomation/models/model_data1.dart';
import 'package:tekido_homeautomation/models/model_data2.dart';
import 'package:tekido_homeautomation/ui/shared/ui_helper.dart';
import 'package:tekido_homeautomation/viewmodels/paired_device_view_model.dart';

class OutputDeviceList extends StatefulWidget {
  const OutputDeviceList({Key? key}) : super(key: key);

  @override
  _OutputDeviceListState createState() => _OutputDeviceListState();
}

class _OutputDeviceListState extends State<OutputDeviceList> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PairedDeviceViewModel>.reactive(
      viewModelBuilder: () => PairedDeviceViewModel(),
      // onModelReady: (model) {
      //   model.initState();
      // },
      builder: (context, model, child) => SafeArea(
        child: Container(
          margin: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OutlinedButton(onPressed: (){model.movePage(ScanDeviceViewRoute);}, child: Text('Register', style: TextStyle(fontSize: 20),)),
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
                              margin: EdgeInsets.only(top: 10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10))),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(device.alias,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20)),
                                  verticalSpaceSmall,
                                  Text(
                                    device.name,
                                    style:
                                    TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    device.guid,
                                    style:
                                    TextStyle(color: Colors.grey),
                                  ),
                                  verticalSpaceTiny
                                ],
                              ),
                            ))
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
                )
                // Container(
                //   margin: EdgeInsets.all(15.0),
                //   child: DropdownButton(
                //     isExpanded: true,
                //     hint: const Text('Chose input device'),
                //     value: model.inputSelection,
                //     items: model.inputDevice.isEmpty
                //         ? null
                //         : model.inputDevice.map(
                //             (value) {
                //               return DropdownMenuItem(
                //                 child: Text(value.guid),
                //                 value: value.guid,
                //               );
                //             },
                //           ).toList(),
                //     onChanged: (String? value) {
                //       setState(() {
                //         model.inputSelection = value!;
                //       });
                //       model.onChangedInput(value!);
                //     },
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.all(15.0),
                //   child: DropdownButton(
                //     isExpanded: true,
                //     items: <String>['One', 'Two', 'Free', 'Four']
                //         .map<DropdownMenuItem<String>>((String value) {
                //       return DropdownMenuItem<String>(
                //         value: value,
                //         child: Text(value),
                //       );
                //     }).toList(),
                //     value: dropdownValue2,
                //     onChanged: (String? newValue) {
                //       setState(() {
                //         dropdownValue2 = newValue!;
                //       });
                //     },
                //   ),
                // ),
                // verticalSpaceLarge,
                // TextButton(
                //   onPressed: () {
                //     //model.registerDevice(context);
                //   },
                //   child: const Text(
                //     "Paired Device",
                //     style: TextStyle(color: Colors.black),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
