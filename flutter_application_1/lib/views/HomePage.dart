

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/Services/Location/checkPermission.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Position? position ;
  double distanceInMeters = 0;
  String warning = "" ;
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    

  }

  @override
  Widget build(BuildContext context) {

    
    

    String location = "" ;

    
    return Scaffold(
      appBar: AppBar(),

      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 50,
                child: TextField(
                  controller: myController1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Latitude',
                  ),
                ),
              ),
              SizedBox(width: 20),
              SizedBox(
                width: 100,
                height: 50,
                child: TextField(
                  controller: myController2,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Longitude',
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                try{
                  await determinePosition();
                  position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                  
                  distanceInMeters = Geolocator.distanceBetween(double.parse(myController1.text), double.parse(myController2.text), position!.latitude , position!.longitude);
                  
                  setState(() {
                    location = position.toString() ;
                    warning = "" ;
                  });
                } catch (error){
                  print(error);
                  if(error.runtimeType == FormatException){
                    
                    setState(() {
                      warning = "please enter valid double ";
                    },);
                  }
                  
                }
              }, 
              child: Text("check distance"),),
          ),
          Text(warning , style: TextStyle(color: Colors.red)),
          Text("distance between your location "),
          Text(" and the entered location is :"),
          Text("${distanceInMeters.toString()}")
        ],
      ),
    );
  }
}