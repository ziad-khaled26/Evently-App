import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/models/category_model.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:evently_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

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

  static CollectionReference<UserModel> get getUsersCollection {
    FirebaseFirestore db = FirebaseFirestore.instance;
    return db
        .collection("Users")
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) => UserModel.formJson(snapshot.data()!),
      toFirestore: (user, _) => user.toJson(),
    );
  }

  static Future<void> addUserToFirestore(UserModel user) {
    CollectionReference<UserModel> usersCollection = getUsersCollection;
    DocumentReference<UserModel> userModel = usersCollection.doc(user.id);
    return userModel.set(user);
  }

  static Future<UserModel> getUserFromFirestore(String userId) async {
    DocumentReference<UserModel> userDocument = getUsersCollection.doc(userId);
    DocumentSnapshot<UserModel> documentSnapshot = await userDocument.get();
    UserModel user = documentSnapshot.data()!;
    return user;
  }

  static CollectionReference<EventModel> getEventsCollection(
      BuildContext context,) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference<EventModel> eventsCollection = db
        .collection("Events")
        .withConverter(
      fromFirestore: (documentSnapshot, _) =>
          EventModel.fromJson(documentSnapshot.data()!, context),
      toFirestore: (eventt, _) => eventt.toJson(),
    );
    return eventsCollection;
  }

  static Future<void> addEventToFirestore(EventModel event,
      BuildContext context,) {
    // CollectionReference<Map<String,dynamic>> eventsCollection=db.collection("Events");
    // DocumentReference<Map<String,dynamic>> eventDocument=eventsCollection.doc();
    DocumentReference<EventModel> eventDocument = getEventsCollection(
      context,
    ).doc();

    event.id = eventDocument.id;
    return eventDocument.set(event);
  }

  static Future<List<EventModel>> getEventsFromFireStore(BuildContext context,
      CategoryModel selectedCategory) async {
    CollectionReference<EventModel> eventsCollection = getEventsCollection(
        context);
    QuerySnapshot<EventModel> eventsSnapshot = await eventsCollection
        .orderBy(
        "dateTime", descending: false)
        .where("categoryId",
        isEqualTo: selectedCategory.id == "0" ? null : selectedCategory.id)
        .get();
    List<EventModel> events = eventsSnapshot.docs.map((documentSnapshot) =>
        documentSnapshot.data()).toList();
    return events;
  }


  static Stream<List<EventModel>>getEventsWithRealTimeUpdates(BuildContext context,
      CategoryModel selectedCategory) async* {
    CollectionReference<EventModel> eventsCollection = getEventsCollection(
        context);
    Query<EventModel> query = eventsCollection.orderBy(
        "dateTime", descending: false).where(
        "categoryId", isEqualTo: selectedCategory.id=="0"? null:selectedCategory.id);
    Stream<QuerySnapshot<EventModel>> snapShots = await query.snapshots();
    //snapShots=[snapShot,snapShot,....]
    Stream<List<EventModel>> eventsStream=await snapShots.map((snapshot) => snapshot.docs.map((queryDocumentSnapshot) =>queryDocumentSnapshot.data()).toList());
    yield* eventsStream;
  }
}
