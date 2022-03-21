import 'package:brew/util/loading.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';
import '../../util/constants.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field states
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0,
              title: Text('Sign in to Brew'),
              actions: [
                TextButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: Icon(Icons.person),
                  label: Text('Register'),
                  style: TextButton.styleFrom(primary: Colors.black),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 50.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20.0),
                    Text(
                      error,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(height: 12.0),
                    TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an email' : null,
                      decoration: textInputDecoration.copyWith(
                        hintText: 'Enter your email address',
                        label: Text(
                          'Email address',
                          style: TextStyle(color: Colors.pink),
                        ),
                      ),
                      onChanged: (val) => {setState(() => email = val)},
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      validator: (val) => val!.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      decoration: textInputDecoration.copyWith(
                        hintText: 'Enter your password',
                        label: Text(
                          'Password',
                          style: TextStyle(color: Colors.pink),
                        ),
                      ),
                      obscureText: true,
                      onChanged: (val) => {setState(() => password = val)},
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => loading = true);
                          dynamic result =
                              await _auth.signInWithEmailAndPassword(
                                  email.trim(), password);
                          if (result == null) {
                            setState(() {
                              error = 'Invalid credentials supplied!';
                              loading = false;
                            });
                          }
                        }
                      },
                      child: Text('Sign in'),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
