// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:stacked/stacked.dart';
// import 'package:stacked_services/stacked_services.dart';
// import 'package:tournament_manager/app/app.router.dart';
// import 'package:tournament_manager/views/create_matches/manually/create_metches_manually_vm.dart';

// class CreateMatchesManuallyView extends StatefulWidget {
//   final List<String> players;
//   final String originalTitle;
//   final String tournamentName;
//   final int index;
//   const CreateMatchesManuallyView({
//     super.key,
//     required this.players,
//     required this.originalTitle,
//     required this.tournamentName,
//     required this.index,
//   });

//   @override
//   State<CreateMatchesManuallyView> createState() =>
//       _CreateMatchesManuallyViewState();
// }

// class _CreateMatchesManuallyViewState extends State<CreateMatchesManuallyView>
//     with TickerProviderStateMixin {
//   late CreateMatchesManuallyVM viewModel;

//   @override
//   void initState() {
//     super.initState();
//     viewModel = CreateMatchesManuallyVM();
//     viewModel.init(widget.players, this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<CreateMatchesManuallyVM>.reactive(
//       viewModelBuilder: () => viewModel,
//       builder: (context, model, child) {
//         return model.tabController == null
//             ? const Scaffold(
//                 backgroundColor: Color.fromARGB(255, 58, 57, 57),
//                 body: Center(
//                   child: CircularProgressIndicator(
//                     color: Colors.white,
//                   ),
//                 ),
//               )
//             : Scaffold(
//                 backgroundColor: const Color.fromARGB(255, 58, 57, 57),
//                 appBar: AppBar(
//                   iconTheme: const IconThemeData(color: Colors.white),
//                   backgroundColor: Colors.transparent,
//                   title: Text(
//                     'Create Matchday',
//                     style: GoogleFonts.poppins(
//                       color: Colors.white,
//                       fontSize: 20.sp,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   actions: [
//                     IconButton(
//                       icon: const Icon(Icons.check, color: Colors.white),
//                       onPressed: () async {
//                         await model.saveMatchdays(widget.originalTitle);
//                         NavigationService()
//                             .clearStackAndShow(Routes.tournamentView);
//                       },
//                     ),
//                   ],
//                   bottom: TabBar(
//                     labelColor: Colors.white,
//                     unselectedLabelColor: Colors.grey,
//                     indicatorColor: const Color(0xFFFF7F27),
//                     controller: model.tabController,
//                     isScrollable: true,
//                     tabs: List.generate(
//                       model.matchdays.length,
//                       (index) => Tab(text: 'Matchday ${index + 1}'),
//                     ),
//                   ),
//                 ),
//                 body: TabBarView(
//                   controller: model.tabController,
//                   children: List.generate(model.matchdays.length, (index) {
//                     final matchday = model.matchdays[index];
//                     return Padding(
//                       padding: EdgeInsets.symmetric(
//                           horizontal: 16.w, vertical: 10.h),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Matches (${matchday['matches'].length}):',
//                             style: GoogleFonts.poppins(
//                               color: Colors.white,
//                               fontSize: 18.sp,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           SizedBox(height: 10.h),
//                           for (int i = 0; i < matchday['matches'].length; i++)
//                             Card(
//                               // ignore: deprecated_member_use
//                               color: Colors.grey.withOpacity(0.3),
//                               child: ListTile(
//                                 title: Text(
//                                   '${matchday['matches'][i]['player1']} vs ${matchday['matches'][i]['player2']}',
//                                   style: GoogleFonts.poppins(
//                                     color: Colors.white,
//                                     fontSize: 16.sp,
//                                   ),
//                                 ),
//                                 // Edit and delete icons are always displayed as all matchdays are editable
//                                 trailing: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     IconButton(
//                                       icon: const Icon(Icons.edit,
//                                           color: Color(0xFFFF7F27)),
//                                       onPressed: () => model.editMatch(i),
//                                     ),
//                                     IconButton(
//                                       icon: const Icon(Icons.delete,
//                                           color: Colors.red),
//                                       onPressed: () => model.deleteMatch(i),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           // Display player selection or informative messages based on matchday state
//                           if (model.canAddMoreMatchesToCurrentDay() &&
//                               model.players.isNotEmpty) ...[
//                             if (model.selectedPlayers.length == 1)
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   'Selected: ${model.selectedPlayers[0]} (waiting for opponent)',
//                                   style: GoogleFonts.poppins(
//                                     color: Colors.white,
//                                     fontSize: 16.sp,
//                                   ),
//                                 ),
//                               ),
//                             10.verticalSpace,
//                             const Divider(),
//                             Expanded(
//                               child: ListView.builder(
//                                 itemCount: model.players.length,
//                                 itemBuilder: (context, index) {
//                                   final player = model.players[index];
//                                   return Column(
//                                     children: [
//                                       ListTile(
//                                         onTap: () => model.selectPlayer(player),
//                                         title: Text(player,
//                                             style: GoogleFonts.poppins(
//                                               color: Colors.white,
//                                               fontSize: 16.sp,
//                                             )),
//                                         tileColor: Colors.grey.withOpacity(0.3),
//                                       ),
//                                       const Divider(),
//                                     ],
//                                   );
//                                 },
//                               ),
//                             ),
//                           ] else if (model.canAddMoreMatchesToCurrentDay() &&
//                               model.players.isEmpty)
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 'All available players are currently in matches for this day.',
//                                 style: GoogleFonts.poppins(
//                                   color: Colors.white54,
//                                   fontSize: 14.sp,
//                                 ),
//                               ),
//                             )
//                           else if (!model.canAddMoreMatchesToCurrentDay())
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 'Match limit reached for this matchday. Add a new matchday or edit existing matches.',
//                                 style: GoogleFonts.poppins(
//                                   color: Colors.white54,
//                                   fontSize: 14.sp,
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),
//                     );
//                   }),
//                 ),
//                 bottomNavigationBar: Padding(
//                   padding:
//                       EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFFFF7F27),
//                       padding: EdgeInsets.symmetric(vertical: 15.h),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.r),
//                       ),
//                     ),
//                     onPressed: () => model.addNewMatchDayWithConfirmation(),
//                     child: Text(
//                       'Add New Matchday',
//                       style: GoogleFonts.poppins(
//                         color: Colors.white,
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tournament_manager/app/app.router.dart';
import 'package:tournament_manager/views/create_matches/manually/create_metches_manually_vm.dart'; // Typo in filename: create_metches_manually_vm.dart -> create_matches_manually_vm.dart

