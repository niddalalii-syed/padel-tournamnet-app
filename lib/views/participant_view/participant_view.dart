// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:stacked/stacked.dart';
// import 'package:stacked_services/stacked_services.dart';
// import 'package:tournament_manager/views/participant_view/participant_vm.dart';

// class ParticipantView extends StatelessWidget {
//   final String originalTitle;
//   final int index;
//   const ParticipantView(
//       {super.key, required this.originalTitle, required this.index});

//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder.reactive(
//         viewModelBuilder: () => ParticipantVM(),
//         onViewModelReady: (viewModel) => viewModel.init(originalTitle),
//         builder: (context, viewModel, child) {
//           return Scaffold(
//             backgroundColor: const Color.fromARGB(255, 58, 57, 57),
//             appBar: AppBar(
//               backgroundColor: Colors.transparent,
//               title: Text(
//                 'Paricipants (${viewModel.participantNames!.length})',
//                 style: GoogleFonts.poppins(
//                   color: Colors.white,
//                   fontSize: 20.sp,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               actions: [
//                 if (viewModel.matches == 0)
//                   IconButton(
//                     icon: const Icon(Icons.check, color: Colors.white),
//                     onPressed: () {
//                       if (viewModel.participantNames!.isEmpty ||
//                           viewModel.participantNames!.length < 2) {
//                         SnackbarService().showSnackbar(
//                           title: 'Error',
//                           message:
//                               'Please atleast 2 participants to create a tournament',
//                           duration: const Duration(seconds: 2),
//                         );
//                       } else {
//                         viewModel.addParticipantToDB(originalTitle);
//                       }
//                     },
//                   ),
//               ],
//             ),
//             body: Center(
//               child: Column(
//                 children: [
//                   if (viewModel.participantNames!.isNotEmpty)
//                     Expanded(
//                       child: ListView.builder(
//                         scrollDirection: Axis.vertical,
//                         itemCount: viewModel.participantNames!.length,
//                         itemBuilder: (context, index) {
//                           final participant =
//                               viewModel.participantNames![index];
//                           return playerTile(
//                             imageUrl: participant['imageUrl'] ?? '',
//                             participantName: participant['name'] ?? '',
//                             onTap: () {
//                               if (viewModel.matches == 0) {
//                                 showDialog(
//                                   context: context,
//                                   builder: (context) {
//                                     return AlertDialog(
//                                       title: Text(
//                                         'Are you sure?',
//                                         style: GoogleFonts.poppins(
//                                           fontSize: 18.sp,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                       content: Text(
//                                         "Are you sure you want to remove ${participant['name']}?",
//                                         style: GoogleFonts.poppins(
//                                           fontSize: 14.sp,
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                       ),
//                                       actions: [
//                                         TextButton(
//                                           onPressed: () =>
//                                               Navigator.of(context).pop(),
//                                           child: Text(
//                                             'Cancel',
//                                             style: GoogleFonts.poppins(
//                                               color: Colors.red,
//                                               fontSize: 14.sp,
//                                             ),
//                                           ),
//                                         ),
//                                         TextButton(
//                                           onPressed: () async {
//                                             Navigator.of(context).pop();
//                                             viewModel.removeParticipant(
//                                                 participant, originalTitle);
//                                             SnackbarService().showSnackbar(
//                                               message:
//                                                   "${participant['name']} has been removed.",
//                                               duration:
//                                                   const Duration(seconds: 1),
//                                             );
//                                           },
//                                           child: Text(
//                                             'Yes',
//                                             style: GoogleFonts.poppins(
//                                               color: Colors.green,
//                                               fontSize: 14.sp,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     );
//                                   },
//                                 );
//                               } else {
//                                 SnackbarService().showSnackbar(
//                                   message:
//                                       "You cannot remove participants after matches have started.",
//                                   duration: const Duration(seconds: 2),
//                                 );
//                               }
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                   if (viewModel.userService.allParticipantsData!.isNotEmpty &&
//                       viewModel.participantNames!.length < 20 &&
//                       viewModel.matches == 0)
//                     Expanded(
//                       child: Container(
//                         color: Colors.black.withOpacity(0.5),
//                         child: ListView.builder(
//                           scrollDirection: Axis.vertical,
//                           itemCount:
//                               viewModel.userService.allParticipantsData!.length,
//                           itemBuilder: (context, index) {
//                             final participant = viewModel
//                                 .userService.allParticipantsData![index];
//                             return playerTile(
//                               imageUrl: participant['imageUrl'] ?? '',
//                               participantName: participant['name'] ?? '',
//                               onTap: () {
//                                 if (viewModel.matches == 0) {
//                                   if (viewModel.participantNames!.length < 20) {
//                                     viewModel.addParticipant(participant);
//                                   } else {
//                                     SnackbarService().showSnackbar(
//                                       message:
//                                           "You cannot add more than 20 participants.",
//                                       duration: const Duration(seconds: 2),
//                                     );
//                                   }
//                                 } else {
//                                   SnackbarService().showSnackbar(
//                                     message:
//                                         "You cannot add participants after matches have started.",
//                                     duration: const Duration(seconds: 2),
//                                   );
//                                 }
//                               },
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }
// }

