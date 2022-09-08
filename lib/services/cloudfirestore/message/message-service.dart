import 'package:onurun/models/message.dart';
import 'package:onurun/services/auth/auth_service.dart';
import 'package:onurun/services/cloudfirestore/base-service.dart';

class MessageCloudFireStoreService extends CloudFireStoreBaseService {
  // Singleton pattern
  MessageCloudFireStoreService get instance {
    _instance ??= MessageCloudFireStoreService._init(collectionName: 'messages');
    return _instance!;
  }

  MessageCloudFireStoreService._init({required super.collectionName});

  static MessageCloudFireStoreService? _instance;

  Future<Message> addMessage({required String messageText}) async {
    final document = await collection.add(
      Message(
        fromId: AuthService.firebase().currentUser!.id,
        messageText: messageText,
        messageId: '',
      ).toMap(),
    );
    final fetchedMessage = await document.get();
    return Message(
      messageText: messageText,
      fromId: AuthService.firebase().currentUser!.id,
      messageId: fetchedMessage.id,
    );
  }

  Stream<Iterable<Message>> allMessage() {
    final allMessage = collection.snapshots().map((event) => event.docs.map((doc) => Message.fromSnapshot(doc)));
    return allMessage;
  }
}
