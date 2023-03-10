import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main2.dart';
import 'package:socialv/screens/groups/components/invite_user_component.dart';

import '../../../utils/app_constants.dart';

class CreateGroupStepThree extends StatelessWidget {
  final VoidCallback? onFinish;

  const CreateGroupStepThree({this.onFinish});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: radiusOnly(topRight: defaultRadius, topLeft: defaultRadius),
      ),
      child: Stack(
        children: [
          InviteUserComponent().paddingBottom(70),
          Positioned(
            bottom: 0,
            child: Container(
              width: context.width(),
              padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
              color: context.cardColor,
              child: appButton(
                text: language!.finish.capitalizeFirstLetter(),
                onTap: () {
                  onFinish?.call();
                },
                context: context,
                color: context.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
