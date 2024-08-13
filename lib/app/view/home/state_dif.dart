import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// A stateful widget that represents a form with an email input field and a submit button.
class StateDif extends StatelessWidget {
  /// Creates a [StateDif] widget.
  const StateDif({super.key});

  /// Builds the widget tree for the stateful widget.
  ///
  /// The [context] parameter is used to look up the widget tree.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _EmailDisplay(),
      child: const Scaffold(
        // The main content of the page is wrapped in padding.
        body: Padding(
          padding: EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Padding around the email input field.
              _EmailTextField(),

              /// A button to submit the form.
              _SendButton(),

              /// A text widget that displays the email written in the input field.
              _EmailText(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailText extends StatelessWidget {
  const _EmailText();

  @override
  Widget build(BuildContext context) {
    return Consumer<_EmailDisplay>(builder: (_, emailDisplay, child) {
      return Text(
          'Email written in the text field will be displayed here ${emailDisplay.email}');
    });

    /// Retrieves the email from the inherited widget.
  }
}

class _SendButton extends StatelessWidget {
  const _SendButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        /// Sets the minimum size of the button.
        minimumSize: const Size(double.infinity, 50),

        /// Sets the background color of the button.
        backgroundColor: Theme.of(context).colorScheme.primary,

        /// Adds rounded corners to the button.
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),

        /// Sets the text style of the button.
        textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
      ),

      /// The text displayed on the button.
      child: const Text('Send', style: TextStyle(color: Colors.white)),
    );
  }
}

class _EmailTextField extends StatelessWidget {
  const _EmailTextField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextField(
        /// Updates the email variable when the text changes.
        onChanged: (value) => context.read<_EmailDisplay>().email = value,
        decoration: const InputDecoration(
          /// Fills the input field with white color.
          filled: true,
          fillColor: Colors.white,

          /// Adds an outline border with rounded corners.
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),

          /// Placeholder text for the input field.
          hintText: 'Email',
        ),
      ),
    );
  }
}

class _EmailDisplay extends ChangeNotifier {
  String _email = '';

  String get email => _email;

  set email(String value) {
    _email = value;
    notifyListeners();
  }
}