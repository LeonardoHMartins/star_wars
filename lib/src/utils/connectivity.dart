// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> checkConnectivity() async {
  try {
    ConnectivityResult connectivity = await Connectivity().checkConnectivity();

    switch (connectivity) {
      case ConnectivityResult.mobile:
        return true;
      case ConnectivityResult.wifi:
        return true;
      case ConnectivityResult.ethernet:
        return true;
      case ConnectivityResult.none:
        return false;
      default:
        return false;
    }
  } catch (err) {
    return false;
  }
}
