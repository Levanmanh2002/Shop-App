import 'package:flutter/material.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:shop/widgets/small_text.dart';

class ExandableTextWidget extends StatefulWidget {
  final String text;

  const ExandableTextWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<ExandableTextWidget> createState() => _ExandableTextWidgetState();
}

class _ExandableTextWidgetState extends State<ExandableTextWidget> {
  late String firstHalf;
  late String seconHalf;

  bool hiddenText = true;

  double textHeight = Dimensions.screenHeight / 5.63;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      seconHalf = widget.text.substring(
        textHeight.toInt() + 1,
        widget.text.length,
      );
    } else {
      firstHalf = widget.text;
      seconHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: seconHalf.isEmpty
          ? SmallText(
              color: Colors.black54,
              size: Dimensions.font16,
              text: firstHalf,
            )
          : Column(
              children: [
                SmallText(
                  height: 1.8,
                  color: Colors.black54,
                  size: Dimensions.font16,
                  text:
                      hiddenText ? ("$firstHalf...") : (firstHalf + seconHalf),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      SmallText(
                        text: hiddenText ? "Xem thêm" : "Thu gọn",
                        color: Colors.greenAccent,
                      ),
                      Icon(
                        hiddenText
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: Colors.greenAccent,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
