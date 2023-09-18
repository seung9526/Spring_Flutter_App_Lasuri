import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RoleUpPage extends StatefulWidget {
  @override
  State<RoleUpPage> createState() => _RoleUpPage();
}

class _RoleUpPage extends State<RoleUpPage> {
  // 사용자 정보
  Map<String, dynamic> userInfo = {
    "userEmail": "string",       // 사용자 이메일
    "userPassword": "string",   // 사용자 비밀번호
    "userName": "string",       // 사용자 이름
    "userAddress": "string",   // 사용자 주소
  };

  // 서버 URL
  final String serverUrl = 'http://192.168.0.18:8081/api/user/pro';

  // 업데이트 요청 함수
  Future<void> updateRole() async {
    // HTTP 요청 헤더 설정
    final headers = <String, String>{
      'Content-Type': 'application/json;charset=UTF-8',
    };

    try {
      final response = await http.put(
        Uri.parse(serverUrl),
        headers: headers,
        body: jsonEncode(userInfo), // 사용자 정보를 JSON 형식으로 인코딩하여 전송
      );

      if (response.statusCode == 200) {
        // 서버에서 200 상태 코드가 반환되면 업데이트 성공
        // 업데이트 성공에 대한 처리를 여기에 추가하세요.
      } else {
        // 업데이트 실패에 대한 처리를 여기에 추가하세요.
        // response.statusCode 를 통해 상태 코드에 따른 예외 처리를 수행할 수 있습니다.
      }
    } catch (error) {
      // 네트워크 오류 또는 예외 발생 시 처리
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('전문가 업그레이드'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('전문가로 업그레이드 하시겠습니까?'),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                // 업그레이드 확인 버튼을 눌렀을 때 업데이트 요청 보내기
                updateRole();
              },
              child: Text('업그레이드 확인'),
            ),
            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('취소'),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
