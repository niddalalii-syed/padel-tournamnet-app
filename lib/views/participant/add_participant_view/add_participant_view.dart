// ignore_for_file: unnecessary_string_interpolations

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:tournament_manager/service/image_picker.dart';
import 'package:tournament_manager/service/upload_images.dart';
import 'package:tournament_manager/views/participant/add_participant_view/add_participant_vm.dart';

class AddParticipantView extends StatelessWidget {
  final String originalTitle;
  final int index;
  const AddParticipantView(
      {super.key, required this.originalTitle, required this.index});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AddParticipantVM(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 58, 57, 57),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              'Add Participant',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.,
              children: [
                40.verticalSpace,
                GestureDetector(
                  onTap: () async {
                    // Logic to pick an image and upload it
                    viewModel.file = await ImageHelperService().pickImage();
                    if (viewModel.file == null) {
                      return;
                    }
                    viewModel.url = await UploadImageApi().upload(
                        File(viewModel.file!.path), "${viewModel.file!.name}");
                    viewModel.notifyListeners();
                  },
                  child: CircleAvatar(
                    radius: 50.r,
                    backgroundColor: const Color(0xFFFF7F27),
                    child: viewModel.url == ""
                        ? const Icon(
                            Icons.add_a_photo,
                            size: 50,
                            color: Colors.white,
                          )
                        : ClipOval(
                            child: Image.network(
                              viewModel.url!,
                              width: 100.w,
                              height: 100.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
                20.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Form(
                      key: viewModel.formKey,
                      child: TextFormField(
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                        controller: viewModel.participantNameController,
                        onChanged: (value) =>
                            viewModel.participantNameController.text = value,
                        decoration: InputDecoration(
                          labelText: 'Participant Name',
                          labelStyle: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
                          }

                          for (int i = 0;
                              i <
                                  viewModel.userService.allParticipantsData!
                                      .length;) {
                            if (viewModel.userService.allParticipantsData![i]
                                    ['name'] ==
                                value) {
                              return 'Participant already exists';
                            } else {
                              i++;
                            }
                          }
                          return null;
                        },
                      )),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              viewModel.onSave(originalTitle, index);
            },
            child: const Icon(
              Icons.check,
              color: Colors.black,
            ),
          ),
        );
      },
    );
  }
}
