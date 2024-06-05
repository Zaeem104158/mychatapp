import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ChatService extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getMessages() {
    return _firestore.collection('chats').orderBy('timestamp', descending: true).snapshots();
  }

  Future<void> sendMessage(String message, String userId) async {
    await _firestore.collection('chats').add({
      'text': message,
      'userId': userId,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
