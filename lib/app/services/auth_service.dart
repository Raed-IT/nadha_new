import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signin(
      {required Function(GoogleSignInAccount? account) onCompleted}) async {
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      int counter = 1;
      while (account == null) {
        counter++;
        account = await _googleSignIn.signIn();
        if (counter == 5) {
          break;
        }
      }
      onCompleted(account);
    } catch (e) {
      Fluttertoast.showToast(msg: "$e");
    }
  }
}
