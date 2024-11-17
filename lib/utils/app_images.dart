class AppImage {
  static String imgBaseUrl = 'assets/img';

  static String getImage(String imgLable) {
    return '$imgBaseUrl/$imgLable.png';
  }

  static String get logo => getImage('logo');
  static String get addImage => getImage('add_image');
  static String get imgUsers => getImage('team');
  static String get imgPlaceHolder => getImage('image_place');
  static String get imgUserOfficeMan => getImage('office_man');
  static String get imgTerm => getImage('terms');
  static String get imgCondtions => getImage('conditions');
  static String get imgLogout => getImage('shutdown');
}
