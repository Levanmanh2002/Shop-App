import 'package:flutter/material.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:shop/widgets/big_text.dart';
import 'package:shop/widgets/icon_and_text_widget.dart';
import 'package:shop/widgets/small_text.dart';

class AppClumn extends StatelessWidget {
  final String text;
  const AppClumn({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: Dimensions.font26,
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(
                5,
                (index) => const Icon(
                  Icons.star,
                  color: Colors.greenAccent,
                  size: 15,
                ),
              ).toList(),
            ),
            const SizedBox(
              width: 10,
            ),
            SmallText(text: "4.5"),
            const SizedBox(
              width: 10,
            ),
            SmallText(text: "0"),
            const SizedBox(
              width: 10,
            ),
            SmallText(text: "Bình luận"),
          ],
        ),
        SizedBox(
          height: Dimensions.height20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            IconAnhTextWidget(
              icon: Icons.circle_sharp,
              text: "Normal",
              iconColor: Colors.yellow,
            ),
            IconAnhTextWidget(
              icon: Icons.location_on,
              text: "1.7 km",
              iconColor: Colors.green,
            ),
            IconAnhTextWidget(
              icon: Icons.access_time,
              text: "32 min",
              iconColor: Colors.red,
            ),
          ],
        ),
      ],
    );
  }
}
