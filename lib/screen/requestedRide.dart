import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'confirmBooking.dart';

class RequestedRide extends StatefulWidget {
  const RequestedRide({Key? key}) : super(key: key);

  @override
  _RequestedRideState createState() => _RequestedRideState();
}

class _RequestedRideState extends State<RequestedRide> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.yellow.shade50,
      appBar: AppBar(
        leading: InkWell(
            child: Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.pushNamedAndRemoveUntil(
                context, '/Home', (route) => false)),
        title: Text("RequestedRide"),
      ),
      body: fetchData(),
    ));
  }
}

final Stream<QuerySnapshot> _usersStream =
    FirebaseFirestore.instance.collection('RequestedRide').snapshots();
StreamBuilder<QuerySnapshot> fetchData() {
  return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              CircularProgressIndicator(),
              Text("Document does not exist"),
            ]),
          );
        }

        return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              String id1 = snapshot.data!.docs[index].id;

              // String name =
              //     snapshot.data!.docs[index].get(['RequestedRide']['Name']);
              // print(name);
              return GestureDetector(
                  child: ExpansionTile(title: Text("${id1}"), children: [
                    Card(
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('RequestedRide')
                              .doc(id1)
                              .collection('booking')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text('Something went wrong'));
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(),
                                      Text("Document does not exist"),
                                    ]),
                              );
                            }

                            return ListView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  String id = snapshot.data!.docs[index].id;
                                  // String id1 = snapshot.data!.docs[index].get({'full_name'});
                                  print(id);
                                  return GestureDetector(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Card(
                                          child: ListTile(
                                            trailing: Icon(Icons
                                                .arrow_forward_ios_rounded),
                                            title: Text(
                                              "$id",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        print(id1);
                                        print(id);
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BookingConfirmation(
                                                      uid: id1,
                                                      Name: id,
                                                    )));
                                      });
                                });
                          }),
                    ),
                  ]),
                  onTap: () {
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => FuturePage(
                    //               id: id,
                    //             )));
                  });
            });
      });
}

// class FuturePage extends StatelessWidget {
//   final String id;
//   FuturePage({
//     Key? key,
//     required this.id,
//   }) : super(key: key);

//   /// Function that will return a
//   /// "string" after some time
//   /// To demonstrate network call
//   /// delay of [2 seconds] is used
//   ///
//   /// This function will behave as an
//   /// asynchronous function

//   Map<String, dynamic>? storedata;
//   var token;

//   final CollectionReference _usersCollectionReference =
//       FirebaseFirestore.instance.collection("RequestedRide");
//   var data;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           leading: InkWell(
//               child: Icon(Icons.arrow_back_ios),
//               onTap: () => Navigator.pushNamedAndRemoveUntil(
//                   context, '/ReqRide', (route) => false)),
//           title: Text("Application Detail"),
//         ),
//         body: StreamBuilder(
//             stream: FirebaseFirestore.instance
//                 .collection('RequestedRide')
//                 .doc(id)
//                 .collection('booking')
//                 .snapshots(),
//             builder:
//                 (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//               if (snapshot.hasError) {
//                 return Center(child: Text('Something went wrong'));
//               }

//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CircularProgressIndicator(),
//                         Text("Document does not exist"),
//                       ]),
//                 );
//               }

//               return ListView.builder(
//                   itemCount: snapshot.data!.docs.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     String id = snapshot.data!.docs[index].id;
//                     // String id1 = snapshot.data!.docs[index].get({'full_name'});
//                     // print(id);
//                     return GestureDetector(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: ExpansionTile(
//                               title: Text("${id}"),
//                               backgroundColor: Colors.white,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(15.0),
//                                   child: Card(
//                                     child: ListTile(
//                                       title: Text(
//                                         "id",
//                                         style: TextStyle(fontSize: 16),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ]),
//                         ),
//                         onTap: () {
//                           Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => FuturePage(
//                                         id: id,
//                                       )));
//                         });
//                   });
//             }),
//       ),
//     );
//   }
// }
