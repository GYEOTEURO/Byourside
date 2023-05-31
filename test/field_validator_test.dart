import 'package:byourside/model/field_validator.dart';
import 'package:test/test.dart';

void main() {
  test('validatePassword - valid password', () {
    expect(FieldValidator.validatePassword('Abcdefg1'), isNull);
  });

  test('validatePassword - empty password', () {
    expect(FieldValidator.validatePassword(''), equals('필수 입력란'));
  });

  test('validatePassword - password less than 8 characters', () {
    expect(FieldValidator.validatePassword('Abcd1'), equals('비밀번호는 8자 이상으로 구성해야합니다.'));
  });

  test('validatePassword - password without uppercase letters', () {
    expect(FieldValidator.validatePassword('abcdefg1'), equals('비밀번호는 영문 대문자, 영문 소문자, 숫자를 포함하여 8자 이상이어야합니다.'));
  });

  test('validatePassword - password without lowercase letters', () {
    expect(FieldValidator.validatePassword('ABCDEFG1'), equals('비밀번호는 영문 대문자, 영문 소문자, 숫자를 포함하여 8자 이상이어야합니다.'));
  });

  test('validatePassword - password without numbers', () {
    expect(FieldValidator.validatePassword('Abcdefgh'), equals('비밀번호는 영문 대문자, 영문 소문자, 숫자를 포함하여 8자 이상이어야합니다.'));
  });

  test('validateEmail - valid email', () {
    expect(FieldValidator.validateEmail('test@example.com'), isNull);
  });

  test('validateEmail - empty email', () {
    expect(FieldValidator.validateEmail(''), equals('필수 입력란'));
  });

  test('validateEmail - invalid email', () {
    expect(FieldValidator.validateEmail('testexample.com'), equals('유효한 이메일 주소를 입력해주세요.'));
  });
}
