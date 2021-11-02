class Validators {
  static validateSearch(String value) {
    return value.replaceAll(' ', '+');
  }
}