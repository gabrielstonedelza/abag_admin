import 'dart:async';
import 'package:abag_admin/constants.dart';
import 'package:abag_admin/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
import 'package:twilio_flutter/twilio_flutter.dart';

class AgentRegistration extends StatefulWidget {
  const AgentRegistration({Key? key}) : super(key: key);

  @override
  _AgentRegistrationState createState() => _AgentRegistrationState();
}

class _AgentRegistrationState extends State<AgentRegistration> {
  late TwilioFlutter twilioFlutter = TwilioFlutter(
      accountSid:
          '', // replace *** with Account SID
      authToken:
          '', // replace xxx with Auth Token
      twilioNumber: '+1 408 556 9136' // replace .... with Twilio Number
      );
  final _formKey = GlobalKey<FormState>();
  final List regions = [
    "Ashanti",
    "Greater Accra",
    "Brong-Ahafo",
    "Northern",
    "Central",
    "Upper East",
    "Upper West"
    "Eastern"
    "Volta"
    "Western"
  ];
  bool isPosting = false;
  bool errorThrown = false;
  bool isObscured = true;
  var _currentSelectedRegion = "Ashanti";
  late final TextEditingController _userName = TextEditingController();
  late final TextEditingController _userEmail = TextEditingController();
  late final TextEditingController _userPhone = TextEditingController();
  late final TextEditingController _userCompany = TextEditingController();
  late final TextEditingController _userFullName = TextEditingController();
  late final TextEditingController _agentCode = TextEditingController();
  late final TextEditingController _userPassword = TextEditingController();
  late final TextEditingController _userRePassword = TextEditingController();
  late List users = [];
  bool userExists = false;
  late List userNumbers = [];


