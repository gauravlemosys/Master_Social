import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:socialv/lib_msater_stufy/data/models/AssignmentResponse.dart';
import 'package:socialv/lib_msater_stufy/theme/theme.dart';
import 'package:socialv/lib_msater_stufy/ui/screens/assignment/assignment_parts/assignment_info.dart';

class AssignmentPreviewWidget extends StatefulWidget {
  final AssignmentResponse assignmentResponse;
  final int courseId;
  final int assignmentId;

  const AssignmentPreviewWidget(this.assignmentResponse, this.courseId, this.assignmentId) : super();

  @override
  State<StatefulWidget> createState() => _AssignmentPreviewWidgetState();
}

class _AssignmentPreviewWidgetState extends State<AssignmentPreviewWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 10.0, right: 7.0, bottom: 10.0, left: 7.0),
            child: Text(
              "Assignment " + widget.assignmentResponse.section!.index.toString(),
              textScaleFactor: 1.0,
              style: TextStyle(color: HexColor.fromHex("#273044")),
            )),
        AssignmentInfoWidget(widget.assignmentResponse)
      ],
    );
  }
}
