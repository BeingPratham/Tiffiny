import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:http/http.dart' as http;

class InformationPage extends StatefulWidget {
  String phone = "";
  InformationPage({required this.phone});

  @override
  _InformationPage createState() => _InformationPage();
}

class _InformationPage extends State<InformationPage> {
  int _activeStepIndex = 0;
  bool _validateName = false;
  bool _validateHouse = false;
  bool _validateStreet = false;
  bool _validateCity = false;
  bool _validateState = false;
  bool _validatePincode = false;
  TextEditingController name = TextEditingController();
  TextEditingController houseInfo = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController pincode = TextEditingController();

  Future<void> insertRecord() async {
    if (name.text != "" &&
        houseInfo.text != "" &&
        street.text != "" &&
        city.text != "" &&
        state.text != "" &&
        pincode.text != "") {
      String url = "https://mytiffiny.000webhostapp.com/insert_Record.php";
      var res = await http.post(Uri.parse(url), body: {
        "name": name.text,
        "phone": widget.phone,
        "type": "user",
        "houseInfo": houseInfo.text,
        "street": street.text,
        "city": city.text,
        "state": state.text,
        "pincode": pincode.text
      });
      // var response = await jsonDecode(res.body);
      // if (response["success"] == "true") {
      //   print("Record Inserted");
      // } else {
      //   print("Some Issues");
      // }
    }
  }

  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Name'),
          content: Container(
            child: Column(
              children: [
                TextField(
                  controller: name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: widget.phone,
                    errorText: _validateName ? 'Value Can\'t Be Empty' : null,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
        Step(
            state:
                _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 1,
            title: const Text('Address'),
            content: Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: houseInfo,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'House Number and Name',
                      errorText:
                          _validateHouse ? 'Value Can\'t Be Empty' : null,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: street,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Street',
                      errorText:
                          _validateStreet ? 'Value Can\'t Be Empty' : null,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: city,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'City',
                      errorText: _validateCity ? 'Value Can\'t Be Empty' : null,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: state,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'State',
                      errorText:
                          _validateState ? 'Value Can\'t Be Empty' : null,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: pincode,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Pin Code',
                      errorText:
                          _validatePincode ? 'Value Can\'t Be Empty' : null,
                    ),
                  ),
                ],
              ),
            )),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Information'),
        backgroundColor: Colors.amber,
      ),
      body: Stepper(
          type: StepperType.horizontal,
          currentStep: _activeStepIndex,
          steps: stepList(),
          onStepContinue: () {
            if (_activeStepIndex == 0) {
              setState(() {
                if (name.text.isEmpty) {
                  _validateName = true;
                } else {
                  _validateName = false;
                }
              });
              if (_validateName == false) {
                if (_activeStepIndex == 0) {
                  setState(() {
                    _activeStepIndex += 1;
                  });
                }
              } else {
                null;
              }
            } else {
              setState(() {
                houseInfo.text.isEmpty
                    ? _validateHouse = true
                    : _validateHouse = false;
                street.text.isEmpty
                    ? _validateStreet = true
                    : _validateStreet = false;
                city.text.isEmpty
                    ? _validateCity = true
                    : _validateCity = false;
                state.text.isEmpty
                    ? _validateState = true
                    : _validateState = false;
                pincode.text.isEmpty
                    ? _validatePincode = true
                    : _validatePincode = false;
              });
              if (_validateHouse == false &&
                  _validateStreet == false &&
                  _validateCity == false &&
                  _validateState == false &&
                  _validatePincode == false) {
                if (_activeStepIndex <= 1) {
                  setState(() {
                    _activeStepIndex += 1;
                  });
                  // if (_activeStepIndex == 2) {
                  //   insertRecord();
                  //   Navigator.pushNamed(context, 'home');
                  // }
                }
              } else {
                null;
              }
            }
          },
          onStepCancel: () {
            if (_activeStepIndex == 0) {
              return;
            }

            setState(() {
              _activeStepIndex -= 1;
            });
          },
          onStepTapped: (int index) {
            setState(() {
              _activeStepIndex = index;
            });
          },
          controlsBuilder: (context, details) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  _activeStepIndex == 0
                      ? ElevatedButton(
                          onPressed: details.onStepContinue,
                          child: const Text('Next'),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            insertRecord();
                            // Navigator.pushNamed(context, 'home');
                          },
                          child: const Text('Submit'),
                        ),
                  const SizedBox(width: 10),
                  _activeStepIndex == 1
                      ? OutlinedButton(
                          onPressed: details.onStepCancel,
                          child: const Text('Back'),
                        )
                      : Container(),
                ],
              ),
            );
          }),
    );
  }
}
