import 'package:final_year_project/constant.dart';
import 'package:flutter/material.dart';

class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  RangeValues _currentRangeValues = const RangeValues(10, 100);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(_currentRangeValues.start.round().toString()),
          Text(_currentRangeValues.end.round().toString()),
        ]),
        RangeSlider(
          values: _currentRangeValues,
          min: 1,
          max: 1000,
          divisions: 1000,
          activeColor: secondaryColor,
          labels: RangeLabels(
            _currentRangeValues.start.round().toString(),
            _currentRangeValues.end.round().toString(),
          ),
          onChanged: (RangeValues val) => setState(() {
            _currentRangeValues = val;
          }),
        ),
      ],
    );
  }
}
