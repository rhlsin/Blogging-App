import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class ItemTwo extends StatefulWidget {
  @override
  _ItemTwoState createState() => _ItemTwoState();
}

class _ItemTwoState extends State<ItemTwo> 
{
  Future getHomePost()async
  {
    var firestore = Firestore.instance;
    QuerySnapshot snap = await firestore.collection("HomeData").getDocuments();
    return snap.documents;
  }

  Future<Null>getRefresh()async
  {
    await Future.delayed(Duration(seconds: 3));
    setState(() 
    {
      getHomePost();
    });
  }

  // material color
  List <MaterialColor>_colorItem = 
  [
    Colors.yellow,
    Colors.deepOrange,
    Colors.indigo,
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.pink,
    Colors.cyan,
    Colors.deepPurple,
  ];
  MaterialColor color;



  @override
  Widget build(BuildContext context) 
  {
    return new Scaffold
    (
      backgroundColor: Colors.grey,
      body: FutureBuilder
      (
        future: getHomePost(),
        builder: (context, snapshot)
        {
          if (snapshot.connectionState==ConnectionState.waiting)
          {
            return Center
            (
              child: CircularProgressIndicator(),
            );
          }
            else
            {
              return RefreshIndicator
              (
                 onRefresh: getRefresh,
                 child: ListView.builder
                 (
                   itemCount: snapshot.data.length,
                   itemBuilder: (context, index)
                   {
                     
                     var ourData = snapshot.data[index];

                     color= _colorItem[index % _colorItem.length];

                     return Container
                     (
                       height: 420.0,
                       margin: EdgeInsets.all(5.0),
                       child: Card
                       (
                         shape: RoundedRectangleBorder
                         (
                           borderRadius: BorderRadius.circular(20.0)
                         ),
                         elevation: 10.0,
                         child: Column
                         (
                           children: <Widget>
                           [
                             //first container
                             Container
                             (
                               child: Row
                               (
                                
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                 children: <Widget>
                                 [

                                   Container
                                   (
                                     child: Row
                                     (
                                       children: <Widget>
                                       [
                                          // 1 Circle Avtar
                                          Container
                                          (
                                            margin: EdgeInsets.all(10.0),
                                            child: CircleAvatar
                                            (
                                              child: Text(ourData.data["title"][0], style: TextStyle(color: Colors.white ,fontSize: 20.0, fontWeight: FontWeight.bold),),
                                              backgroundColor: color,
                                              
                                            ),
                                          ),

                                          SizedBox(width: 5.0,),

                                          // 2. Title of post 
                                          Container
                                          (
                                            child: Text(ourData.data['title'],
                                            style: TextStyle 
                                            (
                                              fontSize: 20.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold

                                            ),

                                            ),
                                            
                                          )

                                        ],

                                      ),
                                      
                                    ),

                                   // 3. More read
                                   Container
                                   ( margin: EdgeInsets.only(right: 10.0),
                                     child: Icon(Icons.more_horiz, size: 30.0,),
                                   ),

                                 ],
                               ),
                             ),

                             SizedBox(height: 10.0,),
                            
                            //Image container
                             Container
                             (
                               margin: EdgeInsets.all(10.0),
                               child: ClipRRect
                               (
                                 borderRadius: BorderRadius.circular(15.0),
                                 child: Image.network(ourData.data['image'],
                                 height: 200.0,
                                 width: MediaQuery.of(context).size.width,
                                 fit: BoxFit.cover,
                                 ),
                               ),
                             ),

                             SizedBox(height: 8.0,),

                             // Description of post 
                             Container
                             (
                               margin: EdgeInsets.all(10.0),
                               child: Text(ourData.data['des'],
                               maxLines: 4,
                               style: TextStyle
                               (
                                 fontSize: 17.0,
                                 color: Colors.black,
                               ),

                               ),
                               
                             )

                           ],
                         ),
                       ),
                     );
                   },
                 ),
              );
            }
          
        },

      ),
    );
  }
}