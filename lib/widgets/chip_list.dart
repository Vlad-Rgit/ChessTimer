import 'package:chess_timer/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChipList<T> extends StatefulWidget {
  final List<T> items;
  final Function(int index, T value) onSelectionChanged;
  final String Function(T value) labelFormat;

  ChipList(
      {@required this.items,
      @required this.onSelectionChanged,
      this.labelFormat});

  @override
  _ChipListState<T> createState() => _ChipListState<T>();
}

class _ChipListState<T> extends State<ChipList<T>> {
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: List<Widget>.generate(
      widget.items.length,
      (index) {
        final isSelected = index == _selectedIndex;
        return Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: ChoiceChip(
            label: Text(widget.labelFormat == null
                ? widget.items[index].toString()
                : widget.labelFormat(widget.items[index])),
            selected: isSelected,
            selectedColor: Palette.primaryColor,
            labelStyle: TextStyle(
                color: isSelected ? Colors.white : Palette.primaryColor),
            onSelected: (value) {
              widget.onSelectionChanged(index, widget.items[index]);
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        );
      },
    ));
  }
}
