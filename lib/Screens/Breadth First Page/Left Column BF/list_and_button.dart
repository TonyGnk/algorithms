// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Algorithms/Breadth First/start_calculation.dart';
import '../../../Services & Providers/constants.dart';
import '../Services/List Panel/list_provider.dart';

class TrackingListClass extends StatefulWidget {
  const TrackingListClass({required this.ref, super.key});

  final WidgetRef ref;

  @override
  State<TrackingListClass> createState() => _TrackingListState();
}

class _TrackingListState extends State<TrackingListClass> {
  @override
  void initState() {
    super.initState();
    //In first time the widget will run a calculation function
    startCalR(widget.ref);
  }

  @override
  Widget build(BuildContext context) => trackingListConsumerBF();
}

// This is the left container displaying the tracking tiles.
Widget trackingListConsumerBF() => Consumer(builder: (context, ref, _) {
      final trackingList = ref.watch(trackingListProvider);
      final tr1 = ref.watch(trackUpdater);
      final isCreating = ref.watch(isCreatingProvider);
      return trackingList.build(context);
    });

//Button Area
Widget buttonArea(BuildContext context) => Consumer(
    builder: (context, ref, _) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(cornerSize - 1),
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Επαναφορά',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    ref.watch(isCreatingProvider.notifier).state = true;
                  },
                  child: const Text(
                    'Εκτέλεση',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
