import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Algorithms/Breadth First/providers_bf.dart';
import '../../Services & Providers/constants.dart';
import '../../Services & Providers/node.dart';
import '../../Services & Providers/six_calculations.dart';
import '../../Services & Providers/text_editor_provider.dart';
import '../Breadth First Page/Archive BF/list_provider.dart';
import 'text_viewer.dart';

TextEditingController controller = TextEditingController();

Widget terminalSide(BuildContext context) {
  TerminalViewer te = const TerminalViewer();

  return Consumer(
      builder: (_, WidgetRef ref, __) => Column(
            children: [
              terminalTitle(context),
              Text('Press F12 for Reasults',
                  style: TextStyle(
                    fontFamily: 'AdventoPro',
                    fontSize: 17,
                  )),
              const SizedBox(height: 14),
              //te,
              //const SizedBox(height: 20),
              Expanded(
                child: textField(),
              ),
              //const Expanded(child: SizedBox()),
            ],
          ));
}

//Create a large nice text terminalTitle
terminalTitle(BuildContext context) => const Text(
      'Terminal',
      style: TextStyle(
        fontSize: 26,
        fontFamily: 'AdventoPro',
      ),
    );

textField() => Consumer(
      builder: (context, WidgetRef ref, __) => Container(
        decoration: boxDecoration(context),
        child: SelectionArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              terminalText(windowsText),
              TextField(
                autofocus: true,
                autocorrect: false,
                showCursor: true,
                expands: false,
                // minLines: null,
                // maxLines: null,
                style: const TextStyle(
                  fontFamily: 'Consolas',
                  fontSize: 16,
                ),
                //textAlignVertical: TextAlignVertical.bottom,
                controller: ref.watch(controllerProvider),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                onSubmitted: (value) {
                  ref.read(textProvider.notifier).state = value;
                  analyzeTheText(ref);
                  addText(value, ref);
                  //controller.clear();
                },
              ),
              Expanded(
                child: const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );

boxDecoration(BuildContext context) => BoxDecoration(
      color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
      border: Border.all(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
      ),
      borderRadius: BorderRadius.circular(14),
    );

//provider for controller
final controllerProvider = StateProvider<TextEditingController>(
    (ref) => TextEditingController(text: 'C:WindowsSystem32> '));

//  terminalText() Get a String and returns a Text with consolas font
terminalText(String text) => Text(
      text,
      style: const TextStyle(
        fontFamily: 'Consolas',
        fontSize: 16,
      ),
    );

String windowsText =
    'Microsoft Windows [Version 10.0.19042.1165]\n(c) Microsoft Corporation. All rights reserved';

Future<void> analyzeTheText(WidgetRef ref) async {
  final text = ref.watch(textProvider);
  List<String> words = text.split(' ');
  if (words[0] == 'C:WindowsSystem32>') words.removeAt(0);

  if (words.length == 4) {
    String register = words[0];
    String algorithm = words[1];
    int integer1 = int.parse(words[2]);
    int integer2 = int.parse(words[3]);
    print(
      'Register: $register Algorithm: $algorithm Int1: $integer1 Int2: $integer2',
    );

    AlgorithmType type = findType(algorithm);

    ref.watch(runningRequestProvider.notifier).state = running(
      ref,
      integer1,
      integer2,
    );

    //Start the selected algorithm
    ref.read(isAlgorithmEndProviderBf.notifier).state = false; //Started
    List<Node>? solution = await startAlgorithm(ref, type);
    ref.read(isAlgorithmEndProviderBf.notifier).state = true; //Finished

    //Print the solution
    for (Node node in solution!) {
      print(node.value.toString() + ' ' + node.operation.toString());
    }
  }
}

running(WidgetRef ref, int startValue, int targetValue) => RunningRequest(
      startValue: startValue,
      targetValue: targetValue,
      speed: 0,
      enabledOperations: {
        CalculationType.addition: true,
        CalculationType.subtraction: true,
        CalculationType.multiplication: true,
        CalculationType.division: true,
        CalculationType.exponential: true,
        CalculationType.square: true,
      },
    );

//Find type
AlgorithmType findType(String algorithm) {
  switch (algorithm) {
    case 'breadth':
      return AlgorithmType.bf;
    case 'depth':
      return AlgorithmType.df;
    case 'best':
      return AlgorithmType.bestf;
    case 'a*':
      return AlgorithmType.astar;
    default:
      return AlgorithmType.bf;
  }
}
