import 'package:brew/models/user.dart';
import 'package:brew/screens/auth/authenticate.dart';
import 'package:brew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    print(user);

    // return either Home or Authenticate widget
    return Authenticate();
  }
}
