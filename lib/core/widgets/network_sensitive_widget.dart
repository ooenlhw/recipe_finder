import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:recipe_finder/core/network/network_checker.dart';

class NetworkSensitiveWidget extends StatefulWidget {
  final Widget child;

  const NetworkSensitiveWidget({required this.child, Key? key})
      : super(key: key);

  @override
  State<NetworkSensitiveWidget> createState() => _NetworkSensitiveWidgetState();
}

class _NetworkSensitiveWidgetState extends State<NetworkSensitiveWidget> {
  bool _isOffline = false;

  @override
  void initState() {
    super.initState();
    _checkConnection();
    Connectivity().onConnectivityChanged.listen((_) => _checkConnection());
  }

  Future<void> _checkConnection() async {
    final online = await NetworkChecker.isOnline();
    if (mounted) {
      setState(() {
        _isOffline = !online;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isOffline) {
      return Scaffold(
        appBar: AppBar(
            title: Text('No Internet',
                style: Theme.of(context).textTheme.headlineLarge)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.wifi_off, size: 80, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'No Internet Connection',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
      );
    }
    return widget.child;
  }
}
