import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(String email, String password) async {

    try {

      http.Response response = await http.post(
        Uri.parse('https://reqres.in/api/register'),
        body: {
          'email': email,
          'password': password,
        },
      );

      print(response.statusCode);
      print(response.body);

      if(response.statusCode == 200){

        var data = jsonDecode(response.body.toString());

        Get.snackbar(
          "Success",
          "Account Created Successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }else{
        Get.snackbar(
          "Error",
          "Signup Failed",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text("Sign Up Api"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                ),
                hintText: "Email",
              ),
            ),

            const Gap(10),

            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                ),
                hintText: "Password",
              ),
            ),

            const Gap(15),

            InkWell(
              onTap: (){
                login(
                  emailController.text,
                  passwordController.text,
                );
              },
              child: Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}