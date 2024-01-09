import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seat_finder/constants/colors.dart';

class FrontSeatWidget extends StatefulWidget {
  const FrontSeatWidget(
      {super.key,
      required this.seatIndex,
      required this.seatType,
      this.searchBarText});

  final int seatIndex;
  final String seatType;

  final String? searchBarText;

  @override
  State<FrontSeatWidget> createState() => _FrontSeatWidgetState();
}

class _FrontSeatWidgetState extends State<FrontSeatWidget> {



  bool _isTapped = false;



  void _handleTap(){
    setState(() {
      _isTapped = !_isTapped;
    });
  }



  bool shouldHighlightSeat() {
    print(
        'Search Text: ${widget.searchBarText}, Seat Index: ${widget.seatIndex.toString()}');

    bool isSeatIndexMatched = widget.searchBarText == widget.seatIndex.toString();
    return isSeatIndexMatched || _isTapped;
  }

  @override
  Widget build(BuildContext context) {
    bool shouldHighlight = shouldHighlightSeat();
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
          height: 50.h,
          width: 60.w,
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
                color: shouldHighlight
                    ? SFColors.matchedSeatColor
                    : Colors.transparent,
                width: 2,
              ),
              color: shouldHighlight
                  ? SFColors.matchedSeatColor
                  : SFColors.unmatchedSeatColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.seatIndex.toString(),
                style: TextStyle(
                  fontSize: 16.sp,
                  color: shouldHighlight
                      ? SFColors.unmatchedSeatColor
                      : SFColors.matchedSeatColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
               SizedBox(height: 4.h),
              Text(
                widget.seatType,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: shouldHighlight
                      ? SFColors.unmatchedSeatColor
                      : SFColors.matchedSeatColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          )),
    );
  }
}
