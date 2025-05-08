// lib/utils/connectivity_wrapper.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityWrapper extends StatefulWidget {
  final Widget child;
  const ConnectivityWrapper({super.key, required this.child});

  @override
  ConnectivityWrapperState createState() => ConnectivityWrapperState();
}

class ConnectivityWrapperState extends State<ConnectivityWrapper> {
  late final StreamSubscription<ConnectivityResult> _sub;
  bool _wasOnline = true;

  @override
  void initState() {
    super.initState();
    _sub = Connectivity().onConnectivityChanged.listen((
      ConnectivityResult result,
    ) {
      final isOnline = result != ConnectivityResult.none;
      if (isOnline != _wasOnline) {
        _wasOnline = isOnline;
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(isOnline ? 'Сеть восстановлена' : 'Нет сети'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
