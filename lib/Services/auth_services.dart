import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthServices {
  //Firebase Authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //function to handle user signup
  Future<String?> signup({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      //create user in firebase authentication with email and password
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );

      User? user = userCredential.user;

      //save additional user data in firestore (name, role, email)
      await _firestore.collection("users").doc(user?.uid).set({
        "name": name.trim(),
        "email": email.trim(),
        "role": role, //role determines if user is a admin or user
      });
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  //function to handle user login
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      //sign in user with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      //fetching the user's role from firestore to determine access level
      DocumentSnapshot userDoc =
          await _firestore
              .collection("users")
              .doc(userCredential.user!.uid)
              .get();
      return userDoc["role"];
    } catch (e) {
      return e.toString();
    }
  }

  //function to handle user logout
  logOut() async {
    _auth.signOut();
  }
}
