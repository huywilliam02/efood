class RoleConstants {
  RoleConstants._();

  static RoleConstants _instance = RoleConstants._();

  factory RoleConstants() => _instance;

  String getRoleLabel(String rawRole) {
    switch (rawRole.toUpperCase()) {
      case 'USER':
        return 'Người dùng';
      case 'ADMIN':
        return 'Quản trị';
      case 'FARMER':
        return 'Chủ nông trại';
      case 'ASSOCIATIONS':
        return 'Hiệp hội';
      default:
        return rawRole;
    }
  }
}
