// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:stacked/stacked.dart';
// // import 'package:stacked_services/stacked_services.dart';
// // import 'package:tournament_manager/app/app.router.dart';
// // import 'package:tournament_manager/views/create_matches/randomly/create_matches_vm.dart';

// // class CreateMatchesView extends StatelessWidget {
// //   final String tournamentName;
// //   final String originalTitle;
// //   final int index;
// //   const CreateMatchesView(
// //       {super.key,
// //       required this.originalTitle,
// //       required this.index,
// //       required this.tournamentName});

// //   @override
// //   Widget build(BuildContext context) {
// //     return ViewModelBuilder.reactive(
// //       viewModelBuilder: () => CreateMatchesVM(),
// //       onViewModelReady: (viewModel) => viewModel.init(originalTitle),
// //       builder: (context, viewModel, child) {
// //         return Scaffold(
// //           backgroundColor: const Color.fromARGB(255, 58, 57, 57),
// //           resizeToAvoidBottomInset: false,
// //           appBar: AppBar(
// //             iconTheme: const IconThemeData(color: Colors.white),
// //             backgroundColor: Colors.transparent,
// //             title: Text(
// //               'Create Matches',
// //               style: GoogleFonts.poppins(
// //                 color: Colors.white,
// //                 fontSize: 20.sp,
// //                 fontWeight: FontWeight.w600,
// //               ),
// //             ),
// //           ),
// //           body: Padding(
// //             padding: EdgeInsets.all(16.w),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 sectionTitle(
// //                   'Set up your Tournament',
// //                 ),
// //                 SizedBox(height: 16.h),
// //                 sectionSubtitle('Points per victory', icon: Icons.emoji_events),
// //                 Wrap(
// //                   spacing: 8.w,
// //                   runSpacing: 8.h,
// //                   children: [1, 2, 3].map((val) {
// //                     return optionButton(
// //                       label: '$val Point${val > 1 ? 's' : ''}',
// //                       selected: viewModel.pointsVictory == val,
// //                       onTap: () => viewModel.setPointsVictory(val),
// //                     );
// //                   }).toList(),
// //                 ),
// //                 SizedBox(height: 16.h),
// //                 sectionSubtitle('Points per tie', icon: Icons.drag_handle),
// //                 Wrap(
// //                   spacing: 8.w,
// //                   runSpacing: 8.h,
// //                   children: [0, 1, 2].map((val) {
// //                     return optionButton(
// //                       label: '$val Point${val != 1 ? 's' : ''}',
// //                       selected: viewModel.pointsTie == val,
// //                       onTap: () => viewModel.setPointsTie(val),
// //                     );
// //                   }).toList(),
// //                 ),
// //                 SizedBox(height: 16.h),
// //                 sectionSubtitle('Points per lose', icon: Icons.close),
// //                 Wrap(
// //                   spacing: 8.w,
// //                   runSpacing: 8.h,
// //                   children: [0, 1].map((val) {
// //                     return optionButton(
// //                       label: '$val Point${val != 1 ? 's' : ''}',
// //                       selected: viewModel.pointsLose == val,
// //                       onTap: () => viewModel.setPointsLose(val),
// //                     );
// //                   }).toList(),
// //                 ),
// //                 const Spacer(),

// //                 // const Spacer(),
// //                 generateButton(
// //                   icon: Icons.shuffle,
// //                   label: 'Generate Matches Randomly',
// //                   onTap: () {
// //                     viewModel.generateRandomly(
// //                       originalTitle,
// //                       index,
// //                       tournamentName,
// //                     );
// //                   },
// //                 ),
// //                 SizedBox(height: 12.h),
// //                 generateButton(
// //                   icon: Icons.sports_tennis,
// //                   label: 'Generate Matches Manually',
// //                   onTap: () {
// //                     viewModel.userService.matchdays = [];
// //                     SnackbarService().showSnackbar(
// //                         message: 'Match rules being added',
// //                         duration: const Duration(seconds: 2));

// //                     viewModel.addMatchRules(originalTitle);

