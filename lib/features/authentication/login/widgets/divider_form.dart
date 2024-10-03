
import 'package:flutter/material.dart';

class TFormDivider extends StatelessWidget {
  const TFormDivider({
    super.key,

  });


  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
            child: Divider(
          thickness: 0.5,
          indent: 60,
          endIndent: 5,
        )),
        // Text(
        //   dividerText,
        //   style: Theme.of(context).textTheme.labelMedium,
        // ),
        Flexible(
            child: Divider(
          thickness: 0.5,
          indent: 5,
          endIndent: 60,
        )),
      ],
    );
  }
}
