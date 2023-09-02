import 'package:byourside/widget/authenticate/setup/user_type_button.dart';
import 'package:flutter/material.dart';


class UserTypeSelection extends StatelessWidget {
  final String selectedType;
  final Function(String) onTypeSelected;

  const UserTypeSelection({super.key, 
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.all(deviceWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          Text(
            '어떤 유형의 사용자인지 알려주세요',
            style: TextStyle(
              fontSize: deviceWidth * 0.04,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: deviceHeight * 0.02),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (String userType in ['장애 아동 보호자', '장애인', '종사자'])
                  UserTypeButton(
                    userType: userType,
                    isSelected: selectedType == userType,
                    onPressed: () => onTypeSelected(userType),
                    width: deviceWidth * 0.28,
                    height: deviceHeight * 0.2,
                    font: deviceWidth * 0.027
                  ),
                ],
          ),
          SizedBox(height: deviceHeight * 0.02),
          UserTypeButton(
            userType: '해당 없음',
            isSelected: selectedType == '해당 없음',
            onPressed: () => onTypeSelected('해당 없음'),
            width: deviceWidth * 0.9,
            height: deviceHeight * 0.08,
            font: deviceWidth * 0.027
          ),
        ],
      ),
    );
  }
}