// Widget addTile({
//   required IconData icon,
//   required String title,
//   required String subtitle,
//   required VoidCallback onTap,
// }) {
//   return ListTile(
//     contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//     leading: Container(
//       width: 40.w,
//       height: 40.h,
//       decoration: BoxDecoration(
//         color: const Color(0xFFFF7F27),
//         borderRadius: BorderRadius.circular(20.r),
//       ),
//       child: Icon(
//         icon,
//         color: Colors.white,
//         size: 24.sp,
//       ),
//     ),
//     title: Text(
//       title,
//       style: GoogleFonts.poppins(
//         fontSize: 16.sp,
//         fontWeight: FontWeight.w600,
//         color: Colors.white,
//       ),
//     ),
//     subtitle: Text(
//       subtitle,
//       style: GoogleFonts.poppins(
//         fontSize: 12.sp,
//         color: Colors.grey,
//       ),
//     ),
//     onTap: onTap,
//   );
// }

// Widget playerTile({
//   required String imageUrl,
//   required String participantName,
//   required VoidCallback onTap,
// }) {
//   return ListTile(
//     contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//     leading: Container(
//       width: 40.w,
//       height: 40.h,
//       decoration: BoxDecoration(
//         color: Colors.blueAccent.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(20.r),
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20.r),
//         child: imageUrl.isNotEmpty
//             ? Image.network(
//                 imageUrl,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) {
//                   return Icon(Icons.person,
//                       color: const Color(0xFFFF7F27), size: 24.sp);
//                 },
//               )
//             : Icon(Icons.person, color: const Color(0xFFFF7F27), size: 24.sp),
//       ),
//     ),
//     title: Text(
//       participantName,
//       style: GoogleFonts.poppins(
//         fontSize: 16.sp,
//         fontWeight: FontWeight.w600,
//         color: Colors.white,
//       ),
//     ),
//     onTap: onTap,
//   );
// }

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tournament_manager/views/participant_view/participant_vm.dart';

