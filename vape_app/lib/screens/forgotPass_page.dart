import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key});

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  TextEditingController Email = TextEditingController();

  @override
  void dispose() {
    Email.dispose();
    super.dispose();
  }

  Future passwourdReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: Email.text);
      showDialog(
          context: context,
          builder: ((context) {
            return AlertDialog(
              content: Text("Password reset link sent? check your email"),
            );
          }));
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: ((context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 172, 205, 224),
        elevation: 0,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          "Enter your email to send you a password reset link ",
          style: TextStyle(fontSize: 25, fontFamily: "Raleway"),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 15,
        ),
        TextField(
          controller: Email,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            label: Text(
              "Email :",
              style: TextStyle(
                color: Color.fromARGB(255, 245, 239, 244),
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            prefixIcon: Icon(Icons.email),
            hintText: " enter your email",
            prefixIconColor: Color.fromARGB(255, 164, 6, 179),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 30, color: Color.fromARGB(255, 164, 6, 179)),
                borderRadius: BorderRadius.all(Radius.circular(30)),
                gapPadding: 20),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        MaterialButton(
          onPressed: passwourdReset,
          child: Text("Reset password"),
          color: Color.fromARGB(255, 172, 205, 224),
        )
      ]),
    );
  }
}
