
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(String email, String password){

    try{

    }catch(e){
      e.toString();
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text("Sign Up Api"),
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
            Gap(10),
            TextFormField(

              controller: passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15)
                ),

                hintText: "Password",
              ),
            ),
            Gap(15),
            InkWell(
              onTap: (){
                login(emailController.text.toString(), passwordController.text.toString());
              },
              child: Container(
                height: 30,
                width: double.infinity,

                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(child: Text("Sign Up",style: TextStyle(color: Colors.white),)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
