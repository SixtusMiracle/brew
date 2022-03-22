import 'package:brew/models/brew.dart';
import 'package:brew/util/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'brew_tile.dart';

class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>?>(context);

    return brews == null
        ? Loading()
        : ListView.builder(
            itemCount: brews.length,
            itemBuilder: (BuildContext context, int index) {
              return BrewTile(brew: brews[index]);
            },
          );
  }
}
