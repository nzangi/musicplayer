import 'package:music_player/domain/entities/auth/user.dart';

class UserModel {
  String? fullName;
  String? email;
  String? imageURL;

  UserModel({this.fullName, this.email, this.imageURL});

  UserModel.fromJson(Map<String, dynamic> data) {
    fullName = data['name'];
    email = data['email'];
    // imageURL = data['imageURL'];
  }
}

extension UserModelExtension on UserModel {
  UserEntity toEntity() {
    return UserEntity(fullName: fullName!, email: email!);
  }
}
