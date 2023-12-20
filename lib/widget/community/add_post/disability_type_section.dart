import 'package:flutter/material.dart';
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/text.dart' as text;

class DisabilityTypeSectionInAddPost extends StatefulWidget {
  const DisabilityTypeSectionInAddPost({Key? key, required this.onChipSelected})
      : super(key: key);

  final ValueChanged<String> onChipSelected;

  @override
  _DisabilityTypeSectionInAddPostState createState() =>
      _DisabilityTypeSectionInAddPostState();
}

class _DisabilityTypeSectionInAddPostState
    extends State<DisabilityTypeSectionInAddPost> {
  String _selectedType = '';

  @override
  void initState() {
    super.initState();
    _selectedType = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5.0),
        child: Column(children: [
          const Text(
            '장애유형',
            semanticsLabel: '장애유형',
            style: TextStyle(
                color: colors.textColor,
                fontWeight: FontWeight.bold,
                fontSize: fonts.bodyPt,
                fontFamily: fonts.font),
          ),
          Container(
              padding: const EdgeInsets.all(5.0),
              alignment: Alignment.center,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                for (String disabilityType in text.communityDisabilityTypes)
                  Container(
                      padding: const EdgeInsets.all(5.0),
                      child: ChoiceChip(
                        label: Text(disabilityType,
                            style: const TextStyle(
                                color: colors.textColor,
                                fontSize: fonts.captionTitlePt,
                                fontFamily: fonts.font)),
                        selected: _selectedType == disabilityType,
                        onSelected: (bool selected) {
                          setState(() {
                            if (selected) {
                              _selectedType = disabilityType;
                              widget.onChipSelected(_selectedType);
                            }
                          });
                        },
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 0.50, color: colors.primaryColor),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        selectedColor: colors.primaryColor,
                        backgroundColor: Colors.white,
                        disabledColor: Colors.white,
                      ))
              ]))
        ]));
  }
}
