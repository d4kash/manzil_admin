import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Manzil_admin/helper/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingConfirmation extends StatefulWidget {
  const BookingConfirmation(
      {Key? key, this.uid, this.Name, this.Date, this.time})
      : super(key: key);
  final uid;
  final Name;
  final Date;
  final time;
  @override
  _BookingConfirmationState createState() => _BookingConfirmationState();
}

final Stream<QuerySnapshot> _usersStream =
    FirebaseFirestore.instance.collection('user').snapshots();
CollectionReference users =
    FirebaseFirestore.instance.collection('RequestedRide');
CollectionReference user = FirebaseFirestore.instance.collection('user');
CollectionReference confirmUser =
    FirebaseFirestore.instance.collection('confirmedBooking');

class _BookingConfirmationState extends State<BookingConfirmation> {
  @override
  Widget build(BuildContext context) {
    print(widget.uid);
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text("User Booking Details"),
              leading: InkWell(
                  child: Icon(Icons.arrow_back_ios),
                  onTap: () => Navigator.pushNamedAndRemoveUntil(
                      context, '/ReqRide', (route) => false)),
            ),
            body: fetchData()));
  }

  FutureBuilder<DocumentSnapshot> fetchData() {
    return FutureBuilder<DocumentSnapshot>(
      future: users
          .doc("${widget.uid}")
          .collection("booking")
          .doc("${widget.Name}")
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          print("${widget.Name}${widget.Date}${widget.time}");
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          if (data != null) {
            return Card(
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
                      "Vehicle Type:  ${data['RequestedRide']['vehicleType']}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Customer Name: ${data['RequestedRide']['Name']}",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Phone: ${data['RequestedRide']['phone']}",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Booking Date: ${data['RequestedRide']['Date']}",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Booking Time: ${data['RequestedRide']['Time']}",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      " Time Slot: ${data['RequestedRide']['time_slot']}",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    Divider(
                      height: 10,
                      color: Colors.redAccent,
                      thickness: 1,
                    ),
                    Text(
                      "PickUp Home: ${data['RequestedRide']['pickup Home']}",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "PickUp Landmark: ${data['RequestedRide']['pickup Landmark']}",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "PickUp District: ${data['RequestedRide']['pickup District']}",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "PickUp Pincode: ${data['RequestedRide']['pickup Pincode']}",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      height: 10,
                      color: Colors.redAccent,
                      thickness: 1,
                    ),
                    Text(
                      "Dest Home: ${data['RequestedRide']['Dest Home']}",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Dest Landmark: ${data['RequestedRide']['Dest Landmark']}",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Dest District: ${data['RequestedRide']['Dest District']}",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Dest Pincode: ${data['RequestedRide']['Dest Pincode']}",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      height: 10,
                      color: Colors.redAccent,
                      thickness: 1,
                    ),
                    Text(
                      "Payment Method: ${data['RequestedRide']['payment_method']}",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Status: ${data['RequestedRide']['status']}",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
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
                            print("index");
                            CancelBooking(
                              context,
                              widget.uid,
                              widget.Name,
                            );
                          },
                          child: Text(
                            'cancel',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                        // OutlinedButton(
                        //   style: OutlinedButton.styleFrom(
                        //     shape: StadiumBorder(),
                        //     side: BorderSide(width: 2, color: Colors.red),
                        //   ),
                        //   onPressed: () {
                        //     print("index");
                        //     // launch('sms:917488406520?body=hii');
                        //   },
                        //   child: Text('send sms'),
                        // ),
                        SizedBox(
                          width: 30,
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: StadiumBorder(),
                            side: BorderSide(width: 2, color: Colors.red),
                          ),
                          onPressed: () {
                            updateBooking(
                              context,
                              widget.uid,
                              widget.Name,
                            );

                            // saveTofirestoreList(
                            //   context,
                            //   widget.uid,
                            //   widget.Name,
                            // );
                            Future.delayed(Duration(milliseconds: 400));
                            Navigator.pushReplacementNamed(
                                context, '/ConfirmBook');
                          },
                          child: Text(
                            'confirm booking',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          } else {
            return Text("no booking available");
          }
        }

        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("loading"), CircularProgressIndicator()],
        ));
      },
    );
  }
}

//! create new collection om confirm

void updateBooking(context, String uid, String name) async {
  await users
      .doc(uid)
      .collection("booking")
      .doc("${name}")
      .update({'RequestedRide.status': 'Booked'});
  print("booked");
}

void CancelBooking(context, String uid, String name) async {
  await users
      .doc(uid)
      .collection("booking")
      .doc("${name}")
      .update({'RequestedRide.status': 'Cancelled'});
  print("booked");
}

void saveTofirestoreList(context, String uid, String name, var data) async {
  // SharedPreferences _pref = await SharedPreferences.getInstance();

  user
    ..doc(uid).set({
      'ride': FieldValue.arrayUnion([
        {
          'dest': {
            'Dest Home': '${data['RequestedRide']['dest']['Dest Home']}',
            'Dest Landmark':
                '${data['RequestedRide']['dest']['Dest Landmark']}',
            'Dest District':
                '${data['RequestedRide']['dest']['Dest District']}',
            'Dest Pincode': '${data['RequestedRide']['dest']['Dest Pincode']}}',
          },
          'pickup': {
            'pickup Home': '${data['RequestedRide']['pickup']['pickup Home']}',
            'pickup Landmark':
                '${data['RequestedRide']['pickup']['pickup Landmark']}',
            'pickup District':
                '${data['RequestedRide']['pickup']['pickup District']}',
            'pickup Pincode':
                '${data['RequestedRide']['pickup']['pickup Pincode']}',
            'phone': '${data['RequestedRide']['pickup']['phone']}',
          },
          'Name': '${data['RequestedRide']['Name']}',
          'time_slot': '${data['RequestedRide']['time_slot']}',
          'payment_method': 'COD',
          'vehicleType': '${data['RequestedRide']['vehicleType']}',
          'status': 'Booked',
          'uid': '$uid',
          // "Date": date,
          // "Time": time,
        }
      ])
    }, SetOptions(merge: true));
} //requested ride db


