import 'package:flutter/material.dart';
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/text.dart' as text;
import 'package:byourside/widget/location/location_dialog.dart';
import 'package:byourside/widget/authenticate/setup/explain_text.dart';

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

  void _showLocationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LocationDialog(
          title: text.askLocation,
          onLocationSelected: (area, district) {
            setState(() {
              selectedArea = area;
              selectedDistrict = district;
            });
            widget.onLocationSelected(area, district);
          },
          deviceHeight: getRelativeHeight(1),
          deviceWidth: getRelativeWidth(1),
        );
      },
    );
  }

  ElevatedButton buildLocationButton(BuildContext context) {
    var isLocationSelected = selectedArea.isNotEmpty && selectedDistrict.isNotEmpty;

    return ElevatedButton(
      onPressed: () => _showLocationDialog(context),
      style: ElevatedButton.styleFrom(
        elevation: 0, 
        backgroundColor: isLocationSelected ? colors.primaryColor : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        side: const BorderSide(color: colors.primaryColor),
      ),
      child: SizedBox(
        width: getRelativeWidth(0.8),
        height: getRelativeHeight(0.07),
        child: Center(
          child: Text(
            isLocationSelected ? selectedDistrict : text.selectLocation,
            style: TextStyle(
              fontSize: getRelativeWidth(0.038),
              fontWeight: FontWeight.w700,
              color: isLocationSelected ? Colors.black : colors.subColor,
            ),
          ),
        ),
      ),
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
            text : text.askLocation,
            width : getRelativeWidth(0.04),
          ),
          SizedBox(height: getRelativeHeight(0.02)),
          Align(
            alignment: Alignment.centerLeft,
            child: buildLocationButton(context),
          ),
        ],
      ),
    );
  }
}
