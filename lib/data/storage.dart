class Storages {
  /* biến local lưu data storage */
  // chứa thông tin đối tượng user sau khi đăng nhập
  static const String dataUser = 'data_user';
// chứa tài khoản
  static const String dataEmail = 'data_email';
  static const String dataPassWord = 'data_password';
  // lịch sử email đăng nhập trước đó
  static const String historyDataEmail = 'data_email';
// chứa thời gian đăng nhập
  static const String dataLoginTime = 'data_login_time';
// đăng nhập sinh trắc học
  static const String dataBiometric = 'data_biometric';
// data quote trong ngày => 1 ngày chỉ lấy 1 quote
  static const String dataQuote = 'data_quote';
}

class Config {
  // thời gian buộc đăng xuất (giờ)
  static const int dataLoginTimeOut = 168;
}
