import 'dart:convert';

import 'package:abag_admin/registration/registration.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../constants.dart';

class AllAgents extends StatefulWidget {
  const AllAgents({Key? key}) : super(key: key);

  @override
  _AllAgentsState createState() => _AllAgentsState();
}

class _AllAgentsState extends State<AllAgents> {
  late List allAgents = [];
  bool isLoading = true;
  late var agentItems;

  fetchAgents()async{
    const url = "https://africanbankersassociationofghana.xyz/agents";
    var myLink = Uri.parse(url);
    final response = await http.get(myLink);

    if(response.statusCode ==200){
      final codeUnits = response.body.codeUnits;
      var jsonData = const Utf8Decoder().convert(codeUnits);
      allAgents = json.decode(jsonData);
    }

    setState(() {
      isLoading = false;
      allAgents = allAgents;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAgents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Available Agents"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              setState(() {
                isLoading = true;
              });
              fetchAgents();
            },
          )
        ],
      ),
      body: SafeArea(
          child:
          isLoading ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                    strokeWidth: 5,
                  )
              ),
            ],
          ) : ListView.builder(
              itemCount: allAgents != null ? allAgents.length : 0,
              itemBuilder: (context,i){
                agentItems = allAgents[i];
                return Column(
                  children: [
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8),
                      child: Card(
                        elevation: 12,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        // shadowColor: Colors.pink,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 18.0,bottom: 18),
                          child: ListTile(
                            leading: const CircleAvatar(
                                backgroundColor: primaryColor,
                                foregroundColor: Colors.white,
                                child: Icon(Icons.person)
                            ),
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: Text(agentItems['agent_display_code'],style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(child: Text(agentItems['region'],style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
                                    const Divider(),

                                    Expanded(child: Text(agentItems['phone'],style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }
          )
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: (){
          Get.to(()=> const AgentRegistration());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
