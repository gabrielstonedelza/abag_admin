import 'package:abag_admin/registration/registration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

class RegistrationSuccess extends StatelessWidget {
  const RegistrationSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Congratulations"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          const Center(
              child: Text(
            "Agent registration was successful.",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          )),
          const SizedBox(
            height: 20,
          ),
          RawMaterialButton(
            onPressed: () {
              Get.offAll(() => const AgentRegistration());
            },
            shape: const StadiumBorder(),
            elevation: 8,
            child: const Padding(
              padding: EdgeInsets.all(18.0),
              child: Text(
                "Register another agent",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
            ),
            fillColor: primaryColor,
            splashColor: defaultColor,
          ),
        ],
      )),
    );
  }
}
