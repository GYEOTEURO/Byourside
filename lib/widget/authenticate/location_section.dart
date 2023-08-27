import 'package:byourside/widget/authenticate/location_button.dart';
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

  List<Widget> buildAreaButtons(StateSetter setState) {
    return constants.districtsByArea.keys.map((area) {
      return LocationButton(
        label: area,
        isSelected: selectedArea == area,
        onPressed: () {
          setState(() {
            selectedArea = area;
            selectedDistrict = '';
          });
        },
      );
    }).toList();
  }

  List<Widget> buildDistrictButtons(StateSetter setState) {
    if (selectedArea.isNotEmpty) {
      return constants.districtsByArea[selectedArea]!.map((district) {
        return LocationButton(
          label: district,
          isSelected: selectedDistrict == district,
          onPressed: () {
            setState(() {
              selectedDistrict = district;
            });
          },
        );
      }).toList();
    }
    return [];
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
                  constraints: const BoxConstraints(maxHeight: 300),
                  child: Row(
                    children:  [
                      SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: buildAreaButtons(setState),
                        ),
                      ),
                      const SizedBox(width: 16),
                      if (selectedArea.isNotEmpty)
                        SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: buildDistrictButtons(setState),
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
}
