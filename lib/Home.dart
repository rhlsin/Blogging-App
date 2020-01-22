import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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

      //Drawer
      drawer: Drawer
      (
        child: ListView
        (
          children: <Widget>
          [
            UserAccountsDrawerHeader
            (
              accountEmail: null,
              accountName: Text('Blogging App',
              style: TextStyle
              (
                fontSize: 20.0
              ),
              ),

              decoration: BoxDecoration
              (
                color: Colors.deepOrange,
              ),
            ),

            ListTile
            (
              onTap: ()
              {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(builder: (c)=>ItemOne()));
              },
              title: Text('First',
              style: TextStyle
              (
                fontSize: 17.0,
                color: Colors.black,
              ),
              ),
              leading: Icon(Icons.list, color: Colors.black,),
            ),

            ListTile
            (
              onTap: ()
              {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(builder: (c)=>Home()));
              },
              title: Text('Home',
               style: TextStyle
              (
                fontSize: 17.0,
                color: Colors.black,
              ),
              ),
              leading: Icon(Icons.home, color: Colors.black,),
            ),

            ListTile
            (
              onTap: ()
              {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(builder: (c)=>ItemThree()));
              },
              title: Text('Third',
               style: TextStyle
              (
                fontSize: 17.0,
                color: Colors.black,
              ),
              ),
              leading: Icon(Icons.photo_size_select_actual, color: Colors.black,),
            ),

          ],
        ),
      ),


      body: pageOptions[_indexpage],

      bottomNavigationBar: CurvedNavigationBar
      (
        height: 55.0,
        color: Colors.deepOrange,
        buttonBackgroundColor: Colors.black,
        //backgroundColor: Colors.transparent,
        backgroundColor: Colors.white,
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