import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_coffee_app/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on FirebaseUser

  Userr? _fromFirebaseUser(User? user) {
    return user != null ? Userr(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<Userr?> get user {
    return _auth
        .authStateChanges()
        //.map((User? user) => _fromFirebaseUser(user));
        .map(_fromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _fromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sing in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _fromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _fromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
