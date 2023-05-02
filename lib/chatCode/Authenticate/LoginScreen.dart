import 'package:Manzil_admin/Network/connectivity_provider.dart';
import 'package:Manzil_admin/screen/HomePage.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:Manzil_admin/Network/connectivity_provider.dart';
import 'package:Manzil_admin/Network/no_internet.dart';
import 'package:Manzil_admin/chatCode/Screens/ChatScreen.dart';
// import 'package:Manzil_admin/screens/vehicles/vehicleSelection.dart';

import 'CreateAccount.dart';
import 'Methods.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  GlobalKey<ScaffoldState>? scaffoldSate = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // body:
      body: Consumer<ConnectivityProvider>(
          builder: (consumerContext, model, child) {
        // print(context.watch<ConnectivityProvider>());

        if (model.isOnline != null) {
          return model.isOnline
              ? isLoading
                  ? Center(
                      child: Container(
                        height: size.height / 20,
                        width: size.height / 20,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : showWidget(size, context)
              : NoInternet();
        }
        ;
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }),
    );
  }

  SingleChildScrollView showWidget(Size size, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: size.height / 20,
          ),
          Container(
            alignment: Alignment.centerLeft,
            width: size.width / 0.5,
            child:
                IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {}),
          ),
          SizedBox(
            height: size.height / 50,
          ),
          Container(
            width: size.width / 1.1,
            child: Text(
              "Identify yourself!",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: size.width / 1.1,
            child: Text(
              "To get entry in your house!",
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: size.height / 10,
          ),
          Container(
            width: size.width,
            alignment: Alignment.center,
            child: field(size, "email", Icons.account_box, _email),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: Container(
              width: size.width,
              alignment: Alignment.center,
              child: field(size, "password", Icons.lock, _password),
            ),
          ),
          SizedBox(
            height: size.height / 10,
          ),
          customButton(size),
          SizedBox(
            height: size.height / 40,
          ),
          GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => CreateAccount())),
            child: Container(
                height: size.height / 14,
                width: size.width / 1.2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white38),
                alignment: Alignment.center,
                child: Text(
                  "SIGNUP",
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () {
        if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
          setState(() {
            isLoading = true;
          });

          logInAdmin(_email.text, _password.text).then((user) {
            if (user != null) {
              print("Login Sucessfull");
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("welcome to your house!"),
              ));
              setState(() {
                isLoading = false;
              });
              // Navigator.pushReplacement(
              //     context, MaterialPageRoute(builder: (_) => MyHomePage()));
              Navigator.pushNamedAndRemoveUntil(
                  context, '/Home', (route) => false);
            } else {
              print("Login Failed");
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("you are not identified by our member!"),
              ));
              setState(() {
                isLoading = false;
              });
            }
          });
        } else {
          print("Please fill form correctly");
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Please Fill all feilds correctly!"),
          ));
        }
      },
      child: Container(
          height: size.height / 14,
          width: size.width / 1.2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.deepOrange),
          alignment: Alignment.center,
          child: Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }

  Widget field(
      Size size, String hintText, IconData icon, TextEditingController cont) {
    return Container(
      height: size.height / 14,
      width: size.width / 1.1,
      child: TextField(
        controller: cont,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
