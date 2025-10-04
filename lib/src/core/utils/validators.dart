class Validators {
  const Validators._();

  static final RegExp _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  static final RegExp _passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*[0-9]).{8,}$');
  static final RegExp _phoneRegex = RegExp(r'^\+[0-9]{7,15}$');

  static bool isValidEmail(String value) => _emailRegex.hasMatch(value.trim());

  static bool isStrongPassword(String value) => _passwordRegex.hasMatch(value);

  static bool isValidPhone(String value) => _phoneRegex.hasMatch(value.trim());
}
