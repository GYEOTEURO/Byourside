import 'package:byourside/widget/complete_button.dart';
import 'package:byourside/widget/location/area_button.dart';
import 'package:flutter/material.dart';
import 'package:byourside/constants/location.dart' as constants;
import 'package:byourside/widget/location/district_button.dart';

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
      return AreaButton(
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
        return DistrictButton(
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
      title: Text(
        '사는 곳을 선택해 주세요',
        style: TextStyle(
          fontSize: getRelativeWidth(0.038),
          fontWeight: FontWeight.w400,
        ),
      ),
      content: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: getRelativeHeight(0.5)),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: getRelativeWidth(0.06)), 
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: buildAreaButtons(),
                  ),
                ),
              ),
              if (selectedArea.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(left: getRelativeWidth(0.06)), 
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: buildDistrictButtons(),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      actions: [
        CompleteButton(
          onPressed: () {
            if (selectedArea.isNotEmpty && selectedDistrict.isNotEmpty) {
              widget.onLocationSelected(selectedArea, selectedDistrict);
              Navigator.pop(context);
            }
          },
          text: '선택 완료',
        ),
      ],
      contentPadding: EdgeInsets.only(top: getRelativeHeight(0.05)),
    );
  }
}