class ParticipantView extends StatelessWidget {
  final String originalTitle;
  final int index;
  const ParticipantView(
      {super.key, required this.originalTitle, required this.index});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => ParticipantVM(),
      onViewModelReady: (viewModel) => viewModel.init(originalTitle),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 58, 57, 57),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(
                color: Colors.white), // Ensure back button is white
            title: Text(
              'Participants (${viewModel.participantNames?.length ?? 0})', // Use null-aware operator
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              if (viewModel.matches == 0)
                IconButton(
                  icon: const Icon(Icons.check, color: Colors.white),
                  onPressed: () {
                    // Use null-aware operator for participantNames
                    if (viewModel.participantNames == null ||
                        viewModel.participantNames!.length < 2) {
                      SnackbarService().showSnackbar(
                        title: 'Error',
                        message:
                            'Please add at least 2 participants to create a tournament',
                        duration: const Duration(seconds: 2),
                      );
                    } else {
                      viewModel.addParticipantToDB(originalTitle);
                    }
                  },
                ),
            ],
          ),
          body: Stack(
            // Use a Stack to layer content and the overlay
            children: [
              // --- Main Content ---
              Center(
                child: Column(
                  children: [
                    // Use null-aware operator for participantNames
                    if (viewModel.participantNames != null &&
                        viewModel.participantNames!.isNotEmpty)
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: viewModel.participantNames!.length,
                          itemBuilder: (context, index) {
                            final participant =
                                viewModel.participantNames![index];
                            return playerTile(
                              imageUrl: participant['imageUrl'] ?? '',
                              participantName: participant['name'] ?? '',
                              onTap: () {
                                if (viewModel.matches == 0) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Are you sure?',
                                          style: GoogleFonts.poppins(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        content: Text(
                                          "Are you sure you want to remove ${participant['name']}?",
                                          style: GoogleFonts.poppins(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: Text(
                                              'Cancel',
                                              style: GoogleFonts.poppins(
                                                color: Colors.red,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              Navigator.of(context).pop();
                                              await viewModel.removeParticipant(
                                                  participant,
                                                  originalTitle); // Use await
                                              // SnackbarService().showSnackbar(
                                              //   message:
                                              //       "${participant['name']} has been removed.",
                                              //   duration:
                                              //       const Duration(seconds: 1),
                                              // );
                                            },
                                            child: Text(
                                              'Yes',
                                              style: GoogleFonts.poppins(
                                                color: Colors.green,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  SnackbarService().showSnackbar(
                                    message:
                                        "You cannot remove participants after matches have started.",
                                    duration: const Duration(seconds: 2),
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ),
                    // Use null-aware operator for userService.allParticipantsData
                    if (viewModel.userService.allParticipantsData != null &&
                        viewModel.userService.allParticipantsData!.isNotEmpty &&
                        (viewModel.participantNames?.length ?? 0) <
                            20 && // Use null-aware for participantNames
                        viewModel.matches == 0)
                      Expanded(
                        child: Container(
                          color: Colors.black.withOpacity(0.5),
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: viewModel
                                .userService.allParticipantsData!.length,
                            itemBuilder: (context, index) {
                              final participant = viewModel
                                  .userService.allParticipantsData![index];
                              return playerTile(
                                imageUrl: participant['imageUrl'] ?? '',
                                participantName: participant['name'] ?? '',
                                onTap: () {
                                  if (viewModel.matches == 0) {
                                    if ((viewModel.participantNames?.length ??
                                            0) <
                                        20) {
                                      // Use null-aware
                                      viewModel.addParticipant(participant);
                                    } else {
                                      SnackbarService().showSnackbar(
                                        message:
                                            "You cannot add more than 20 participants.",
                                        duration: const Duration(seconds: 2),
                                      );
                                    }
                                  } else {
                                    SnackbarService().showSnackbar(
                                      message:
                                          "You cannot add participants after matches have started.",
                                      duration: const Duration(seconds: 2),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // --- Loading Overlay ---
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
        );
      },
    );
  }
}

Widget addTile({
  required IconData icon,
  required String title,
  required String subtitle,
  required VoidCallback onTap,
}) {
  return ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    leading: Container(
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        color: const Color(0xFFFF7F27),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 24.sp,
      ),
    ),
    title: Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    subtitle: Text(
      subtitle,
      style: GoogleFonts.poppins(
        fontSize: 12.sp,
        color: Colors.grey,
      ),
    ),
    onTap: onTap,
  );
}

Widget playerTile({
  required String imageUrl,
  required String participantName,
  required VoidCallback onTap,
}) {
  return ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    leading: Container(
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: imageUrl.isNotEmpty
            ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.person,
                      color: const Color(0xFFFF7F27), size: 24.sp);
                },
              )
            : Icon(Icons.person, color: const Color(0xFFFF7F27), size: 24.sp),
      ),
    ),
    title: Text(
      participantName,
      style: GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    onTap: onTap,
  );
}