  validateForm(String message) {
    return Alert(
      context: context,
      type: AlertType.error,
      title: "Post Error",
      desc: message,
      buttons: [
        DialogButton(
          child: const Text(
            "Close",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }
  registerAgent()async{
    const registerUrl = "https://africanbankersassociationofghana.xyz/auth/users/";
    final myLink = Uri.parse(registerUrl);
    final res = await http.post(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "username": _userName.text,
      "email": _userEmail.text,
      "phone": _userPhone.text,
      "company_name": _userCompany.text,
      "full_name": _userFullName.text,
      "region": _currentSelectedRegion,
      "agent_code": _agentCode.text,
      "password": _userPassword.text,
      "re_password": _userRePassword.text,
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Adding agent to system Please wait'),
      action: SnackBarAction(
        label: '',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    ));
    if (res.statusCode == 201) {
      String dnum = _userPhone.text;
      dnum = dnum.substring(1);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        content: const Text('Agent account created successfully'),
        action: SnackBarAction(
          label: '',
          onPressed: () {},
        ),
      ));
    twilioFlutter.sendSMS(
        toNumber: '+233$dnum',
        messageBody:
        'Welcome ${_userCompany.text}, you are now registered on ABAG System.Your agent code is ${_agentCode.text} and your password is ${_userPassword.text}.Please click on forgot password at the login page and change your password.For more information please kindly call 0244950505.');
      Timer(const Duration(seconds: 5),() => Get.offAll(()=> const HomePage()));

    }
    if (res.statusCode == 400) {
      setState(() {
        errorThrown = true;
      });
      validateForm(res.body.toString());
    } else if (res.statusCode == 401) {
      setState(() {
        errorThrown = true;
      });
      validateForm(res.body.toString());
    } else if (res.statusCode == 404) {
      setState(() {
        errorThrown = true;
      });
      validateForm(res.body.toString());
    } else if (res.statusCode == 400) {
      setState(() {
        errorThrown = true;
      });
      validateForm(res.body.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Agent Registration"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  const SizedBox(height:30),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        controller: _userName,
                        cursorColor: primaryColor,
                        cursorRadius: const Radius.elliptical(10, 10),
                        cursorWidth: 10,
                        decoration: InputDecoration(
                            hintText: "Pick a username",
                            focusColor: primaryColor,
                            fillColor: primaryColor,
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: primaryColor, width: 2),
                                borderRadius: BorderRadius.circular(12)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12))),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Please enter a username";
                          }
                        },
                      ),
                    ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        controller: _userEmail,
                        cursorColor: primaryColor,
                        cursorRadius: const Radius.elliptical(10, 10),
                        cursorWidth: 10,
                        decoration: InputDecoration(
                            hintText: "Enter your email",
                            focusColor: primaryColor,
                            fillColor: primaryColor,
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: primaryColor, width: 2),
                                borderRadius: BorderRadius.circular(12)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12))),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Please enter your email";
                          }
                        },
                      ),
                    ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        controller: _userPhone,
                        cursorColor: primaryColor,
                        cursorRadius: const Radius.elliptical(10, 10),
                        cursorWidth: 10,
                        decoration: InputDecoration(
                            hintText: "Enter your phone number",
                            focusColor: primaryColor,
                            fillColor: primaryColor,
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: primaryColor, width: 2),
                                borderRadius: BorderRadius.circular(12)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12))),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Please enter your phone number";
                          }
                        },
                      ),
                    ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        controller: _userCompany,
                        cursorColor: primaryColor,
                        cursorRadius: const Radius.elliptical(10, 10),
                        cursorWidth: 10,
                        decoration: InputDecoration(
                            hintText: "Enter company name",
                            focusColor: primaryColor,
                            fillColor: primaryColor,
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: primaryColor, width: 2),
                                borderRadius: BorderRadius.circular(12)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12))),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Please enter your company name";
                          }
                        },
                      ),
                    ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        controller: _userFullName,
                        cursorColor: primaryColor,
                        cursorRadius: const Radius.elliptical(10, 10),
                        cursorWidth: 10,
                        decoration: InputDecoration(
                            hintText: "Enter your full name",
                            focusColor: primaryColor,
                            fillColor: primaryColor,
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: primaryColor, width: 2),
                                borderRadius: BorderRadius.circular(12)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12))),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Please enter your full name";
                          }
                        },
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey, width: 1)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: DropdownButton(
                          hint: const Text("Select Network"),
                          isExpanded: true,
                          underline: const SizedBox(),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20),
                          items: regions.map((dropDownStringItem) {
                            return DropdownMenuItem(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem),
                            );
                          }).toList(),
                          onChanged: (newValueSelected) {
                            _onDropDownItemSelectedId(newValueSelected);
                          },
                          value: _currentSelectedRegion,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        controller: _agentCode,
                        cursorColor: primaryColor,
                        cursorRadius: const Radius.elliptical(10, 10),
                        cursorWidth: 10,
                        decoration: InputDecoration(
                            hintText: "agent code,should be 6 characters maximum",
                            focusColor: primaryColor,
                            fillColor: primaryColor,
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: primaryColor, width: 2),
                                borderRadius: BorderRadius.circular(12)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12))),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Please enter agent code";
                          }
                        },
                      ),
                    ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        controller: _userPassword,
                        cursorColor: primaryColor,
                        cursorRadius: const Radius.elliptical(10, 10),
                        cursorWidth: 10,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock,color: primaryColor,),
                            suffixIcon: IconButton(
                              icon: Icon(isObscured ? Icons.visibility : Icons.visibility_off,color: primaryColor,),
                              onPressed: () {  setState(() {
                                isObscured = !isObscured;
                              });},
                            ),
                            hintText: "enter your password",
                            focusColor: primaryColor,
                            fillColor: primaryColor,
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: primaryColor, width: 2),
                                borderRadius: BorderRadius.circular(12)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12))),
                        keyboardType: TextInputType.text,
                        obscureText: isObscured,
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Please enter password";
                          }
                        },
                      ),
                    ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        controller: _userRePassword,
                        cursorColor: primaryColor,
                        cursorRadius: const Radius.elliptical(10, 10),
                        cursorWidth: 10,

                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock,color: primaryColor,),
                            suffixIcon: IconButton(
                              icon: Icon(isObscured ? Icons.visibility : Icons.visibility_off,color: primaryColor,),
                              onPressed: () {  setState(() {
                                isObscured = !isObscured;
                              });},
                            ),
                            hintText: "confirm your password",
                            focusColor: primaryColor,
                            fillColor: primaryColor,
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: primaryColor, width: 2),
                                borderRadius: BorderRadius.circular(12)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12))),
                        keyboardType: TextInputType.text,
                        obscureText: isObscured,
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Please confirm password";
                          }
                        },
                      ),
                    ),
                   RawMaterialButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            } else {
                              Get.defaultDialog(
                                  buttonColor: primaryColor,
                                  title: "Confirm Deposit",
                                  middleText: "Are you sure you want to add agent?",
                                  confirm: RawMaterialButton(
                                      shape: const StadiumBorder(),
                                      fillColor: primaryColor,
                                      onPressed: (){
                                        registerAgent();
                                        Get.back();
                                      }, child: const Text("Yes",style: TextStyle(color: Colors.white),)),
                                  cancel: RawMaterialButton(
                                      shape: const StadiumBorder(),
                                      fillColor: primaryColor,
                                      onPressed: (){Get.back();},
                                      child: const Text("Cancel",style: TextStyle(color: Colors.white),))
                              );
                            }
                          },
                          shape: const StadiumBorder(),
                          elevation: 8,
                          child: const Text(
                            "Save",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                          fillColor: primaryColor,
                          splashColor: defaultColor,
                        ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  void _onDropDownItemSelectedId(newValueSelected) {
    setState(() {
      _currentSelectedRegion = newValueSelected;
    });
  }
}
