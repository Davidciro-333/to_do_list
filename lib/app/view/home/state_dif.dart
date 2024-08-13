import 'package:flutter/material.dart';

/// A stateful widget that represents a form with an email input field and a submit button.
class StateDif extends StatefulWidget {
  /// Creates a [StateDif] widget.
  const StateDif({super.key});

  /// Creates the mutable state for this widget.
  @override
  State<StateDif> createState() => _StateDifState();
}

/// The state for the [StateDif] widget.
class _StateDifState extends State<StateDif> {
  /// The email entered by the user.
  String email = '';

  /// Builds the widget tree for the stateful widget.
  ///
  /// The [context] parameter is used to look up the widget tree.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  // The main content of the page is wrapped in padding.
  body: Padding(
    padding: const EdgeInsets.all(40),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Padding around the email input field.
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: TextField(
            // Updates the email variable when the text changes.
            onChanged: (value) => email = value,
            decoration: const InputDecoration(
              // Fills the input field with white color.
              filled: true,
              fillColor: Colors.white,
              // Adds an outline border with rounded corners.
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              // Placeholder text for the input field.
              hintText: 'Email',
            ),
          ),
        ),
        // A button to submit the form.
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            // Sets the minimum size of the button.
            minimumSize: const Size(double.infinity, 50),
            // Sets the background color of the button.
            backgroundColor: Theme.of(context).colorScheme.primary,
            // Adds rounded corners to the button.
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            // Sets the text style of the button.
            textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          // The text displayed on the button.
          child: const Text('Send', style: TextStyle(color: Colors.white)),
        ),
      ],
    ),
  ),
);
  }
}