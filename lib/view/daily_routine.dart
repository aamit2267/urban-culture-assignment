import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/routine_item_model.dart';
import '../res/components/routine_item.dart';
import '../viewmodel/daily_routine_view_model.dart';

class DailyRoutine extends StatelessWidget {
  const DailyRoutine({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DailyRoutineViewModel()..fetchDailyRoutine(),
      child:
          Consumer<DailyRoutineViewModel>(builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (viewModel.errorMessage != null) {
          return Center(child: Text(viewModel.errorMessage!));
        }

        return ListView.builder(
          itemCount: viewModel.dailyRoutine!.length,
          itemBuilder: (context, index) {
            return RoutineItem(
              routineItem:
                  RoutineItemModel.fromJson(viewModel.dailyRoutine![index]),
            );
          },
        );
      }),
    );

    // return FutureBuilder(
    //     future: getData(),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //       try {
    // return ListView.builder(
    //   itemCount: snapshot.data!.length,
    //   itemBuilder: (context, index) {
    //     return RoutineItem(
    //       routineItem: RoutineItemModel.fromJson(snapshot.data![index]),
    //     );
    //           },
    //         );
    //       } catch (e) {
    //         return const Center(
    //           child: Text('Something went wrong'),
    //         );
    //       }
    //     });
  }
}
