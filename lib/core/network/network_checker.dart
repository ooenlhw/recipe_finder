import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkChecker {
  static Future<bool> isOnline() async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
