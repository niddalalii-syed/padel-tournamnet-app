import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tournament_manager/app/app.locator.dart';
import 'package:tournament_manager/app/app.router.dart';
import 'package:tournament_manager/views/modify_matches/manually/modify_match_manually_vm.dart'; // Ensure this import is correct

class ModifyMatchesManuallyView extends StatefulWidget {
  final String originalTitle; // To identify the tournament document
  final List<String> allPlayers; // List of all players in the tournament

  const ModifyMatchesManuallyView({
    super.key,
    required this.originalTitle,
    required this.allPlayers,
  });

  @override
  State<ModifyMatchesManuallyView> createState() =>
      _ModifyMatchesManuallyViewState();
}

class _ModifyMatchesManuallyViewState extends State<ModifyMatchesManuallyView>
    with TickerProviderStateMixin {
  late ModifyMatchesManuallyVM viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = ModifyMatchesManuallyVM();
    // Pass originalTitle and allPlayers to the new VM's init
    print(
        'ModifyMatchesManuallyView: initState - widget.allPlayers = ${widget.allPlayers}'); // DEBUG PRINT
    viewModel.init(widget.originalTitle, widget.allPlayers, this);
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ModifyMatchesManuallyVM>.reactive(
      viewModelBuilder: () => viewModel,
      onViewModelReady: (model) =>
          model.loadMatches(), // Call loadMatches when VM is ready
      builder: (context, model, child) {
        // Display loading indicator while matches are being fetched
        if (model.isBusy || model.tabController == null) {
          return const Scaffold(
            backgroundColor: Color.fromARGB(255, 58, 57, 57),
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
        }

        // Display "No matches found" if matchdays list is empty after loading
        if (model.matchdays.isEmpty) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 58, 57, 57),
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: Colors.transparent,
              title: Text(
                'Modify Matches',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.check, color: Colors.white),
                  onPressed: () async {
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
                            'This will overwrite any existing matches. Do you want to proceed?',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
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
                                await model.saveMatchdays(widget.originalTitle);
                                NavigationService()
                                    .clearStackAndShow(Routes.tournamentView);
                                // }
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
                  },
                ),
              ],
            ),
            body: Center(
              child: Text(
                'No matches found for this tournament.\nAdd a new matchday to start.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white54,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
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
                onPressed: () =>
                    model.addNewMatchDay(), // Directly add new matchday
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
        }

        // Main content when matches are loaded
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 58, 57, 57),
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.transparent,
            title: Text(
              'Modify Matches',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.check, color: Colors.white),
                onPressed: () async {
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
                          'This will overwrite any existing matches. Do you want to proceed?',
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
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
                              SnackbarService().showSnackbar(
                                message: 'Updating matchdays...',
                                duration: const Duration(seconds: 2),
                              );
                              await model.saveMatchdays(widget.originalTitle);
                              // Make sure NavigationService is also initialized via locator
                              locator<NavigationService>()
                                  .clearStackAndShow(Routes.tournamentView);
                              // }
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
