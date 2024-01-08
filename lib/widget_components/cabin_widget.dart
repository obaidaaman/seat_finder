import 'package:flutter/material.dart';

import 'package:seat_finder/widget_components/extractable_widget/cabinwidgetview.dart';

class CabinWidget extends StatelessWidget {
  const CabinWidget({super.key, required this.index, this.searchBarText});

  final int index;
  final String? searchBarText;



  @override
  Widget build(BuildContext context) {


    return CabinWidgetView(searchBarText: searchBarText, index: index);
  }
}

