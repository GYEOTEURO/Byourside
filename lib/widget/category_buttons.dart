import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:flutter/material.dart';

class CategoryButtons extends StatefulWidget {
  const CategoryButtons({
    super.key,
    required this.category, 
    required this.onChipSelected
  });

  final List<String> category;
  final ValueChanged<String> onChipSelected;  
  
  @override
  State<CategoryButtons> createState() => _CategoryButtonsState();
}

class _CategoryButtonsState extends State<CategoryButtons> {

  String selectedChip = '';

  @override
  void initState() {
    super.initState();
    selectedChip = widget.category[0];
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors.appBarColor,
      padding: const EdgeInsets.fromLTRB(20, 0, 14, 20),
      child: Row(
        children: [
        for(int i=0; i<widget.category.length; i++)
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 6, 0),
            child: ChoiceChip(
                label: Text(
                  widget.category[i],
                  style: const TextStyle(
                        color: colors.textColor,
                        fontSize: fonts.bodyPt,
                        fontFamily: fonts.font
                  )
                ),
                selected: selectedChip == widget.category[i],
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      selectedChip = widget.category[i];
                      widget.onChipSelected(selectedChip);
                    }
                  });
                },
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 0.50, color: colors.primaryColor),
                  borderRadius: BorderRadius.circular(20),
                ),
                selectedColor: colors.primaryColor,
                backgroundColor: Colors.white,
                disabledColor: Colors.white,
            )
          )
        ]));
    
  }
}
