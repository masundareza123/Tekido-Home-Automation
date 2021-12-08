import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:left_scroll_actions/left_scroll_actions.dart';
import 'package:stacked/stacked.dart';
import 'package:tekido_homeautomation/constants/route_name.dart';
import 'package:tekido_homeautomation/models/model_data1.dart';
import 'package:tekido_homeautomation/ui/shared/ui_helper.dart';
import 'package:tekido_homeautomation/ui/views/input_device_list.dart';
import 'package:tekido_homeautomation/viewmodels/paired_device_view_model.dart';

class PairedDeviceView extends StatefulWidget {
  const PairedDeviceView({Key? key}) : super(key: key);

  @override
  _PairedDeviceViewState createState() => _PairedDeviceViewState();
}

class _PairedDeviceViewState extends State<PairedDeviceView> {
  String dropdownValue = '';
  String dropdownValue2 = 'One';

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
            title: Text('Paired Device Page'),
          ),
          body: Container(
            margin: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          model.movePage(InputDeviceListRoute);
                        },
                        child: const Text(
                          "List Input Device",
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ButtonStyle(
                          alignment: Alignment.center
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          model.movePage(OutputDeviceListRoute);
                        },
                        child: const Text(
                          "List Output Device",
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ButtonStyle(
                            alignment: Alignment.center
                        ),
                      ),
                    ],
                  ),
                  verticalSpaceLarge,
                  TextField(
                    enabled: false,
                    controller: model.inputNameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Input name device"),
                  ),
                  verticalSpaceMedium,
                  TextField(
                    enabled: false,
                    controller: model.outputNameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Output name device"),
                  ),
                  verticalSpaceMedium,
                  OutlinedButton(
                    onPressed: () {
                      model.savePairedData();
                    },
                    child: const Text(
                      "Save Data Paired",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ButtonStyle(
                        alignment: Alignment.center
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
