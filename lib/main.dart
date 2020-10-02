import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mgassigment/Animation/slide_side_root.dart';
import 'package:mgassigment/country_details.dart';
import 'package:http/http.dart' as http;
import 'package:mgassigment/models/country_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MGA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'MGA'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List regionList = [
    'Asia',
    'Europe'
  ];
  List<Color>regionColorList = [
    Colors.blue,
    Colors.deepPurple,
  ];
  Color countryColor;
  bool countryVisibility=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(alignment:Alignment.centerLeft,child: Text("Select a region",style:TextStyle(fontSize: 17,fontWeight: FontWeight.w500),textAlign: TextAlign.start,)),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                // Let the ListView know how many items it needs to build.
                itemCount: regionList.length,
                shrinkWrap: true,
                // Provide a builder function. This is where the magic happens.
                // Convert each item into a widget based on the type of item it is.
                itemBuilder: (context, index) {
                  return regionListItem(index);
                },
              ),
              Visibility(
                visible: countryVisibility,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(alignment:Alignment.centerLeft,child: Text("Select a country",style:TextStyle(fontSize: 17,fontWeight: FontWeight.w500),textAlign: TextAlign.start,)),
                ),
              ),
              Visibility(
                visible: countryVisibility,
                child: listModel.isNotEmpty? ListView.builder(
                  // Let the ListView know how many items it needs to build.
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listModel.length,
                  shrinkWrap: true,
                  // Provide a builder function. This is where the magic happens.
                  // Convert each item into a widget based on the type of item it is.
                  itemBuilder: (context, index) {
                    return countryItem(index);
                  },
                ):CircularProgressIndicator(),
              )
            ],
          ),
        ),
      ));
  }

  Widget regionListItem(index) {
    return Container(
      margin: EdgeInsets.only(top: 5,bottom: 5),
      decoration: BoxDecoration(
          color: regionColorList[index],
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: RaisedButton(
        color: regionColorList[index],
        onPressed: () {
          getData(regionList[index].toString().toLowerCase());
          countryColor=regionColorList[index].withOpacity(0.5);
          countryVisibility=true;
        },
        textColor: Colors.white,
        padding: const EdgeInsets.all(0.0),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Text(regionList[index].toString(),
              style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }

  Widget countryItem(index) {
     return GestureDetector(
       onTap: () {
         Navigator.push(
           context,
           SlideRightRoute(
             page: CountryDetails(index,listModel)));
       },
       child: Container(
         alignment: Alignment.centerLeft,
         margin: EdgeInsets.only(top: 5,bottom: 5),
         padding: EdgeInsets.only(left: 20,right: 20),
         decoration: BoxDecoration(
           color: countryColor,
           borderRadius: BorderRadius.all(Radius.circular(5))),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
                Container(
                 padding: const EdgeInsets.all(10.0),
                 child: Text(listModel[index].name, style: TextStyle(fontSize: 20,color: Colors.white)),
               ),
             SvgPicture.network(
               listModel[index].flag,
               height: 30,
               width: 30,
             )          ],
         ),
       ),
     );
  }

  // Membuat List Dari data Internet
  List<CountryModel> listModel = [];
  var loading = false;

  Future<Null> getData(region) async {
    setState(() {
      loading = true;
    });

    final responseData =
        await http.get("https://restcountries.eu/rest/v2/region/" + region);
    if (responseData.statusCode == 200) {
      final data = jsonDecode(responseData.body);
      print(data);
      setState(() {
        if(listModel.isNotEmpty){listModel.clear();}
        for (Map i in data) {
          listModel.add(CountryModel.fromJson(i));
        }
        loading = false;
      });
    }
  }
}
