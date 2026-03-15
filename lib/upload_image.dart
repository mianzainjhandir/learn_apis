

import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart'as http;

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {

  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;

  Future getImage()async{
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery,imageQuality: 80);

    if(pickedFile != null){
      image = File(pickedFile.path);
      setState(() {

      });
    }else{
      print('No Image Selected');
    }

  }

  Future<void> uploadImage() async{
    setState(() {
      showSpinner = true;
    });

    var stream = new http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();

    var uri = Uri.parse('https://fakestoreapi.com/products');

    var request = new http.MultipartRequest('Post', uri);

    request.fields['title'] = 'Static Title';

    var multiport = new http.MultipartFile('image', stream, length);

    request.files.add(multiport);

    var response = await request.send();

    print(response.stream.toString());
    if(response.statusCode == 201){
      print("Image Uploaded");
      setState(() {
        showSpinner = false;
      });
    }else{
      print("Failed to Upload Image");
      setState(() {
        showSpinner = false;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Upload Image",style: TextStyle(color: Colors.white),),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  getImage();
                },
                child: Container(
                  child: image == null ? Container(child: Text("Pick Image"),)
                      :Container(
                    child: Center(
                      child: Image.file(File(image!.path).absolute,
                      height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ),
              ),

              Gap(50),

              GestureDetector(
                onTap: (){
                  uploadImage();
                },
                child: Container(
                  color: Colors.green,
                  height: 45,
                  width: 150,
                  child: Center(child: Text("Upload",style: TextStyle(color: Colors.white),)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
