class EmailValidator {
  static final _emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    caseSensitive: false,
    multiLine: false,
  );

  static bool validate(String email) {
    return _emailRegex.hasMatch(email);
  }
}
