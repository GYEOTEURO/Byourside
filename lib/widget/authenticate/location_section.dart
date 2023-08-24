import 'package:flutter/material.dart';
import 'package:byourside/constants/location.dart' as constants;

class LocationSection extends StatefulWidget {
  final Function(String area, String district) onLocationSelected;

  const LocationSection({Key? key, required this.onLocationSelected}) : super(key: key);

  @override
  LocationSectionState createState() => LocationSectionState();
}

class LocationSectionState extends State<LocationSection> {
  String selectedArea = '';
  String selectedDistrict = '';

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
              title: const Text('지역 선택'),
              content: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 300), // 최대 높이 설정
                  child: Row(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: constants.districtsByArea.keys.map((area) {
                            return ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedArea = area;
                                  selectedDistrict = '';
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: selectedArea == area ? Colors.blue : Colors.grey, // 선택된 상태일 때의 배경색
                              ),
                              child: Text(area),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(width: 16), // 버튼 간 간격
                      if (selectedArea.isNotEmpty)
                        SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: constants.districtsByArea[selectedArea]!.map((district) {
                              return ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    selectedDistrict = district;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: selectedDistrict == district ? Colors.blue : Colors.grey, // 선택된 상태일 때의 배경색
                                ),
                                child: Text(district),
                              );
                            }).toList(),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // 취소 버튼
                  },
                  child: const Text('취소'),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.onLocationSelected(selectedArea, selectedDistrict);
                    Navigator.pop(context);
                  },
                  child: const Text('선택 완료'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
