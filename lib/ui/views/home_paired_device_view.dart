import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tekido_homeautomation/constants/route_name.dart';
import 'package:tekido_homeautomation/models/model_data1.dart';
import 'package:tekido_homeautomation/models/model_data_paired.dart';
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            child: Text('SENSOR'),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Text('AKTUATOR'),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Text('ACTION'),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                          ),
                        )
                      ],
                    ),
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
                                    .map((Device1 device) => Table(
                                  border: TableBorder.all(),
                                  columnWidths: const <int, TableColumnWidth>{
                                    0: IntrinsicColumnWidth(),
                                    1: FlexColumnWidth(),
                                    2: FixedColumnWidth(64),
                                  },
                                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                  children: <TableRow>[
                                    TableRow(
                                      children: <Widget>[
                                        TableCell(
                                          verticalAlignment: TableCellVerticalAlignment.top,
                                          child: Container(
                                            height: 32,
                                            width: 32,
                                            color: Colors.red,
                                          ),
                                        ),
                                        Container(
                                          height: 64,
                                          color: Colors.blue,
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                                ).toList(),
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
        )
    );
  }
}
