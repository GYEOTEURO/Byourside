import 'package:flutter/material.dart';
import 'package:byourside/constants/location.dart' as constants;
import 'package:byourside/widget/authenticate/setup/location/location_button.dart';

class LocationDialog extends StatefulWidget {
  final Function(String area, String district) onLocationSelected;

  const LocationDialog({super.key, 
    required this.onLocationSelected,
  });

  @override
  _LocationDialogState createState() => _LocationDialogState();
}

class _LocationDialogState extends State<LocationDialog> {
  String selectedArea = '';
  String selectedDistrict = '';

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
          constraints: const BoxConstraints(maxHeight: 300),
          child: Row(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: buildAreaButtons(),
                ),
              ),
              const SizedBox(width: 16),
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
