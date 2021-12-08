import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tekido_homeautomation/constants/route_name.dart';
import 'package:tekido_homeautomation/models/model_data1.dart';
import 'package:tekido_homeautomation/ui/views/dashboard_view.dart';
import 'package:tekido_homeautomation/ui/views/home_paired_device_view.dart';
import 'package:tekido_homeautomation/ui/views/input_device_list.dart';
import 'package:tekido_homeautomation/ui/views/output_device_list.dart';
import 'package:tekido_homeautomation/ui/views/paired_device_view.dart';
import 'package:tekido_homeautomation/ui/views/qr_scanner_view.dart';
import 'package:tekido_homeautomation/ui/views/scan_device_view.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  switch (settings.name){
    case DashboardViewRoute:
      return _pageRoute(
          routeName: settings.name,
          viewToShow: DashboardView()
      );
    case QrViewRoute:
      return _pageRoute(
          routeName: settings.name,
          viewToShow: QRViewExample()
      );
    case ScanDeviceViewRoute:
      return _pageRoute(
          routeName: settings.name,
          viewToShow: ScanDeviceView()
      );
    case PairedDeviceViewRoute:
      return _pageRoute(
          routeName: settings.name,
          viewToShow: PairedDeviceView()
      );
    case InputDeviceListRoute:
      return _pageRoute(
          routeName: settings.name,
          viewToShow: InputDeviceList()
      );
    case OutputDeviceListRoute:
      return _pageRoute(
          routeName: settings.name,
          viewToShow: OutputDeviceList()
      );
    case HomePairedDeviceViewRoute:
      return _pageRoute(
          routeName: settings.name,
          viewToShow: HomePairedDeviceView()
      );
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text(
              'No route defined for ${settings.name}',
            ),
          ),
        ),
      );
  }
}


PageRoute _pageRoute({String? routeName, required Widget viewToShow}) {
  return MaterialPageRoute(
      builder: (_) => viewToShow,
      settings: RouteSettings(
          name: routeName
      )
  );
}