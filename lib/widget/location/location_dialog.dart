import 'package:byourside/widget/complete_button.dart';
import 'package:byourside/widget/location/area_button.dart';
import 'package:flutter/material.dart';
import 'package:byourside/constants/location.dart' as constants;
import 'package:byourside/widget/location/district_button.dart';

class LocationDialog extends StatefulWidget {
  final String title;
  final Function(String area, String district) onLocationSelected;
  final double deviceWidth;
  final double deviceHeight;

  const LocationDialog({
    Key? key,
    required this.onLocationSelected,
    required this.deviceWidth,
    required this.deviceHeight,
    required this.title,
  }) : super(key: key);

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

  Widget buildDialogTitle() {
    return Text(
      widget.title,
      style: TextStyle(
        fontSize: getRelativeWidth(0.038),
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget buildContent() {
    return Row(
      children: [
        buildAreaColumn(),
        if (selectedArea.isNotEmpty) buildDistrictColumn(),
      ],
    );
  }

  Widget buildAreaColumn() {
    return Padding(
      padding: EdgeInsets.only(right: getRelativeWidth(0.06)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: buildAreaButtons(),
        ),
      ),
    );
  }

  Widget buildDistrictColumn() {
    return Padding(
      padding: EdgeInsets.only(left: getRelativeWidth(0.06)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: buildDistrictButtons(),
        ),
      ),
    );
  }

  Widget buildCompleteButton() {
    return CompleteButton(
      onPressed: () {
        if (selectedArea.isNotEmpty && selectedDistrict.isNotEmpty) {
          widget.onLocationSelected(selectedArea, selectedDistrict);
          Navigator.pop(context);
        }
      },
      text: '선택완료',
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: buildDialogTitle(),
      content: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: getRelativeHeight(0.5)),
          child: buildContent(),
        ),
      ),
      actions: [
        buildCompleteButton(),
      ],
      contentPadding: EdgeInsets.only(top: getRelativeHeight(0.05)),
    );
  }
}
