import 'package:exam5/Views/widgets/flutter_pin_code_widget.dart';
import 'package:flutter/material.dart';

class PageC extends StatefulWidget {
  const PageC({Key? key}) : super(key: key);

  @override
  State<PageC> createState() => _PageCState();
}

class _PageCState extends State<PageC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('C Screen',
            style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.w800)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text(
                'Skip',
                style: TextStyle(color: Colors.purple, fontSize: 17),
              ))
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Text('Set up PIN',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.w800)),
            const SizedBox(height: 20),
            const Text(
              'You can use this PIN to unlock the app.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 60),
            Expanded(
              child: PinCodeWidget(
                onFullPin: (_, __) {},
                initialPinLength: 4,
                emptyIndicatorColor: Colors.grey,
                deleteButtonColor: Colors.black,
                filledIndicatorColor: Colors.purple,
                numbersStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w600),
                buttonColor: Colors.black,
                borderSide: BorderSide(
                    color: Colors.purple.shade600, style: BorderStyle.solid),
                onChangedPin: (_) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