// //                     NavigationService().replaceWithCreateMatchesManuallyView(
// //                       players: viewModel.userService.allParticipantsName,
// //                       originalTitle: originalTitle,
// //                       index: index,
// //                       tournamentName: tournamentName,
// //                     );
// //                   },
// //                 ),
// //                 SizedBox(height: 12.h),
// //               ],
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:stacked/stacked.dart';
// import 'package:stacked_services/stacked_services.dart';
// import 'package:tournament_manager/app/app.router.dart';
// import 'package:tournament_manager/views/create_matches/randomly/create_matches_vm.dart';

// class CreateMatchesView extends StatelessWidget {
//   final String tournamentName;
//   final String originalTitle;
//   final int index;
//   const CreateMatchesView(
//       {super.key,
//       required this.originalTitle,
//       required this.index,
//       required this.tournamentName});

//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder.reactive(
//       viewModelBuilder: () => CreateMatchesVM(),
//       onViewModelReady: (viewModel) => viewModel.init(originalTitle),
//       builder: (context, viewModel, child) {
//         return Scaffold(
//           backgroundColor: const Color.fromARGB(255, 58, 57, 57),
//           resizeToAvoidBottomInset: false,
//           appBar: AppBar(
//             iconTheme: const IconThemeData(color: Colors.white),
//             backgroundColor: Colors.transparent,
//             title: Text(
//               'Create Matches',
//               style: GoogleFonts.poppins(
//                 color: Colors.white,
//                 fontSize: 20.sp,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           body: Padding(
//             padding: EdgeInsets.all(16.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 sectionTitle(
//                   'Set up your Tournament',
//                 ),
//                 SizedBox(height: 16.h),

//                 sectionSubtitle('Games per Opponent Pair',
//                     icon: Icons.sports_handball),
//                 Wrap(
//                   spacing: 8.w,
//                   runSpacing: 8.h,
//                   children: [1, 2, 3, 4].map((val) {
//                     String label;
//                     switch (val) {
//                       case 1:
//                         label = '1 Game (Basic)';
//                         break;
//                       case 2:
//                         label = '2 Games (Home/Away)';
//                         break;
//                       case 3:
//                         label = '3 Games (Extreme)';
//                         break;
//                       case 4:
//                         label = '4 Games (Pro)';
//                         break;
//                       default:
//                         label = '$val Games';
//                     }
//                     return optionButton(
//                       label: label,
//                       selected: viewModel.gamesPerOpponentPair == val,
//                       onTap: () => viewModel.setGamesPerOpponentPair(val),
//                     );
//                   }).toList(),
//                 ),
//                 SizedBox(height: 16.h),

//                 // REMOVED: Max Matches Per Day section from here

//                 sectionSubtitle('Points per victory', icon: Icons.emoji_events),
//                 Wrap(
//                   spacing: 8.w,
//                   runSpacing: 8.h,
//                   children: [1, 2, 3].map((val) {
//                     return optionButton(
//                       label: '$val Point${val > 1 ? 's' : ''}',
//                       selected: viewModel.pointsVictory == val,
//                       onTap: () => viewModel.setPointsVictory(val),
//                     );
//                   }).toList(),
//                 ),
//                 SizedBox(height: 16.h),
//                 sectionSubtitle('Points per tie', icon: Icons.drag_handle),
//                 Wrap(
//                   spacing: 8.w,
//                   runSpacing: 8.h,
//                   children: [0, 1, 2].map((val) {
//                     return optionButton(
//                       label: '$val Point${val != 1 ? 's' : ''}',
//                       selected: viewModel.pointsTie == val,
//                       onTap: () => viewModel.setPointsTie(val),
//                     );
//                   }).toList(),
//                 ),
//                 SizedBox(height: 16.h),
//                 sectionSubtitle('Points per lose', icon: Icons.close),
//                 Wrap(
//                   spacing: 8.w,
//                   runSpacing: 8.h,
//                   children: [0, 1].map((val) {
//                     return optionButton(
//                       label: '$val Point${val != 1 ? 's' : ''}',
//                       selected: viewModel.pointsLose == val,
//                       onTap: () => viewModel.setPointsLose(val),
//                     );
//                   }).toList(),
//                 ),
//                 const Spacer(),

