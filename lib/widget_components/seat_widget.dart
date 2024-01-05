import 'package:flutter/material.dart';
import 'package:seat_finder/constants/colors.dart';

class SeatWidget extends StatefulWidget {
  const SeatWidget(
      {super.key,
      required this.seatIndex,
      required this.seatType,
      this.searchBarText});

  final int seatIndex;
  final String seatType;

  final String? searchBarText;

  @override
  State<SeatWidget> createState() => _SeatWidgetState();
}

class _SeatWidgetState extends State<SeatWidget> {

  bool shouldHighlightSeat() {
    print(
        'Search Text: ${widget.searchBarText}, Seat Index: ${widget.seatIndex.toString()}');
    return widget.searchBarText == widget.seatIndex.toString();
  }

  @override
  Widget build(BuildContext context) {
    bool shouldHighlight = shouldHighlightSeat();
    return SeatArchitecture(shouldHighlight: shouldHighlight, widget: widget);
    ;
  }
}

class SeatArchitecture extends StatelessWidget {
  const SeatArchitecture({
    super.key,
    required this.shouldHighlight,
    required this.widget,
  });

  final bool shouldHighlight;
  final SeatWidget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: shouldHighlight
                    ? SFColors.blueColor.withOpacity(0.5)
                    : Colors.transparent,
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1))
          ],
          border: Border.all(
            color:
                shouldHighlight ? const Color(0xff126DCA) : Colors.transparent,
            width: 2,
          ),
          color: shouldHighlight ? SFColors.matchedSeatColor :
           SFColors.unmatchedSeatColor),
      child: ColumnWidget(widget: widget, shouldHighlight: shouldHighlight),
    );
  }
}

class ColumnWidget extends StatelessWidget {
  const ColumnWidget({
    super.key,
    required this.widget,
    required this.shouldHighlight,

  });

  final SeatWidget widget;
  final bool shouldHighlight;


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.seatIndex.toString(),
          style: TextStyle(
            fontSize: 16,
            color:
                shouldHighlight ? SFColors.unmatchedSeatColor :
                SFColors.matchedSeatColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          widget.seatType,
          style: TextStyle(
            fontSize: 12,
            color: shouldHighlight ? SFColors.unmatchedSeatColor :
            SFColors.matchedSeatColor,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
