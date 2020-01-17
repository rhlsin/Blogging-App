import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemOne extends StatefulWidget {
  @override
  _ItemOneState createState() => _ItemOneState();
}

class _ItemOneState extends State<ItemOne> 
{
  Future getPost()async
  {
    var firestore = Firestore.instance;
    QuerySnapshot snap = await firestore.collection("itemone").getDocuments();
    return snap.documents;
  }

  Future<Null>getRefresh()async
  {
    await Future.delayed(Duration(seconds: 3));
    setState(() 
    {
      getPost();
    });
  }

  // material color
  List <MaterialColor>colorItem = 
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
    return Scaffold
    (
      body: FutureBuilder
      (
        future: getPost(),
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
                itemBuilder: (context,index)
                {

                  var ourData = snapshot.data[index];

                  color = colorItem[index % colorItem.length]; 

                  return Container
                  (
                    height: 180.0,
                       margin: EdgeInsets.all(5.0),
                       child: Card
                       (
                         shape: RoundedRectangleBorder
                         (
                           borderRadius: BorderRadius.circular(20.0)
                         ),
                         elevation: 10.0,
                         child: Row
                         (
                           children: <Widget>
                           [
                             // image
                             Expanded
                             (
                               flex: 1,
                               child: ClipRRect
                               (

                                 borderRadius: BorderRadius.circular(20.0),
                                 child: Image.network(ourData.data['img'],
                                 height: 180.0,
                                 fit: BoxFit.cover,

                                 ),
                               ),
                             ),

                            SizedBox(width: 5.0),

                            // Title
                            Expanded
                             (
                               flex: 2,
                               child: Column
                               (
                                 crossAxisAlignment:  CrossAxisAlignment.start,
                                 children: <Widget>
                                 [
                                   Container
                                   (
                                     child: Text(ourData.data['title'],
                                     maxLines: 1,
                                     style: TextStyle
                                     (
                                       fontSize: 20.0,
                                       color: Colors.black,
                                       fontWeight: FontWeight.bold,
                                     ),

                                     ),
                                     
                                   ),

                                   SizedBox(height: 5.0,),

                                   // description 
                                   Container
                                   (
                                     child: Text(ourData.data['des'],
                                     maxLines: 5,
                                     style: TextStyle
                                     (
                                       fontSize: 17.0,
                                       color: Colors.black,
                                     ),
                                     ),
                                   ),

                                   // Button <More>
                                   Align
                                   (
                                    alignment: Alignment.bottomRight,
                                    child: Container
                                    (
                                      height: 30.0,
                                      margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                                      padding: EdgeInsets.all(5.0),
                                      decoration: BoxDecoration
                                      (
                                        color: color,
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      // Text of button
                                      child: Text('More',
                                      style: TextStyle
                                      (
                                        fontSize: 14.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                      ),
                                      ),
                                    ),
                                   ),

                                 ],
                               ),
                             ),

                           ],
                         ),
                       ),
                  );
                },
              ),
            );
          }
        }
      )
    );
    
  }
}