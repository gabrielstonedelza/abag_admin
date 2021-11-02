import 'package:abag_admin/agents/allagents.dart';
import 'package:abag_admin/constants.dart';
import 'package:abag_admin/registration/registration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Welcome to Abag Admin"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 30,),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => const AgentRegistration());
                      },
                      child: Column(
                        children:  [
                          Image.asset(
                            "assets/images/follow.png",
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Register Agent",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => const AllAgents());
                      },
                      child: Column(
                        children:  [
                          Image.asset(
                            "assets/images/man.png",
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "All Agents",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
