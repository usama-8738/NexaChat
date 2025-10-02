class UserProfile {
  const UserProfile({
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
}
