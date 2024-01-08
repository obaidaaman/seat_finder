import 'package:flutter/material.dart';
import 'package:seat_finder/constants/colors.dart';

import 'package:seat_finder/widget_components/customs/custom_clipper.dart';
import 'package:seat_finder/widget_components/seat_widget/front_seat_widget.dart';


import '../seat_widget/opposite_seat_widget.dart';
class CabinWidgetView extends StatelessWidget {
  const CabinWidgetView({
    super.key,
    required this.searchBarText,
    required this.index,
  });

  final String? searchBarText;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                seatStackFront(),
                sideSeatStackFront(),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                seatStackOpp(),
                sideSeatStackOpp(),
              ],
            ),
          ],
        ),
        const SizedBox(height: 2),
      ],
    );
  }

  Stack sideSeatStackOpp() {
    return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ClipPath(
                    clipper: MyCustomCliperFromBottom(),
                    child: Container(
                      height: 60,
                      width: 72,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: SFColors.clipperContainerColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: OppositeSeatWidget(
                      searchBarText: searchBarText,
                      seatIndex: 8 + index * 8,
                      seatType: "Side Up",
                    ),
                  ),
                ],
              );
  }

  Stack seatStackOpp() {
    return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ClipPath(
                    clipper: MyCustomCliperFromBottom(),
                    child: Container(
                      height: 60,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: SFColors.clipperContainerColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        OppositeSeatWidget(
                          searchBarText: searchBarText,
                          seatIndex: 4 + index * 8 ,
                          seatType: "Lower",
                        ),
                        //
                        const SizedBox(
                          width: 2,
                        ),
                        OppositeSeatWidget(
                          searchBarText: searchBarText,
                          seatIndex: 5 + index * 8,
                          seatType: "Middle",
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        OppositeSeatWidget(
                          searchBarText: searchBarText,
                          seatIndex: 6 + index * 8,
                          seatType: "Upper",
                        ),
                      ],
                    ),
                  ),
                ],
              );
  }

  Stack sideSeatStackFront() {
    return Stack(
                alignment: Alignment.topCenter,
                children: [
                  ClipPath(
                    clipper: CustomClipperTop(),
                    child: Container(
                      height: 60,
                      width: 72,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: const Color(0xff80CBFF),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: FrontSeatWidget(
                      searchBarText: searchBarText,
                      seatIndex: 7 + index * 8,
                      seatType: "Side Low",
                    ),
                  ),
                ],
              );
  }

  Stack seatStackFront() {
    return Stack(
                alignment: Alignment.topCenter,
                children: [
                  ClipPath(
                    clipper: CustomClipperTop(),
                    child: Container(
                      height: 60,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: SFColors.clipperContainerColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        FrontSeatWidget(
                          searchBarText: searchBarText,
                          seatIndex: 1 + index * 8,
                          seatType: "Lower",
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        FrontSeatWidget(
                          searchBarText: searchBarText,
                          seatIndex: 2 + index * 8,
                          seatType: "Middle",
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        FrontSeatWidget(
                          searchBarText: searchBarText,
                          seatIndex: 3 + index * 8,
                          seatType: "Upper",
                        ),
                      ],
                    ),
                  ),
                ],
              );
  }
}
