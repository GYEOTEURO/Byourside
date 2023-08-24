import 'package:byourside/widget/title_only_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;

class Setting extends StatefulWidget {
  Setting({
    Key? key,
    required this.options
  }) : super(key: key);

  String title = '설정';

  List<Map<String, dynamic>> options;

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleOnlyAppbar(context, widget.title),
      body: Column(
            children: [
              for(int i = 0; i < widget.options.length; i++)
              Column(
                children: [
                OutlinedButton(
                  onPressed: () {
                    HapticFeedback.lightImpact(); // 약한 진동
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => widget.options[i]['page']));},
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height / 15.5),
                    elevation: 0,
                    side: const BorderSide(color: Colors.white),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.options[i]['name'],
                      style: const TextStyle(
                        color: colors.textColor,
                        fontSize: 15,
                        fontFamily: fonts.font,
                        fontWeight: FontWeight.w400,
                        height: 1.20,
                      ),
                    )
                )),
                const Divider(color: colors.bgrColor, thickness: 1)
                ])
          ])
    );
      
  }
}

