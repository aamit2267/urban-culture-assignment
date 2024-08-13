// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:assessment_app/res/colors.dart';
import 'package:assessment_app/res/fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../model/routine_item_model.dart';
import 'package:flutter/material.dart';
import '../../viewmodel/daily_routine_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RoutineItem extends StatefulWidget {
  final RoutineItemModel routineItem;
  const RoutineItem({super.key, required this.routineItem});

  @override
  State<RoutineItem> createState() => _RoutineItemState();
}

class _RoutineItemState extends State<RoutineItem> {
  Future<void> addImage(BuildContext context) async {
    final data = Provider.of<DailyRoutineViewModel>(context, listen: false);
    String imagePath = data.dailyRoutine!
        .where((element) => element['name'] == widget.routineItem.name)
        .first['imagePath'];
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColor.checkButtonColor,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColor.checkButtonColor,
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                child: (imagePath != 'Null') ? Image.network(imagePath) : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.checkButtonColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size(
                    double.infinity,
                    40,
                  ),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: AppColor.checkButtonColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    context: context,
                    builder: (newcontext) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.checkButtonColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: const Size(
                                double.infinity,
                                40,
                              ),
                            ),
                            onPressed: () async {
                              ImagePicker imagePicker = ImagePicker();
                              late File image;
                              imagePicker
                                  .pickImage(source: ImageSource.camera)
                                  .then(
                                (value) async {
                                  image = File(value!.path);
                                  Reference storageRef =
                                      FirebaseStorage.instance.ref().child(
                                          'images/jAiBaTIxkxPbfmYdn57pFdgOe2D3/${widget.routineItem.name}/${DateTime.now().millisecondsSinceEpoch}.jpg');
                                  await storageRef.putFile(image);
                                  String downloadUrl =
                                      await storageRef.getDownloadURL();
                                  data.updateImage(
                                    downloadUrl,
                                    widget.routineItem.name,
                                  );
                                  Navigator.pop(context);
                                },
                              );
                            },
                            child: Center(
                              child: Text(
                                'Camera',
                                style: AppFonts.buttonText,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.checkButtonColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: const Size(
                                double.infinity,
                                40,
                              ),
                            ),
                            onPressed: () async {
                              ImagePicker imagePicker = ImagePicker();
                              late File image;
                              imagePicker
                                  .pickImage(source: ImageSource.gallery)
                                  .then(
                                (value) async {
                                  image = File(value!.path);
                                  Reference storageRef =
                                      FirebaseStorage.instance.ref().child(
                                          'images/jAiBaTIxkxPbfmYdn57pFdgOe2D3/${widget.routineItem.name}/${DateTime.now().millisecondsSinceEpoch}.jpg');
                                  await storageRef.putFile(image);
                                  String downloadUrl =
                                      await storageRef.getDownloadURL();
                                  data.updateImage(
                                    downloadUrl,
                                    widget.routineItem.name,
                                  );
                                  Navigator.pop(context);
                                },
                              );
                            },
                            child: Center(
                              child: Text(
                                'Gallery',
                                style: AppFonts.buttonText,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: Text(
                  (imagePath != 'Null') ? 'Change Image' : 'Upload Image',
                  style: AppFonts.buttonText,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

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
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: IconButton(
                  onPressed: () => addImage(context),
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                    size: 27,
                  ),
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
