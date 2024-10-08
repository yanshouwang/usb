import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:usb/usb.dart';

void main() {
  runZonedGuarded(startUp, handleUncaughtError);
}

void startUp() async {
  runApp(const MyApp());
}

void handleUncaughtError(Object error, StackTrace stack) {
  log(
    '$error',
    error: error,
    stackTrace: stack,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'USB',
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final USBManager usbManager;
  late final ValueNotifier<List<String>> logs;
  late final StreamSubscription<USBDevice> deviceAttachedSubscription;
  late final StreamSubscription<USBDevice> deviceDetachedSubscription;

  @override
  void initState() {
    super.initState();
    usbManager = USBManager();
    logs = ValueNotifier([]);
    deviceAttachedSubscription = usbManager.deviceAttached.listen(
      onAttached,
    );
    deviceDetachedSubscription = usbManager.deviceDetached.listen(
      onDeatched,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: logs,
        builder: (context, logs, child) {
          return ListView.builder(
            itemBuilder: (context, i) {
              final log = logs[i];
              return Text(log);
            },
            itemCount: logs.length,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    deviceAttachedSubscription.cancel();
    deviceDetachedSubscription.cancel();
    logs.dispose();
  }

  void onAttached(USBDevice device) async {
    final time = DateTime.now();
    final formattedTime = DateFormat.Hms().format(time);
    final vendorId = await device.getVendorId();
    final productId = await device.getProductId();
    final log =
        '[$formattedTime] onAttached: ${vendorId.toHexString()} - ${productId.toHexString()}';
    logs.value = [
      ...logs.value,
      log,
    ];
  }

  void onDeatched(USBDevice device) async {
    final time = DateTime.now();
    final formattedTime = DateFormat.Hms().format(time);
    final vendorId = await device.getVendorId();
    final productId = await device.getProductId();
    final log =
        '[$formattedTime] onDeatched: ${vendorId.toHexString()} - ${productId.toHexString()}';
    logs.value = [
      ...logs.value,
      log,
    ];
  }
}

extension on int {
  String toHexString() {
    return '0x${toRadixString(16).padLeft(4, '0')}';
  }
}
