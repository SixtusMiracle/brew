import 'package:flutter/material.dart';

import '../../services/auth.dart';
import '../../util/constants.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  const Register({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field states
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0,
        title: Text('Sign up to Brew'),
        actions: [
          TextButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: Icon(Icons.person),
            label: Text('Sign in'),
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
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
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
                validator: (val) =>
                    val!.length < 6 ? 'Enter a password 6+ chars long' : null,
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
                    dynamic result = await _auth.registerWithEmailAndPassword(
                        email.trim(), password);
                    if (result == null) {
                      setState(() => error = 'please supply a valid email');
                    }
                  }
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
