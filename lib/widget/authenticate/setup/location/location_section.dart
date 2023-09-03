import 'package:byourside/widget/authenticate/setup/explain_text.dart';
import 'package:byourside/widget/authenticate/setup/location/location_button.dart';
import 'package:byourside/constants/colors.dart' as colors;
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
  double _deviceWidth = 0;
  double _deviceHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        var mediaQuery = MediaQuery.of(context);
        _deviceWidth = mediaQuery.size.width;
        _deviceHeight = mediaQuery.size.height;
      });
    });
  }

  double getRelativeWidth(double value) {
    return _deviceWidth * value;
  }

  double getRelativeHeight(double value) {
    return _deviceHeight * value;
  }

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
              title: const Text('사는 곳을 선택해 주세요'),
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
                    if(selectedArea.isNotEmpty && selectedDistrict.isNotEmpty) {
                      widget.onLocationSelected(selectedArea, selectedDistrict);
                      Navigator.pop(context);
                    }
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
    return Padding(
      padding: EdgeInsets.all(getRelativeWidth(0.05)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExplainText(
            text : '사는 곳을 입력해주세요',
            width : getRelativeWidth(0.04),
          ),
          SizedBox(height: getRelativeHeight(0.02)),
          Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: () {
                _showLocationDialog(context);
              },
              style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(0),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.white; // Button color when pressed
                    }
                    if (selectedArea.isNotEmpty && selectedDistrict.isNotEmpty) {
                      return colors.primaryColor; // Button color when selectedArea is not empty
                    }
                    return Colors.white; // Default button color
                  },
                ),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                side: MaterialStateProperty.resolveWith<BorderSide?>(
                  (Set<MaterialState> states) {
                    return const BorderSide(color: Color(0xFFFFC700)); 
                  },
                ),
              ),
              child: SizedBox(
                width: getRelativeWidth(0.8), 
                height: getRelativeHeight(0.07), 
                child: Center(
                  child: Text(
                    selectedArea.isNotEmpty && selectedDistrict.isNotEmpty ? selectedDistrict : '사는 지역 선택하기',
                    style: TextStyle(
                      fontSize: getRelativeWidth(0.038),
                      fontWeight: FontWeight.w700,
                      color: selectedArea.isNotEmpty && selectedDistrict.isNotEmpty ?Colors.black : colors.subColor, 
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
