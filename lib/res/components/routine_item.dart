import 'package:assessment_app/res/colors.dart';
import 'package:assessment_app/res/fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../model/routine_item_model.dart';
import 'package:flutter/material.dart';

import '../../viewmodel/daily_routine_view_model.dart';

class RoutineItem extends StatefulWidget {
  final RoutineItemModel routineItem;
  const RoutineItem({super.key, required this.routineItem});

  @override
  State<RoutineItem> createState() => _RoutineItemState();
}

class _RoutineItemState extends State<RoutineItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                widget.routineItem.isDone = !widget.routineItem.isDone;
                Provider.of<DailyRoutineViewModel>(context, listen: false)
                    .updateStatus(widget.routineItem.name);
              });
            },
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColor.checkButtonColor,
              ),
              child: widget.routineItem.isDone
                  ? const Center(
                      child: Icon(
                        Icons.check,
                        size: 24,
                      ),
                    )
                  : null,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.routineItem.name,
                  style: AppFonts.primaryText,
                ),
                Text(
                  widget.routineItem.description,
                  style: AppFonts.secondaryText,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(3.0),
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 27,
                ),
              ),
              widget.routineItem.timestamp != null
                  ? Text(
                      DateFormat('HH:mm a')
                          .format(widget.routineItem.timestamp!),
                      style: AppFonts.secondaryText,
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}
