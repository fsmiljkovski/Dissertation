import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class DissPrototypeFirebaseUser {
  DissPrototypeFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

DissPrototypeFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<DissPrototypeFirebaseUser> dissPrototypeFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<DissPrototypeFirebaseUser>(
            (user) => currentUser = DissPrototypeFirebaseUser(user));
