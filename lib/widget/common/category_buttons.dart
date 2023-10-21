import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:flutter/material.dart';

class CategoryButtons extends StatefulWidget {
  const CategoryButtons({
    super.key,
    required this.category, 
    required this.onCategorySelected
  });

  final List<String> category;
  final ValueChanged<String> onCategorySelected;  
  
  @override
  State<CategoryButtons> createState() => _CategoryButtonsState();
}

class _CategoryButtonsState extends State<CategoryButtons> {

  String selectedCategory = '';

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.category[0];
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors.AppBarColor,
      padding: const EdgeInsets.fromLTRB(20, 0, 14, 20),
      child: Row(
        children: [
        for(int i=0; i<widget.category.length; i++)
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 6, 0),
            child: ChoiceChip(
                label: Text(
                  widget.category[i],
                  semanticsLabel: widget.category[i],
                  style: const TextStyle(
                        color: colors.textColor,
                        fontSize: 18,
                        fontFamily: fonts.font
                  )
                ),
                selected: selectedCategory == widget.category[i],
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      selectedCategory = widget.category[i];
                      widget.onCategorySelected(selectedCategory);
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
