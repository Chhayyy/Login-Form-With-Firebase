import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/auth_gate.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  FormPageState createState() => FormPageState();
}

class FormPageState extends State<FormPage> {
  String? email, password;

  bool isLogin = true;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        e.message;
      });
    }
  }

  Widget _entryField(String title, TextEditingController controller) {
    return TextFormField(
        controller: controller,
        decoration: InputDecoration(
            labelText: title,
            enabledBorder: myinputborder(),
            focusedBorder: myfocusborder()),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter something';
          }
          return null;
        },
        obscureText: true,
        onSaved: (value) => email = value);
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AssetImage logoAsset = const AssetImage('assets/logo.png');
    Image image = Image(image: logoAsset, width: 200, height: 200);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: image,
        ),
        Builder(
          builder: (context) => Form(
            key: _formkey,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: _entryField('Email', _controllerEmail),
                ),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                    child: _entryField('Password', _controllerPassword)),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16.0),
                  alignment: Alignment.center,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      child: Text(
                        isLogin ? 'Login' : 'Rigister',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 81, 81, 81),
                        ),
                      ),
                      onPressed: () {
                        _formkey.currentState!.save();

                        isLogin
                            ? signInWithEmailAndPassword
                            : createUserWithEmailAndPassword;
                      }),
                ),
                // Container(
                //   alignment: Alignment.center,
                //   child: const Text(
                //     "or",
                //     style: TextStyle(fontSize: 16),
                //   ),
                // ),
                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                //   child: OutlinedButton(
                //       style: OutlinedButton.styleFrom(
                //         minimumSize: const Size.fromHeight(50),
                //         backgroundColor: Colors.white,
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(18.0),
                //         ),
                //       ),
                //       child: const Text(
                //         "Sign in with Facebook",
                //         style: TextStyle(
                //           fontSize: 16,
                //           fontWeight: FontWeight.w600,
                //           color: Color.fromARGB(255, 81, 81, 81),
                //         ),
                //       ),
                //       onPressed: () {}),
                // )
              ],
            ),
          ),
        )
      ],
    );
  }

  OutlineInputBorder myinputborder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide:
          BorderSide(color: Color.fromARGB(255, 255, 125, 116), width: 1.5),
    );
  }

  OutlineInputBorder myfocusborder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide:
            BorderSide(color: Color.fromARGB(255, 70, 172, 255), width: 3));
  }
}