//                 generateButton(
//                   icon: Icons.shuffle,
//                   label: 'Generate Matches Randomly',
//                   onTap: () {
//                     viewModel.generateRandomly(
//                       originalTitle,
//                       index,
//                       tournamentName,
//                     );
//                   },
//                 ),
//                 SizedBox(height: 12.h),
//                 generateButton(
//                   icon: Icons.sports_tennis,
//                   label: 'Generate Matches Manually',
//                   onTap: () {
//                     viewModel.addMatchRules(originalTitle);
//                     SnackbarService().showSnackbar(
//                         message: 'Match rules being added',
//                         duration: const Duration(seconds: 2));

//                     NavigationService().replaceWithCreateMatchesManuallyView(
//                       players: viewModel.userService.allParticipantsName,
//                       originalTitle: originalTitle,
//                       index: index,
//                       tournamentName: tournamentName,
//                     );
//                   },
//                 ),
//                 SizedBox(height: 12.h),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// Widget sectionTitle(String text) {
//   return Padding(
//     padding: EdgeInsets.only(bottom: 8.h),
//     child: Text(
//       text,
//       style: GoogleFonts.poppins(
//         fontSize: 18.sp,
//         fontWeight: FontWeight.bold,
//         color: Colors.white,
//       ),
//     ),
//   );
// }

// Widget sectionSubtitle(String text, {IconData? icon}) {
//   return Padding(
//     padding: EdgeInsets.symmetric(vertical: 8.h),
//     child: Row(
//       children: [
//         if (icon != null) Icon(icon, size: 18.sp, color: Colors.white),
//         if (icon != null)
//           SizedBox(
//             width: 4.w,
//           ),
//         Text(
//           text,
//           style: GoogleFonts.poppins(
//             fontSize: 14.sp,
//             fontWeight: FontWeight.w500,
//             color: Colors.white,
//           ),
//         ),
//       ],
//     ),
//   );
// }

// Widget optionButton({
//   required String label,
//   required bool selected,
//   required VoidCallback onTap,
// }) {
//   return GestureDetector(
//     onTap: onTap,
//     child: Container(
//       padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
//       decoration: BoxDecoration(
//         color: selected ? const Color(0xFFFF7F27) : Colors.grey.shade300,
//         borderRadius: BorderRadius.circular(8.r),
//       ),
//       child: Text(
//         label,
//         style: GoogleFonts.poppins(
//           fontSize: 12.sp,
//           fontWeight: FontWeight.w500,
//           color: selected ? Colors.white : Colors.black,
//         ),
//       ),
//     ),
//   );
// }

// Widget generateButton({
//   required IconData icon,
//   required String label,
//   required VoidCallback onTap,
// }) {
//   return GestureDetector(
//     onTap: onTap,
//     child: Container(
//       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//       decoration: BoxDecoration(
//         color: const Color(0xFFFF7F27),
//         // Background color of the button
//         borderRadius: BorderRadius.circular(8.r), // Rounded corners
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black26, // Shadow to give a raised effect
//             blurRadius: 4.r,
//             offset: Offset(0, 4.h),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           // Icon
//           Container(
//             width: 36.w,
//             height: 36.w,
//             decoration: const BoxDecoration(
//               color: Colors.black, // Icon background color
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               icon,
//               color: Colors.white, // Icon color
//               size: 20.sp,
//             ),
//           ),
//           SizedBox(width: 12.w), // Spacing between icon and text
//           // Label
//           Text(
//             label,
//             style: GoogleFonts.poppins(
//               fontSize: 16.sp,
//               fontWeight: FontWeight.w600,
//               color: Colors.white, // Text color
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
// // ... (Your existing sectionTitle, sectionSubtitle, optionButton, generateButton widgets remain the same)

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tournament_manager/app/app.router.dart';
import 'package:tournament_manager/views/create_matches/randomly/create_matches_vm.dart';

