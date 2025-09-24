// ignore_for_file: unnecessary_string_interpolations

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tournament_manager/service/image_picker.dart';
import 'package:tournament_manager/service/upload_images.dart';
import 'package:tournament_manager/views/all_participants/add_participant_view/add_participant_vm.dart';

class AddtoAllParticipantView extends StatelessWidget {
  const AddtoAllParticipantView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AddtoAllParticipantVM(),
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
            child: Stack(
              children: [
                Column(
                  // mainAxisAlignment: MainAxisAlignment.,
                  children: [
                    40.verticalSpace,
                    GestureDetector(
                      onTap: () async {
                        viewModel.setBusy(true);
                        // Logic to pick an image and upload it
                        viewModel.file = await ImageHelperService().pickImage();
                        if (viewModel.file == null) {
                          return;
                        }
                        SnackbarService().showSnackbar(
                          message: "Image Being Uploaded",
                          title: "Please Wait....",
                          duration: const Duration(seconds: 2),
                        );
                        viewModel.url = await UploadImageApi().upload(
                            File(viewModel.file!.path),
                            "${viewModel.file!.name}");

                        if (viewModel.url == null) {
                          SnackbarService().showSnackbar(
                            message: "Image Upload Failed",
                            title: "Error",
                            duration: const Duration(seconds: 2),
                          );
                          return;
                        } else {
                          SnackbarService().showSnackbar(
                            message: "Image Uploaded Successfully",
                            title: "Success",
                            duration: const Duration(seconds: 2),
                          );
                        }
                        viewModel.setBusy(false);

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
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child; // Image loaded successfully
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null, // Show progress if total bytes known
                                      ),
                                    );
                                  },
                                  errorBuilder: (BuildContext context,
                                      Object error, StackTrace? stackTrace) {
                                    return Center(
                                      child: Icon(
                                        Icons.broken_image,
                                        size: 50.w,
                                        color: Colors.grey,
                                      ),
                                    );
                                  },
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
                            onChanged: (value) => viewModel
                                .participantNameController.text = value,
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

                              if (viewModel.userService.allParticipantsData !=
                                  null) {
                                for (int i = 0;
                                    i <
                                        viewModel.userService
                                            .allParticipantsData!.length;
                                    i++) {
                                  if (viewModel.userService
                                          .allParticipantsData![i]['name'] ==
                                      value) {
                                    return 'Participant already exists';
                                  }
                                }
                              }

                              return null;
                            },
                          )),
                    ),
                  ],
                ),
                if (viewModel.isBusy) // Conditionally show the overlay
                  Container(
                    color: Colors.black
                        .withOpacity(0.5), // Semi-transparent black background
                    child: const Center(
                      child: CircularProgressIndicator(
                        // Your loading indicator
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFFFF7F27)), // Customize color
                      ),
                    ),
                  ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              viewModel.onSave();
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
