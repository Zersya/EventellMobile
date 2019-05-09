import 'package:flutter/material.dart';
import 'package:eventell/Utils/utility.dart';


class CustomMultiField extends StatelessWidget {
  const CustomMultiField({
    Key key,
    FocusNode focusOwn,
    @required TextEditingController controller,
    @required String label
  }) : _focusOwn = focusOwn, _controller = controller, _label = label, super(key: key);

  final FocusNode _focusOwn;
  final TextEditingController _controller;
  final String _label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Sizing.verticalPaddingForm),
      child: Material(
        elevation: Sizing.elevationField,
        borderRadius: BorderRadius.circular(Sizing.borderRadiusFormText),
        shadowColor: Colors.black54,
        child: TextFormField(
          keyboardType: TextInputType.multiline,
          maxLines: 5,
          minLines: 2,
          focusNode: _focusOwn,
          controller: _controller,
          decoration: InputDecoration(
            fillColor: Color.fromRGBO(233, 233, 233, 1),
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(Sizing.borderRadiusFormText))),
            contentPadding: EdgeInsets.all(15.0),
            labelText: _label,
          ),
          validator: (val) {
            if (val.isEmpty) return 'Fill the $_label field';
          },
        ),
      ),
    );
  }
}