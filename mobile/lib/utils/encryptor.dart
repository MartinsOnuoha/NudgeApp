/* import 'package:encrypt/encrypt.dart';

final key = Key.fromUtf8('rs-QuicksysEncryptedUserPassword');
final iv = IV.fromUtf8('rs-QuicksysUsers');

final encrypter = Encrypter(AES(key));

encryptText(String text) {
  return encrypter.encrypt(text, iv: iv).base64;
}

decryptText(String encryptedText) {
  return encrypter.decrypt(Encrypted.fromBase64(encryptedText), iv: iv);
}
 */