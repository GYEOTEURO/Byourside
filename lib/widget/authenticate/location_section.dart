import 'package:flutter/material.dart';

class LocationSection extends StatefulWidget {
  final Function(String area, String district) onLocationSelected;

  const LocationSection({Key? key, required this.onLocationSelected}) : super(key: key);

  @override
  LocationSectionState createState() => LocationSectionState();
}

class LocationSectionState extends State<LocationSection> {
  String selectedArea = '';
  String selectedDistrict = '';

  Map<String, List<String>> districtsByArea = {
    '서울': ['종로구', '성북구', '강남구', '서초구'],
    '경기': ['수원시', '용인시', '성남시', '안양시'],
    '부산': ['중구', '서구', '동구', '남구'],
    '대구': ['중구', '동구', '서구', '남구'],
    '인천': ['중구', '동구', '미추홀구', '연수구'],
    '광주': ['동구', '서구', '남구', '북구'],
    '대전': ['동구', '중구', '서구', '유성구'],
    '울산': ['중구', '남구', '동구', '북구'],
    '세종': ['세종시'],
    '강원': ['춘천시', '원주시', '강릉시', '동해시'],
    '충북': ['청주시', '충주시', '제천시', '보은군'],
    '충남': ['천안시', '공주시', '보령시', '아산시'],
    '전북': ['전주시', '익산시', '군산시', '정읍시'],
    '전남': ['목포시', '여수시', '순천시', '나주시'],
    '경북': ['포항시', '경주시', '김천시', '안동시'],
    '경남': ['창원시', '김해시', '진주시', '양산시'],
    '제주': ['제주시', '서귀포시'],
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '사는 곳을 입력해주세요',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            _showLocationDialog(context);
          },
          child: const Text('위치 선택'),
        ),
      ],
    );
  }

  void _showLocationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('지역 선택'),
              content: SingleChildScrollView(
                child: Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: districtsByArea.keys.map((area) {
                        return ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedArea = area;
                              selectedDistrict = '';
                            });
                          },
                          child: Text(area),
                        );
                      }).toList(),
                    ),
                    SizedBox(width: 16), // 버튼 간 간격
                    if (selectedArea.isNotEmpty)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: districtsByArea[selectedArea]!.map((district) {
                          return ElevatedButton(
                            onPressed: () {
                              setState(() {
                                selectedDistrict = district;
                              });
                            },
                            child: Text(district),
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // 취소 버튼
                  },
                  child: Text('취소'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _onSelectionComplete(context);
                  },
                  child: Text('선택 완료'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _onSelectionComplete(BuildContext context) {
    if (selectedArea.isNotEmpty && selectedDistrict.isNotEmpty) {
      // 선택 정보를 외부로 전달하는 로직 추가
      print('지역: $selectedArea, 구: $selectedDistrict');
      Navigator.pop(context); // 팝업 닫기
    }
  }
}
