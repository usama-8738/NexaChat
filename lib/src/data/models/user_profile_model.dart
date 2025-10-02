import '../../domain/entities/user_profile.dart';

class UserProfileModel {
  const UserProfileModel({
    required this.id,
    required this.displayName,
    required this.email,
    required this.avatarUrl,
    required this.subscriptionId,
  });

  final String id;
  final String displayName;
  final String email;
  final String? avatarUrl;
  final String subscriptionId;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      subscriptionId: json['subscriptionId'] as String? ?? '',
    );
  }

  UserProfile toEntity() => UserProfile(
        id: id,
        displayName: displayName,
        email: email,
        avatarUrl: avatarUrl,
        subscriptionId: subscriptionId,
      );
}
