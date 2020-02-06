extension PasswordVerifierX on String {
  bool get isValidPassword {
    int lowerCaseCounter = 0;
    int uppercaseCounter = 0;
    int specialCharCounter = 0;

    for (final char in this.codeUnits) {
      if (char >= 64 && char < 91) {
        uppercaseCounter++;
        continue;
      }

      if (char >= 97 && char < 123) {
        lowerCaseCounter++;
        continue;
      }

      specialCharCounter++;
    }

    return length >= 8 &&
        lowerCaseCounter > 0 &&
        uppercaseCounter > 0 &&
        specialCharCounter > 0;
  }

  bool get isNotValidPassword => !isValidPassword;
}
