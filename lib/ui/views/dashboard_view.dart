import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tekido_homeautomation/constants/route_name.dart';
import 'package:tekido_homeautomation/ui/shared/ui_helper.dart';
import 'package:tekido_homeautomation/ui/views/home_paired_device_view.dart';
import 'package:tekido_homeautomation/ui/views/input_device_list.dart';
import 'package:tekido_homeautomation/ui/views/output_device_list.dart';
import 'package:tekido_homeautomation/ui/views/qr_scanner_view.dart';
import 'package:tekido_homeautomation/viewmodels/dashboard_view_model.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
        viewModelBuilder: () => DashboardViewModel(),
        onModelReady: (model) => model.initState(),
        builder: (context, model, child) => Scaffold(
          backgroundColor: Color(0xffF1F4F6),
          appBar: AppBar(
            backgroundColor: Colors.blue,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              "TEKIDO Home Automation"
            ),

          ),
          body: Container(
            // child: Column(
            //   children: <Widget>[
            //     verticalSpaceMedium,
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         TextButton(
            //           onPressed: () {
            //             model.movePage(ScanDeviceViewRoute);
            //           },
            //           child: const Text(
            //             "Scan Device",
            //             style: TextStyle(color: Colors.black),
            //           ),
            //         ),
            //         TextButton(
            //           onPressed: () {
            //             model.movePage(HomePairedDeviceViewRoute);
            //           },
            //           child: const Text(
            //             "Paired Device",
            //             style: TextStyle(color: Colors.black),
            //           ),
            //         ),
            //       ],
            //     )
            //   ],
            // ),
            child: DefaultTabController(
              length: 3,
              initialIndex: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue)
                    ),
                    child: TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(text: 'SENSOR'),
                        Tab(text: 'AKTUATOR'),
                        Tab(text: 'RULE'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: TabBarView(
                        children: [
                          InputDeviceList(),
                          OutputDeviceList(),
                          HomePairedDeviceView(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}
