import 'package:Manzil_admin/helper/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'confirmBooking.dart';

class WaitingUser extends StatefulWidget {
  WaitingUser({Key? key}) : super(key: key);

  @override
  _WaitingUserState createState() => _WaitingUserState();
}

final Future documentStream = FirebaseFirestore.instance
    .collection('$DBUSER')
    .get()
    .then((QuerySnapshot querySnapshot) {
  querySnapshot.docs.forEach((doc) {
    print(doc["status"]);
  });
});

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final Stream<QuerySnapshot> _usersStream =
    FirebaseFirestore.instance.collection('user').snapshots();

class _WaitingUserState extends State<WaitingUser> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text("Waiting User"),
              leading: InkWell(
                  child: Icon(Icons.arrow_back_ios),
                  onTap: () => Navigator.pushNamedAndRemoveUntil(
                      context, '/Home', (route) => false)),
            ),
            body: fetchData()));
  }
}

StreamBuilder<QuerySnapshot<Object?>> fetchData() {
  return StreamBuilder<QuerySnapshot>(
    stream: _usersStream,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return Center(child: Text('Something went wrong'));
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: Column(children: [
            CircularProgressIndicator(),
            Text("Document does not exist"),
          ]),
        );
      }
      if (snapshot.data!.docs.isNotEmpty) {
        return ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            // print(document.id);

            return ListView.builder(
              physics: BouncingScrollPhysics(),
              // physics: const BouncingScrollPhysics(
              //     parent: AlwaysScrollableScrollPhysics()),
              shrinkWrap: true,
              itemCount: data['ride'].length,
              itemBuilder: (BuildContext context, int index) {
                var sections = data['ride'];
                print(sections);
                if (data['ride'][index]['status'] == "waiting") {
                  // return ListTile(title: Text(data['ride'][index]['status']));
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
                            "Vehicle Type:  ${sections[index]['vehicleType']}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Customer Name: ${sections[index]['Name']}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Phone: ${sections[index]['pickup']['phone']}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Booking Date: ${sections[index]['Date']}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Booking Time: ${sections[index]['Time']}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Time Slot: ${sections[index]['time_slot']}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "PickUp Home: ${sections[index]['pickup']['pickup Home']}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Dest Home: ${sections[index]['dest']['Dest Home']}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Payment Method: ${sections[index]['payment_method']}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Status: ${sections[index]['status']}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  shape: StadiumBorder(),
                                  side: BorderSide(width: 2, color: Colors.red),
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
                                  side: BorderSide(width: 2, color: Colors.red),
                                ),
                                onPressed: () {
                                  print("${sections[index]['Name']}");
                                  // Navigator.pushReplacementNamed(
                                  //     context, '/ConfirmBook');
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => BookingConfirmation(
                                                uid:
                                                    "${sections[index]['uid']}",
                                                Name:
                                                    "${sections[index]['Name']}",
                                                Date:
                                                    "${sections[index]['Date']}",
                                                time:
                                                    "${sections[index]['Time']}",
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
                }
                return Container();
              },
            );
          }).toList(),
        );
      } else
        return Text("huuh\nwhat are u doing man, \n why no booking available!");
    },
  );
}
