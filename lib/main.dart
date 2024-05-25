import 'package:flutter/material.dart';
import 'package:vehicle_form/vehicle_form_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Iterative Form Example',
      home: VehicleForm(),
    );
  }
}
