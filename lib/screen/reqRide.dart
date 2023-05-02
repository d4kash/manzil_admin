import 'package:Manzil_admin/helper/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'confirmBooking.dart';

class Req extends StatefulWidget {
  Req({Key? key}) : super(key: key);

  @override
  _ReqState createState() => _ReqState();
}

final Future documentStream = FirebaseFirestore.instance
    .collection('$DBUSER')
    .get()
    .then((QuerySnapshot querySnapshot) {
  querySnapshot.docs.forEach((doc) {
    print(doc["status"]);
  });
});

class _ReqState extends State<Req> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text("waiting ride"),
              leading: InkWell(
                  child: Icon(Icons.arrow_back_ios),
                  onTap: () => Navigator.pushNamedAndRemoveUntil(
                      context, '/Home', (route) => false)),
            ),
            body: fetchData()));
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
          physics: BouncingScrollPhysics(),
          // physics: const BouncingScrollPhysics(
          //     parent: AlwaysScrollableScrollPhysics()),
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            String uid = snapshot.data!.docs[index].id;
            // var sections = data['RequestedRide'];

            // return ListTile(title: Text(data['ride'][index]['status']));
            return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('RequestedRide')
                    .doc(uid)
                    .collection('booking')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Something went wrong'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            Text("Document does not exist"),
                          ]),
                    );
                  }
                  return ListView(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      // print(document.id);

                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        // physics: const BouncingScrollPhysics(
                        //     parent: AlwaysScrollableScrollPhysics()),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          String id = snapshot.data!.docs[index].id;

                          var sections = data['RequestedRide'];
                          // print(sections['vehicleType']);
                          print(id);
                          // if (data['status'] == "waiting") {
                          // return ListTile(title: Text(data['RequestedRide'][index]['status']));
                          // print(sections);
                          return ListTile(
                              title: Card(
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.white)),
                            color: Colors.orangeAccent.shade100,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Vehicle Type:  ${data['vehicleType']}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Customer Name: ${data['Name']}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  // Text(
                                  //   "Phone: ${data['pickup']['phone']}",
                                  //   style: TextStyle(
                                  //       fontWeight: FontWeight.w600,
                                  //       fontSize: 18),
                                  // ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Booking Date: ${data['Date']}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Booking Time: ${data['Time']}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Time Slot: ${data['time_slot']}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  // Text(
                                  //   "PickUp Home: ${data['pickup']['pickup Home']}",
                                  //   style: TextStyle(
                                  //       fontWeight: FontWeight.w600,
                                  //       fontSize: 18),
                                  // ),
                                  // SizedBox(
                                  //   height: 5,
                                  // ),
                                  // Text(
                                  //   "Dest Home: ${data['dest']['Dest Home']}",
                                  //   style: TextStyle(
                                  //       fontWeight: FontWeight.w600,
                                  //       fontSize: 18),
                                  // ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Payment Method: ${data['payment_method']}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Status: ${data['status']}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          shape: StadiumBorder(),
                                          side: BorderSide(
                                              width: 2, color: Colors.red),
                                        ),
                                        onPressed: () {
                                          print(index);
                                        },
                                        child: Text('cancle'),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          shape: StadiumBorder(),
                                          side: BorderSide(
                                              width: 2, color: Colors.red),
                                        ),
                                        onPressed: () {
                                          print("${data['Name']}");
                                          Navigator.pushReplacementNamed(
                                              context, '/ConfirmBook');
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      BookingConfirmation(
                                                        uid: "${data['uid']}",
                                                        Name: "${data['Name']}",
                                                        Date: "${data['Date']}",
                                                        time: "${data['Time']}",
                                                      )));
                                        },
                                        child: Text('confirm booking'),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ));
                          // }
                          // return Container();
                        },
                      );
                    }).toList(),
                  );
                });
          },
        );
        //  }).toList(),
      });
}
