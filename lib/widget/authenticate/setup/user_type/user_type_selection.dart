import 'package:byourside/widget/authenticate/setup/explain_text.dart';
import 'package:byourside/widget/authenticate/setup/user_type/user_type_button.dart';
import 'package:flutter/material.dart';


class UserTypeSelection extends StatefulWidget {
  final String selectedType;
  final Function(String) onTypeSelected;

  const UserTypeSelection({super.key, 
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  UserTypeSelectionState createState() => UserTypeSelectionState();
}

class UserTypeSelectionState extends State<UserTypeSelection> {
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

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.all(getRelativeWidth(0.05)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          ExplainText(
            text : '어떤 유형의 사용자인지 알려주세요',
            width : getRelativeWidth(0.04),
          ),
        SizedBox(height: getRelativeHeight(0.02)),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (String userType in ['장애 아동 보호자', '장애인', '종사자'])
                  UserTypeButton(
                    userType: userType,
                    isSelected: widget.selectedType == userType,
                    onPressed: () => widget.onTypeSelected(userType),
                    width: getRelativeWidth(0.28),
                    height: getRelativeHeight(0.18),
                    font: getRelativeWidth(0.027)
                  ),
                ],
          ),
          SizedBox(height: getRelativeHeight(0.02)),
          UserTypeButton(
            userType: '해당 없음',
            isSelected: widget.selectedType == '해당 없음',
            onPressed: () => widget.onTypeSelected('해당 없음'),
            width: getRelativeWidth(0.9),
            height: getRelativeHeight(0.08),
            font: getRelativeWidth(0.032)
          ),
        ],
      ),
    );
  }
}