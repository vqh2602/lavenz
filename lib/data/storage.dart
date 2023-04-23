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
// tự động phát video
  static const String dataPlayVideo = 'data_auto_play_video';
  // url hỉnh ảnh ng dùng => base64
  static const String dataUrlAvatarUser = 'data_avatar_user';
  // dữ liệu workout
  static const String dataWorkout = 'data_workout';
  // dữ liệu tag
  static const String dataTag = 'data_workout';

  //data blog
  static const String dataBlog = 'data_blog';

  //data dataTrainingPlan
  static const String dataTrainingPlan = 'data_training_plan';

  // data tag training, lưu trạng thái kế hoạch tập luyen
  static const String dataTrainingTagPlan = 'data_training_tag_plan';
}

class Config {
  // thời gian buộc đăng xuất (giờ)
  static const int dataLoginTimeOut = 168;
}
