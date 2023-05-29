class FieldValidator {
  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '필수 입력란';
    }
    if (value.trim().length < 8) {
      return '비밀번호는 8자 이상으로 구성해야합니다.';
    }
    // Check if the entered password meets the requirements using a regular expression
    RegExp regex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$');
    if (!regex.hasMatch(value)) {
      return '비밀번호는 영문 대문자, 영문 소문자, 숫자를 포함하여 8자 이상이어야합니다.';
    }
    // Return null if the entered password is valid
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '필수 입력란';
    }
    // Check if the entered email is valid using a regular expression
    RegExp regex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!regex.hasMatch(value)) {
      return '유효한 이메일 주소를 입력해주세요.';
    }
    // Return null if the entered email is valid
    return null;
  }
}
