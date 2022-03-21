import 'package:brew/models/brew.dart';
import 'package:brew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews'); //? collection reference

  DatabaseService({this.uid = ''});

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      dynamic data = doc.data();

      return Brew(
        name: data['name'] ?? '',
        sugars: data['sugars'] ?? '',
        strength: data['strength'] ?? '',
      );
    }).toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    dynamic data = snapshot.data();

    return UserData(
      uid: uid,
      name: data['name'],
      sugars: data['sugars'],
      strength: data['strength'],
    );
  }

  // get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
