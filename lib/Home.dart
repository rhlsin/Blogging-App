import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blogging_app/Pages/ItemOne.dart';
import 'package:blogging_app/Pages/ItemTwo.dart';
import 'package:blogging_app/Pages/ItemThree.dart';



class  Home extends StatefulWidget 
{
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> 
{

  int _indexpage=1;

  final pageOptions = 
  [
    ItemOne(),
    ItemTwo(),
    ItemThree()
  ];


  @override
  Widget build(BuildContext context) 
  {
    return new Scaffold
    (
      appBar: AppBar
      (
        title: Text("Blogging App"),
        backgroundColor: Colors.deepOrange,
      ),


      body: pageOptions[_indexpage],

      bottomNavigationBar: CurvedNavigationBar
      (

        color: Colors.deepOrange,
        buttonBackgroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 400),
        index: 1,


        items: <Widget>
        [
          Icon(Icons.poll, size: 30.0, color: Colors.white,),
          Icon(Icons.home, size: 30.0, color: Colors.white,),
          Icon(Icons.library_books, size: 30.0, color: Colors.white,)
        ],

        onTap: (int index)
        {
          setState(() 
          {
            _indexpage=index;
          });
        },
      ),

      
    );
  }
}