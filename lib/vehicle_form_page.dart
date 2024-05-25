import 'package:flutter/material.dart';

enum VehicleType { hiAce, hiRoof, coffinCarrier, airAmbulance }

class VehicleForm extends StatefulWidget {
  const VehicleForm({super.key});

  @override
  State<VehicleForm> createState() => _VehicleFormState();
}

class _VehicleFormState extends State<VehicleForm> {
  List<GlobalKey<FormState>> formKey = [GlobalKey<FormState>()];
  List<Map<String, dynamic>> vehicles = [{}];

  vehicleTypeToString(VehicleType type) {
    switch (type) {
      case VehicleType.hiAce:
        return 'Hi-Ace';
      case VehicleType.hiRoof:
        return 'Hi-Roof';
      case VehicleType.coffinCarrier:
        return 'Coffin-Carrier';
      case VehicleType.airAmbulance:
        return 'Air-Ambulance';
      default:
        return null;
    }
  }

  // Method to handle form submission
  void submitForms() {
    bool allValid = true;
    for (int i = 0; i < formKey.length; i++) {
      if (!formKey[i].currentState!.validate()) {
        allValid = false;
      } else {
        formKey[i].currentState!.save();
      }
    }
    if (allValid) {
      debugPrint('All forms are valid. Submitting data...');
      // Process the collected data in _vehicles
      debugPrint("$vehicles");
      // You can also clear the forms or navigate to another page if needed
    } else {
      debugPrint(
          'Some forms are invalid. Please correct the errors and try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iterative Vehicle Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: vehicles.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Form(
                  key: formKey[index],
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "Vehicle Number",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter vehicle number';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          vehicles[index]['vehicleNumber'] = newValue;
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      DropdownButtonFormField<VehicleType>(
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a vehicle type';
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Select Vehicle Type',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        items: VehicleType.values.map((VehicleType type) {
                          return DropdownMenuItem(
                              value: type,
                              child: Text(vehicleTypeToString(type)!));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            vehicles[index]['vehicleType'] = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
                index == vehicles.length - 1
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: OutlinedButton(
                          onPressed: () {
                            if (formKey[index].currentState?.validate() ??
                                false) {
                              formKey[index].currentState?.save();
                              setState(() {
                                formKey.add(GlobalKey<FormState>());
                                vehicles.add({});
                                debugPrint('$vehicles');
                              });
                            }
                          },
                          child: const Text('Add Vehicle'),
                        ),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(
                  height: 10,
                ),
                index == vehicles.length - 1
                    ? SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                            onPressed: submitForms,
                            child: const Text('Submit')),
                      )
                    : const SizedBox.shrink()
              ],
            );
          },
        ),
      ),
    );
  }
}
