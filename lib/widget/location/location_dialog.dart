import 'package:flutter/material.dart';
import 'package:byourside/constants/location.dart' as constants;
import 'package:byourside/widget/location/location_button.dart';

class LocationDialog extends StatefulWidget {
  final Function(String area, String district) onLocationSelected;
  final double deviceWidth; 
  final double deviceHeight;
  
  const LocationDialog({super.key, 
    required this.onLocationSelected, 
    required this.deviceWidth, 
    required this.deviceHeight,
  });

  @override
  LocationDialogState createState() => LocationDialogState();
}

class LocationDialogState extends State<LocationDialog> {
  String selectedArea = '';
  String selectedDistrict = '';
  
  double getRelativeWidth(double value) {
    return widget.deviceWidth * value;
  }

  double getRelativeHeight(double value) {
    return widget.deviceHeight * value;
  }

  List<Widget> buildAreaButtons() {
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
        deviceHeight: getRelativeHeight(1),
        deviceWidth: getRelativeWidth(1),
      );
    }).toList();
  }

  List<Widget> buildDistrictButtons() {
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
          deviceHeight: getRelativeHeight(1),
          deviceWidth: getRelativeWidth(1),
        );
      }).toList();
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('사는 곳을 선택해 주세요'),
      content: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: getRelativeHeight(0.5)),
          child: Row(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: buildAreaButtons(),
                ),
              ),
             SizedBox(width: getRelativeWidth(0.08)),
              if (selectedArea.isNotEmpty)
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: buildDistrictButtons(),
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
            if (selectedArea.isNotEmpty && selectedDistrict.isNotEmpty) {
              widget.onLocationSelected(selectedArea, selectedDistrict);
              Navigator.pop(context);
            }
          },
          child: const Text('선택 완료'),
        ),
      ],
    );
  }
}
