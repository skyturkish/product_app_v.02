import 'package:flutter/foundation.dart' show immutable;

@immutable
class UserModel {
  final String userId;
  final List<String> favorites;

  const UserModel({
    required this.userId,
    required this.favorites,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userId': userId});
    result.addAll({'favorites': favorites});

    return result;
  }
}
