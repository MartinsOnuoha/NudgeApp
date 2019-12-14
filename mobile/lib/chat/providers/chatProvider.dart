import 'package:flutter/material.dart';
import 'package:nudge/models/studentModel.dart';
import 'package:nudge/utils/baseAuth.dart';

class ChatProvider extends ChangeNotifier {
  final BaseAuth auth = new Auth();

  final TextEditingController textEditingController =
      new TextEditingController();

  bool _isComposingMessage = false;
  bool get isComposingMessage => _isComposingMessage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  StudentModel _userModel;
  StudentModel get userModel => _userModel;

  set userModel(StudentModel val) {
    _userModel = val;
    notifyListeners();
  }

  set isComposingMessage(bool val) {
    _isComposingMessage = val;
    notifyListeners();
  }

  set isLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  textMessageSubmitted(reference, String text) async {
    _isComposingMessage = false;
    textEditingController.clear();

    sendMessage(reference, messageText: text, imageUrl: null);
  }
  
  updateUserModel(val){
    _userModel = val;
  }

  void sendMessage(reference, {String messageText, String imageUrl}) async {
    reference.push().set({
      'text': messageText,
      'userId': userModel?.reference?.documentID ?? userModel?.studentID,
      'imageUrl': imageUrl,
      'timeStamp': DateTime.now().toIso8601String(),
      'senderName': '${userModel.lastName} ${userModel.firstName}',
      'senderPhotoUrl': userModel.imageUrl,
    });
  }

  

}
