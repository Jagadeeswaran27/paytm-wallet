class PhoneAuthResult {
  const PhoneAuthResult();
}

class CodeSent extends PhoneAuthResult {
  final String verificationId;
  final int? resendToken;
  const CodeSent(this.verificationId, this.resendToken);
}

class PhoneAuthError extends PhoneAuthResult {
  final String message;
  const PhoneAuthError(this.message);
}
