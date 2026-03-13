import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import 'model/user_model.dart';

class ExampleThree extends StatefulWidget {
  const ExampleThree({super.key});

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {

  List<UserModel> userList = [];

  Future<List<UserModel>> getUsers()async{
    
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for (var i in data) {
        userList.add(UserModel.fromJson(i as Map<String, dynamic>));
      }
      return userList;
    }else{
      return userList;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text("Api Testing"),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: getUsers(),
                  builder: (context,AsyncSnapshot<List<UserModel>> snapshot){
                    if(!snapshot.hasData){
                      return CircularProgressIndicator();
                    }else{
                      return ListView.builder(
                          itemCount: userList.length,
                          itemBuilder: (context, index){
                            return Card(
                              elevation: 4,
                              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [

                                    Row(
                                      children: [
                                        const CircleAvatar(
                                          radius: 22,
                                          child: Icon(Icons.person),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          snapshot.data![index].name.toString(),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),

                                    const SizedBox(height: 15),
                                    const Divider(),

                                    ReuseRow(
                                      title: 'UserName',
                                      value: snapshot.data![index].username.toString(),
                                    ),

                                    ReuseRow(
                                      title: 'Email',
                                      value: snapshot.data![index].email.toString(),
                                    ),

                                    ReuseRow(
                                      title: 'Address',
                                      value: snapshot.data![index].address!.geo!.lat.toString(),
                                    ),

                                  ],
                                ),
                              ),
                            );
                          });

                    }

                  }
              )
          )
        ],
      ),
    );
  }
}

class ReuseRow extends StatelessWidget {

  final String title;
  final String value;

  const ReuseRow({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(value),
        ],
      ),
    );
  }
}