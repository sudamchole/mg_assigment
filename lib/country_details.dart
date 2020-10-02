import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mgassigment/models/country_model.dart';

class CountryDetails extends StatefulWidget {
  int index;
  List<CountryModel> listModel;

  CountryDetails(this.index, this.listModel);

  @override
  _CountryDetailsState createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Country Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Row(
                children: <Widget>[
                  Text(widget.listModel[widget.index].region + " / ",style: TextStyle(fontWeight: FontWeight.w600),),
                  Text(
                    widget.listModel[widget.index].name,
                    style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Row(
                children: <Widget>[
                  SvgPicture.network(
                    widget.listModel[widget.index].flag,
                    height: 35,
                    width: 30,
                  ),
                  SizedBox(
                    width: 32,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.listModel[widget.index].name +
                            "(${widget.listModel[widget.index].cioc})",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600,fontSize: 17),
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.listModel[widget.index].capital,
                            textAlign: TextAlign.start,
                            softWrap: true,
                            style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600),
                          )),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width/2-30,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text(
                      "Demonym" + "\n" + widget.listModel[widget.index].demonym,
                    ),
                  ),
                  SizedBox(width: 16),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width/2-30,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text(
                      "Calling Code" +
                          "\n" +
                          widget.listModel[widget.index].callingCodes[0],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width / 2-30,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text(
                      "Currency" +
                          "\n" +
                          widget.listModel[widget.index].currencies[0].symbol+" "+widget.listModel[widget.index].currencies[0].name,
                    ),
                  ),
                  SizedBox(width: 16),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width / 2-30,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text(
                      "Population" +
                          "\n" +
                          widget.listModel[widget.index].population.toString(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
