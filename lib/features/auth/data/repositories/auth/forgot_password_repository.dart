import 'package:my/core/utils/typedefs.dart';

abstract class ForgotPasswordRepository {
  FutureResult<Map<String, String>> sendPasswordReset(String email);
  FutureResult<bool> verifyResetCode(String code);
  FutureResult<bool> resetPassword(String newPassword, String confirmPassword);
}
