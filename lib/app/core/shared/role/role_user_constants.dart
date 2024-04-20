class RoleUserConstants {
  RoleUserConstants._();
  static List<String> listRoleDropdown = ['USER', 'FARMER', 'ASSOCIATIONS'];
  static List<String> listIsLockedDropdown = <String>[
    'Không kích hoạt',
    'Kích hoạt',
  ];
  static Map<String, String> roleLabels = {
    'USER': 'Người dùng',
    'FARMER': 'Chủ hội',
    'ASSOCIATIONS': 'Hiệp hội',
  };
}
