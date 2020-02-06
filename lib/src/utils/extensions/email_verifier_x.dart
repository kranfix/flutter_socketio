final _emailPattern = RegExp(
    r'^((([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,})))?$');

extension EmailVerifierX on String {
  bool get isValidEmail {
    if (!_emailPattern.hasMatch(this)) return false;

    final firsts = this.split('@');
    if (firsts.length < 2) return false;
    String domain = firsts[1];
    final parts = domain.split('.');
    for (final p in parts) {
      if (p.length < 1) return false;
    }

    return true;
  }

  bool get isNotValidEmail => !_emailPattern.hasMatch(this);
}
