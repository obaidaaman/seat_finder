import 'package:flutter/material.dart';

class OppositeSeatWidget extends StatefulWidget {
  const OppositeSeatWidget(
      {super.key,
        required this.seatIndex,
        required this.seatType,
        this.searchBarText});

  final int seatIndex;
  final String seatType;

  final String? searchBarText;

  @override
  State<OppositeSeatWidget> createState() => _OppositeSeatWidgetState();
}

class _OppositeSeatWidgetState extends State<OppositeSeatWidget> {

  bool shouldHighlightSeat() {
    print(
        'Search Text: ${widget.searchBarText}, Seat Index: ${widget.seatIndex.toString()}');
    return widget.searchBarText == widget.seatIndex.toString();
  }

  @override
  Widget build(BuildContext context) {
    bool shouldHighlight = shouldHighlightSeat();
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: shouldHighlight
                    ? Colors.blue.withOpacity(0.5)
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
          color: shouldHighlight ? Color(0xff126DCA) :
          const Color(0xffCEEAFF)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.seatType,
            style: TextStyle(
              fontSize: 12,
              color: shouldHighlight ? Color(0xffCEEAFF) :
              Color(0xff126DCA),
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            widget.seatIndex.toString(),
            style: TextStyle(
              fontSize: 16,
              color:
              shouldHighlight ? const Color(0xffCEEAFF) :
              Color(0xff126DCA),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),

        ],
      ),
    );
  }
}