class CreateMatchesView extends StatelessWidget {
  final String tournamentName;
  final String originalTitle;
  final int index;
  const CreateMatchesView(
      {super.key,
      required this.originalTitle,
      required this.index,
      required this.tournamentName});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => CreateMatchesVM(),
      onViewModelReady: (viewModel) => viewModel.init(originalTitle),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 58, 57, 57),
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.transparent,
            title: Text(
              'Create Matches',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: Stack(
            // <--- Added Stack here
            children: [
              // --- Main Content ---
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sectionTitle(
                      'Set up your Tournament',
                    ),
                    SizedBox(height: 16.h),
                    sectionSubtitle('Games per Opponent Pair',
                        icon: Icons.sports_handball),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [1, 2, 3, 4].map((val) {
                        String label;
                        switch (val) {
                          case 1:
                            label = '1 Game (Basic)';
                            break;
                          case 2:
                            label = '2 Games (Home/Away)';
                            break;
                          case 3:
                            label = '3 Games (Extreme)';
                            break;
                          case 4:
                            label = '4 Games (Pro)';
                            break;
                          default:
                            label = '$val Games';
                        }
                        return optionButton(
                          label: label,
                          selected: viewModel.gamesPerOpponentPair == val,
                          onTap: () => viewModel.setGamesPerOpponentPair(val),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16.h),
                    sectionSubtitle('Points per victory',
                        icon: Icons.emoji_events),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [1, 2, 3].map((val) {
                        return optionButton(
                          label: '$val Point${val > 1 ? 's' : ''}',
                          selected: viewModel.pointsVictory == val,
                          onTap: () => viewModel.setPointsVictory(val),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16.h),
                    sectionSubtitle('Points per tie', icon: Icons.drag_handle),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [0, 1, 2].map((val) {
                        return optionButton(
                          label: '$val Point${val != 1 ? 's' : ''}',
                          selected: viewModel.pointsTie == val,
                          onTap: () => viewModel.setPointsTie(val),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16.h),
                    sectionSubtitle('Points per lose', icon: Icons.close),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [0, 1].map((val) {
                        return optionButton(
                          label: '$val Point${val != 1 ? 's' : ''}',
                          selected: viewModel.pointsLose == val,
                          onTap: () => viewModel.setPointsLose(val),
                        );
                      }).toList(),
                    ),
                    const Spacer(),
                    generateButton(
                      icon: Icons.shuffle,
                      label: 'Generate Matches Randomly',
                      onTap: () async {
                        // Made onTap async
                        viewModel.generateRandomly(
                          // Await the async operation
                          originalTitle,
                          index,
                          tournamentName,
                        );
                      },
                    ),
                    SizedBox(height: 12.h),
                    generateButton(
                      icon: Icons.sports_tennis,
                      label: 'Generate Matches Manually',
                      onTap: () async {
                        // Made onTap async
                        // No need to clear matchdays here if it's managed by the VM's init
                        await viewModel.addMatchRules(
                            originalTitle); // Await the async operation
                        SnackbarService().showSnackbar(
                            message: 'Match rules being added',
                            duration: const Duration(seconds: 2));

                        NavigationService()
                            .replaceWithCreateMatchesManuallyView(
                          players: viewModel.userService.allParticipantsName,
                          originalTitle: originalTitle,
                          index: index,
                          tournamentName: tournamentName,
                        );
                      },
                    ),
                    SizedBox(height: 12.h),
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

// --- Helper Widgets ---

Widget sectionTitle(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.h),
    child: Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

Widget sectionSubtitle(String text, {IconData? icon}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.h),
    child: Row(
      children: [
        if (icon != null) Icon(icon, size: 18.sp, color: Colors.white),
        if (icon != null)
          SizedBox(
            width: 4.w,
          ),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

Widget optionButton({
  required String label,
  required bool selected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFFF7F27) : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: selected ? Colors.white : Colors.black,
        ),
      ),
    ),
  );
}

Widget generateButton({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFF7F27),
        // Background color of the button
        borderRadius: BorderRadius.circular(8.r), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black26, // Shadow to give a raised effect
            blurRadius: 4.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 36.w,
            height: 36.w,
            decoration: const BoxDecoration(
              color: Colors.black, // Icon background color
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white, // Icon color
              size: 20.sp,
            ),
          ),
          SizedBox(width: 12.w), // Spacing between icon and text
          // Label
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white, // Text color
            ),
          ),
        ],
      ),
    ),
  );
}
