import 'package:chess_timer/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChipList<T> extends StatelessWidget {
  final List<T> items;
  final Function(int index, T value) onSelectionChanged;
  final int selectedIndex;
  final String Function(T value) labelFormat;

  ChipList(
      {@required this.items,
      @required this.onSelectionChanged,
      @required this.selectedIndex,
      this.labelFormat});

  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: List<Widget>.generate(
      items.length,
      (index) {
        final isSelected = index == selectedIndex;
        return Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: ChoiceChip(
            label: Text(labelFormat == null
                ? items[index].toString()
                : labelFormat(items[index])),
            selected: isSelected,
            selectedColor: Palette.primaryColor,
            labelStyle: TextStyle(
                color: isSelected ? Colors.white : Palette.primaryColor),
            onSelected: (value) {
              onSelectionChanged(index, items[index]);
            },
          ),
        );
      },
    ));
  }
}