class CreateMatchesManuallyView extends StatefulWidget {
  final List<String> players;
  final String originalTitle;
  final String tournamentName;
  final int index;
  const CreateMatchesManuallyView({
    super.key,
    required this.players,
    required this.originalTitle,
    required this.tournamentName,
    required this.index,
  });

  @override
  State<CreateMatchesManuallyView> createState() =>
      _CreateMatchesManuallyViewState();
}

class _CreateMatchesManuallyViewState extends State<CreateMatchesManuallyView>
    with TickerProviderStateMixin {
  late CreateMatchesManuallyVM viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = CreateMatchesManuallyVM();
    // Pass 'this' as TickerProviderStateMixin for TabController
    viewModel.init(widget.players, this);
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateMatchesManuallyVM>.reactive(
      viewModelBuilder: () => viewModel,
      builder: (context, model, child) {
        // Show loading indicator if tabController is not yet initialized
        if (model.tabController == null) {
          return const Scaffold(
            backgroundColor: Color.fromARGB(255, 58, 57, 57),
            body: Center(
              child: CircularProgressIndicator(
                color: Color(0xFFFF7F27), // Use your theme color
              ),
            ),
          );
        }

        // Main Scaffold content once tabController is ready
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 58, 57, 57),
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.transparent,
            title: Text(
              'Create Matchday',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              IconButton(
                icon: model.isBusy // Show different icon or disable when busy
                    ? const SizedBox(
                        width: 24, // Sized to fit typically sized icon
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth:
                              2, // Thinner stroke for smaller indicator
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Icon(Icons.check, color: Colors.white),
                onPressed: model.isBusy // Disable button when busy
                    ? null
                    : () async {
                        await model.saveMatchdays(widget.originalTitle);
                        // Only navigate if save was successful and not busy
                        if (!model.isBusy) {
                          NavigationService()
                              .clearStackAndShow(Routes.tournamentView);
                        }
                      },
              ),
            ],
            bottom: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              indicatorColor: const Color(0xFFFF7F27),
              controller: model.tabController,
              isScrollable: true,
              tabs: List.generate(
                model.matchdays.length,
                (index) => Tab(text: 'Matchday ${index + 1}'),
              ),
            ),
          ),
          body: Stack(
            // Use Stack for loading overlay
            children: [
              TabBarView(
                controller: model.tabController,
                children: List.generate(model.matchdays.length, (index) {
                  final matchday = model.matchdays[index];
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Matches (${(matchday['matches'] as List).length}):', // Cast to List
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        // Expanded for the matches list
                        Expanded(
                          flex: 3, // Give more space to matches list
                          child: (matchday['matches'] as List)
                                  .isEmpty // Cast to List
                              ? Center(
                                  child: Text(
                                    'No matches added yet for this day.',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white54,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: (matchday['matches'] as List)
                                      .length, // Cast to List
                                  itemBuilder: (context, i) {
                                    final match = matchday['matches'][i];
                                    return Card(
                                      color: Colors.grey.withOpacity(0.3),
                                      margin:
                                          EdgeInsets.symmetric(vertical: 4.h),
                                      child: ListTile(
                                        title: Text(
                                          '${match['player1']} vs ${match['player2']}',
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.edit,
                                                  color: Color(0xFFFF7F27)),
                                              onPressed: () =>
                                                  model.editMatch(i),
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete,
                                                  color: Colors.red),
                                              onPressed: () =>
                                                  model.deleteMatch(i),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ),
                        SizedBox(height: 20.h), // Consistent gap

                        Text(
                          'Available Players:',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10.h),

                        // Conditional display for player selection/messages
                        if (model.canAddMoreMatchesToCurrentDay()) ...[
                          if (model.selectedPlayers.length == 1)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Text(
                                'Selected: ${model.selectedPlayers[0]} (pick opponent)',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          // Expanded for the players list
                          Expanded(
                            flex:
                                2, // Give less space than matches, adjust as needed
                            child: model.players.isEmpty &&
                                    model.selectedPlayers.isEmpty
                                ? Center(
                                    child: Text(
                                      'No available players for new matches on this day.',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white54,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: model.players.length,
                                    itemBuilder: (context, idx) {
                                      final player = model.players[idx];
                                      return Column(
                                        children: [
                                          ListTile(
                                            onTap: () =>
                                                model.selectPlayer(player),
                                            title: Text(player,
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 16.sp,
                                                )),
                                            tileColor:
                                                Colors.grey.withOpacity(0.3),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.r)),
                                          ),
                                          SizedBox(
                                              height: 4
                                                  .h), // Small gap between player tiles
                                        ],
                                      );
                                    },
                                  ),
                          ),
                        ] else // If cannot add more matches, display a message
                          Expanded(
                            // Wrap message in Expanded to fill space
                            flex: 2,
                            child: Center(
                              child: Text(
                                'Match limit reached for this matchday. Add a new matchday or edit existing matches.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  color: Colors.white54,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                }),
              ),

              // Loading Overlay (copied from previous solution)
              if (model.isBusy)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xFFFF7F27)),
                    ),
                  ),
                ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF7F27),
                padding: EdgeInsets.symmetric(vertical: 15.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              onPressed: model.isBusy // Disable button when busy
                  ? null
                  : () => model.addNewMatchDayWithConfirmation(context),
              child: Text(
                'Add New Matchday',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // Dispose the TabController when the widget is disposed
    viewModel.tabController?.dispose();
    super.dispose();
  }
}
