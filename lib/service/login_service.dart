import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginService {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('http://192.168.50.135:8081/api/user/login');

    final loginData = {
      "email": email,
      "password": password,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(loginData),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        // 로그인 성공 및 메시지 반환
        return {
          'success': responseBody['success'],
          'message': responseBody['message'],
        };
      } else if (response.statusCode == 404) {
        // 사용자를 찾을 수 없을 때
        return {
          'success': false,
          'message': '사용자를 찾을 수 없음',
        };
      } else {
        // 기타 서버 오류 처리
        throw '서버 오류: ${response.statusCode}';
      }
    } catch (error) {
      // 오류 처리
      throw '오류 발생: $error';
    }
  }
}
