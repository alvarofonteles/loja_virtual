// dependencies: email_validator: ^2.1.16
import 'package:email_validator/email_validator.dart';

bool emailValid(String email) {
  return EmailValidator.validate(email);
}

// do professor Daniel
/*bool emailValid(String email) {
  final RegExp regex = RegExp(
      r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$");
 return regex.hasMatch(email);
}*/
