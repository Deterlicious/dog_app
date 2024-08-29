import 'package:flutter/material.dart';

class CookingModeScreen extends StatefulWidget {
  final String instructions;

  const CookingModeScreen({super.key, required this.instructions});

  @override
  _CookingModeScreenState createState() => _CookingModeScreenState();
}

class _CookingModeScreenState extends State<CookingModeScreen> {
  late List<String> steps;
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    steps = widget.instructions.split('.').where((s) => s.trim().isNotEmpty).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cooking Mode'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Step ${currentStep + 1} of ${steps.length}',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              steps[currentStep],
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentStep > 0)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentStep--;
                      });
                    },
                    child: const Text("Previous"),
                  ),
                ElevatedButton(
                  onPressed: () {
                    if (currentStep < steps.length - 1) {
                      setState(() {
                        currentStep++;
                      });
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: Text(currentStep < steps.length - 1 ? "Next" : "Finish"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
