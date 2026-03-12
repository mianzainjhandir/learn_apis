
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:learn_apis/model/photos_model.dart';

class ExampleTwo extends StatefulWidget {
  const ExampleTwo({super.key});

  @override
  State<ExampleTwo> createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleTwo> {

  List<Photos> photosList = [];

  Future<List<Photos>> getPhotosApi() async{
    final respnse = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(respnse.body.toString());
    if(respnse.statusCode == 200){
      for(Map i in data){
        Photos photos = Photos(title: i['title'], url: i['url'], thumbnailUrl: i['thumbnailUrl'], id: i['id']);
        photosList.add(photos);
      }
      return photosList;

    }else{
      return photosList;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text("API Fetching",style: TextStyle(color: Colors.white),),

      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                future: getPhotosApi(),
                  builder: (context, AsyncSnapshot<List<Photos>>snapshot){
                    return ListView.builder(
                        itemCount: photosList.length,
                        itemBuilder: (context, index){
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                        ),
                        subtitle: Text(snapshot.data![index].title.toString()),
                        title: Text('Notes id:${snapshot.data![index].id}'),

                      );
                    });
                  },
              )
          ),
        ],
      ),
    );
  }
}

