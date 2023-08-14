import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserTypeButton {
  static Widget buildButton(BuildContext context, String text, bool isSelected, void Function() onPressed) {
    return Expanded(
      child: Material(
        elevation: isSelected ? 10.0 : 5.0,
        borderRadius: BorderRadius.circular(20.0),
        color: isSelected
            ? Colors.orange // Change the color for selected state
            : Theme.of(context).primaryColor,
        child: MaterialButton(
          padding: const EdgeInsets.all(20.0),
          onPressed: onPressed,
          child: Text(
            text,
            semanticsLabel: text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: 'NanumGothic',
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  static Widget buildNoOptionButton(BuildContext context, bool isSelected, void Function() onPressed) {
    return MaterialButton(
      onPressed: onPressed,
      color: isSelected ? Colors.orange : Theme.of(context).primaryColor,
      elevation: isSelected ? 10.0 : 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.all(20.0),
      minWidth: double.infinity,
      child: const Text(
        '해당 사항이 없어요',
        semanticsLabel: '해당 사항이 없어요',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontFamily: 'NanumGothic',
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
