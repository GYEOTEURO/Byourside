import 'package:test/test.dart';

void main() {
  test('should be lowercase', () { // 어떤 테스트를 할지 설명하고,안에 있는 테스트를 실행합니다. 
    String hello = "Hello World"; 
    
    expect(hello.toLowerCase(), "hello world"); // 테스트를 실행했을 때의 기대값과 실제값을 비교합니다.
  });
}