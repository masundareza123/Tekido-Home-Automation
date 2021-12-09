import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tekido_homeautomation/constants/route_name.dart';
import 'package:tekido_homeautomation/models/model_data1.dart';
import 'package:tekido_homeautomation/models/model_data_paired.dart';
import 'package:tekido_homeautomation/ui/shared/ui_helper.dart';
import 'package:tekido_homeautomation/viewmodels/home_paired_device_view_model.dart';

class HomePairedDeviceView extends StatefulWidget {
  const HomePairedDeviceView({Key? key}) : super(key: key);

  @override
  _HomePairedDeviceViewState createState() => _HomePairedDeviceViewState();
}

class _HomePairedDeviceViewState extends State<HomePairedDeviceView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomePairedDeviceViewModel>.reactive(
        viewModelBuilder: () => HomePairedDeviceViewModel(),
        builder: (context, model, child) => SafeArea(
              child: Container(
                margin: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            model.movePage(PairedDeviceViewRoute);
                          },
                          child: Text(
                            'Paired Device',
                            style: TextStyle(fontSize: 20),
                          )),
                      Container(
                        // padding: EdgeInsets.only(top: 5),
                        height: MediaQuery.of(context).size.height / 1.3,
                        width: MediaQuery.of(context).size.width,
                        child: FutureBuilder(
                          future: model.getPairedDataList(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<PairedDevice>> snapshot) {
                            if (snapshot.hasData) {
                              List<PairedDevice>? devices = snapshot.data;
                              return Container(
                                child: ListView(
                                  children: devices!
                                      .map((PairedDevice device) => Container(
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
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Sensor    : ',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 20)),
                                                    verticalSpaceSmall,
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          device.inputName,
                                                          style: TextStyle(
                                                              color: Colors.grey,fontSize: 20),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Aktuator : ',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 20)),
                                                    verticalSpaceSmall,
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          device.outputName,
                                                          style: TextStyle(
                                                              color: Colors.grey,fontSize: 20),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
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
                    ],
                  ),
                ),
              ),
            ));
  }
}
