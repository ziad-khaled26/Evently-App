import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static Future<UserCredential> register(String email, String password) async {
    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return credential;
  }

  static Future<UserCredential> login(String email, String password) async {
    var userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential;
  }

  static CollectionReference<UserModel> get getUsersCollection{
    FirebaseFirestore db = FirebaseFirestore.instance;
   return db
        .collection("Users")
        .withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.formJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson());
  }

  static Future<void> addUserToFirestore(UserModel user) {
    CollectionReference<UserModel> usersCollection=getUsersCollection;
    DocumentReference<UserModel> userModel = usersCollection.doc(user.id);
    return userModel.set(user);
  }

  static Future<UserModel> getUserFromFirestore(String userId) async {


    DocumentReference<UserModel> userDocument = getUsersCollection.doc(userId);
    DocumentSnapshot<UserModel> documentSnapshot = await userDocument.get();
    UserModel user = documentSnapshot.data()!;
    return user;
  }

}
