import 'package:nudge/utils/baseAuth.dart';

Future<String> getUserImage(userId) async {
  BaseAuth auth = new Auth();
  var v = 
       (await auth.getStudentProfileData(userId));
  return v.imageUrl;
}
