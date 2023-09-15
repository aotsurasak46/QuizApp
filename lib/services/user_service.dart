import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class UserService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future<void> storeUserData(User user) async {
    // Use the user's UID as the document ID to uniquely identify users
    await users.doc(user.uid).set({
      'email': user.email,
      'status': 'Not Started',
      'progress': 0,
      'online': true,
      // Add more user data fields as needed
    });
  }

  Future<bool> doesEmailExist(String email) async {
    try {
      final QuerySnapshot result =
          await users.where('email', isEqualTo: email).get();
      return result.docs.isNotEmpty;
    } catch (error) {
      // Handle errors (e.g., Firestore query error)
      print('Error checking email existence: $error');
      return false;
    }
  }

  Future<void> updateUserStatus(String userId, String newStatus) async {
    try {
      await users.doc(userId).update({
        'status': newStatus,
      });
    } catch (error) {
      // Handle errors (e.g., Firestore update error)
      print('Error updating user status: $error');
    }
  }

  Future<void> updateUserStatusToOffline(String userId) async {
    await users.doc(userId).update({
      'online': false,
    });
    print("user offline");
  }

  Future<void> updateUserProgress(String userId, double newProgress) async {
    try {
      await users.doc(userId).update({
        'progress': newProgress,
      });
    } catch (error) {
      // Handle errors (e.g., Firestore update error)
      print('Error updating user progress: $error');
    }
  }

  Future<List<DocumentSnapshot>> getOnlineUsers() async {
    CollectionReference usersRef =
        FirebaseFirestore.instance.collection('users');
    QuerySnapshot onlineUsersSnapshot =
        await usersRef.where('online', isEqualTo: true).get();

    return onlineUsersSnapshot.docs;
  }
}
