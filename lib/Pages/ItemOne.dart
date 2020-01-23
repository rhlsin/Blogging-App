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

    // custom Dialog
    customDialog(BuildContext context, String img, String title, String des)
    {
      return showDialog
      (
        context: context,
        builder: (BuildContext context)
        {
          return Dialog
          (
            shape: RoundedRectangleBorder
            (
              borderRadius: BorderRadius.circular(20.0)
            ),
            child: Container
            (
              height: MediaQuery.of(context).size.height/1.3,
              width: MediaQuery.of(context).size.width,

              decoration: BoxDecoration
              (
                borderRadius: BorderRadius.circular(20.0),
                gradient: LinearGradient
                (
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: 
                  [
                    //Colors.pinkAccent,
                    Colors.blueAccent,
                    Colors.purpleAccent,
                  ]
                )
              ),

              //Adding image in the dialog
              child: SingleChildScrollView
              (
                child: Column
                (
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>
                  [
                    Container
                    (
                      height: 150.0,
                      child: ClipRRect
                      (
                        borderRadius : BorderRadius.circular(20.0),
                        child: Image.network
                        (
                          img,
                          height: 150.0,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                        
                      ),
                    ),

                    SizedBox(height: 6.0,),

                    
                    // dialog title
                    Container
                    (
                      padding: EdgeInsets.all(10.0),
                      child: Text
                      (
                        title.toUpperCase(),
                        style: TextStyle
                        (
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    SizedBox(height: 6.0,),

                    // dialog description
                    Container
                    (
                      padding: EdgeInsets.all(10.0),
                      child: Text
                      (
                        des,
                        style: TextStyle
                        (
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    )

                  ],
                ),
              ),

            ),
          );
        }
      );
    }
    //

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
                                 height: 150.0,
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
                                    child: InkWell
                                    (
                                      onTap: ()
                                      {
                                        customDialog
                                        (
                                          context,
                                          ourData.data['img'],
                                          ourData.data['title'],
                                          ourData.data['des'],
                                        );
                                      },
                                      
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