import 'package:flutter/material.dart';

import '../../../util/constants.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values
  String _currentName = '';
  String _currentSugars = '';
  int _currentStrength = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            'Update your Coffee Preferences',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            validator: (val) => val!.isEmpty ? 'Please enter your name' : null,
            decoration: textInputDecoration.copyWith(
              label: Text(
                'Name',
                style: TextStyle(color: Colors.pink),
              ),
              hintText: 'Enter your name',
            ),
            onChanged: (val) => {setState(() => _currentName = val)},
          ),
          SizedBox(height: 20.0),
          DropdownButtonFormField(
            decoration: textInputDecoration.copyWith(
              label: Text(
                'Sugars',
                style: TextStyle(color: Colors.pink),
              ),
              hintText: 'Choose...',
            ),
            items: sugars.map((sugar) {
              return DropdownMenuItem(
                value: sugar,
                child: Text(
                  '$sugar sugars',
                ),
              );
            }).toList(),
            onChanged: (val) => setState(() => _currentSugars = val as String),
          ),
          SizedBox(height: 20.0),
          Slider(
            label: 'Coffee Strength',
            value: (_currentStrength == 0 ? 100 : _currentStrength).toDouble(),
            activeColor:
                Colors.brown[_currentStrength == 0 ? 100 : _currentStrength],
            inactiveColor: Colors.brown,
            min: 100.0,
            max: 900.0,
            divisions: 8,
            onChanged: (val) => setState(() => _currentStrength = val.round()),
          ),
          ElevatedButton(
            onPressed: () async =>
                print({_currentName, _currentSugars, _currentStrength}),
            child: Text(
              'Update',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
