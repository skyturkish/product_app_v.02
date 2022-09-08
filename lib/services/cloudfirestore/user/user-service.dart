import 'package:onurun/models/user.dart';
import 'package:onurun/services/cloudfirestore/base-service.dart';

class UserCloudFireStoreService extends CloudFireStoreBaseService {
  static UserCloudFireStoreService get instance {
    _instance ??= UserCloudFireStoreService._init(collectionName: 'users');
    return _instance!;
  }

  UserCloudFireStoreService._init({required super.collectionName});

  static UserCloudFireStoreService? _instance;

  Future<void> createUser({required String userId}) async {
    bool userExist = await isUserExist(userId: userId);
    if (userExist == true) {}
    await collection.doc(userId).set(UserModel(
          userId: userId,
          favorites: const [],
        ).toMap());
  }

  Future<bool> isUserExist({required String userId}) async {
    var docRef = collection.doc(userId);
    final doc = await docRef.get();
    return doc.data() == null ? false : true;
  }

  Future<Map<String, dynamic>?> getUserInformationById({required String userId}) async {
    var docRef = collection.doc(userId);
    final doc = await docRef.get();
    return doc.data();
  }

  Future<List<String>?> getUserFavoritesById({required String userId}) async {
    var docRef = collection.doc(userId);
    final doc = await docRef.get();
    return doc.data() == null ? null : doc.data()!['favorites'] as List<String>;
  }
}
