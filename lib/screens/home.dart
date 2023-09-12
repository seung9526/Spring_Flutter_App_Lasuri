import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Image.asset('assets/logo/suuitch_main_logo.png', height: 45),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              // 아이콘을 눌렀을 때 수행할 작업
            },
            icon: Ink(
              decoration: BoxDecoration(
                color: Color(0xFFB5D0E5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.manage_accounts_outlined,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: IconButton(
              onPressed: () {
                // 아이콘을 눌렀을 때 수행할 작업
              },
              icon: Ink(
                decoration: BoxDecoration(
                  color: Color(0xFFB5D0E5),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.notifications_none,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 10.0, // AppBar와 SafeArea 사이의 높이 설정
            ),
            SafeArea(
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      color: Color(0xFFD1EFF9),
                      height: 40,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.0),
                              child: Text(
                                "Event",
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "Tips",
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.0),
                              child: Text(
                                "FAQ",
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 375,
              height: 230,
              child: Card(
                color: Color(0xFFD1EFF9),
                margin: EdgeInsets.all(25.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // 라운드 처리
                ),
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                      Column(
                        children: [
                          Text(
                            "스위치에\n오신 것을\n환영합니다.",
                            style: TextStyle(
                              fontSize: 20.5,
                              height: 1.5,
                              color: Colors.black,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 1.0),
                        ],
                      ),
                      SizedBox(width: 15.0),
                      Image.asset('assets/image/switch_icon.png', height: 100.0),
                      // 수정된 버튼
                      Padding(
                        padding: EdgeInsets.all(0.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(Size(90.0, 30.0)),
                            backgroundColor: MaterialStateProperty.all(Color(0xFFB5D0E5)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0), // 라운드 처리
                              ),
                            ),
                          ),
                          child: Text(
                            '가이드',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            GridView.count(
              crossAxisCount: 2, // 2열로 정렬
              childAspectRatio: 1.15/1, // 그리드 아이템의 가로 세로 비율
              shrinkWrap: true, // GridView의 크기를 그리드 아이템에 맞게 조정
              children: List.generate(4, (index) {
                String cardText = ""; // 텍스트를 초기화합니다.
                String imagePath = ""; // 이미지 경로를 초기화합니다.

                // 각 인덱스에 따라 다른 텍스트와 이미지를 할당합니다.
                switch (index) {
                  case 0:
                    imagePath = 'assets/image/AS_technician_icon.png';
                    cardText = "AS 접수";
                    break;
                  case 1:
                    cardText = "전문가 검색";
                    imagePath = 'assets/image/pro_search_icon.png';
                    break;
                  case 2:
                    cardText = "로켓 AS";
                    imagePath = 'assets/image/fast_time_icon.png';
                    break;
                  default:
                    cardText = "주소 검색";
                    imagePath = 'assets/image/home_search_icon.png';
                    break;
                }

                return _buildCard(cardText, imagePath);
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '검색',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            label: '위치',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description_outlined),
            label: '설명',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'MY',
          ),
        ],
      ),
    );
  }

  // 탭 내용을 구현할 때 해당하는 함수
  Widget _buildEventTabContent() {
    // 'Event' 탭의 내용을 구현
    return Center(
      child: Text("Event content"),
    );
  }

  Widget _buildTipsTabContent() {
    // 'Tips' 탭의 내용을 구현
    return Center(
      child: Text("Tips content"),
    );
  }

  Widget _buildFAQTabContent() {
    // 'FAQ' 탭의 내용을 구현하세요.
    return Center(
      child: Text(
        "FAQ Content",
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget _buildCard(String cardText, String imagePath) {
    return Container(
      child: Card(
        color: Color(0xFFD1EFF9),
        margin: EdgeInsets.only(left: 30.0, right: 30, bottom: 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // 라운드 처리
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                imagePath, // 이미지 경로
                height: 100, // 이미지 높이 조절
              ),
              Text(
                cardText, // 카드에 표시할 텍스트
                style: TextStyle(
                  fontSize: 18.0, // 텍스트 크기 조절
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
