import 'package:flutter/material.dart';
import 'package:eventell/Utils/utility.dart';

class CustomField extends StatelessWidget {
  const CustomField({
    Key key,
    @required TextEditingController controller,
    FocusNode focusTo,
    FocusNode focusOwn,
    TextInputType textInputType,
    TextInputAction textInputAction,
    @required String label,
  }) : _controller = controller, _focusTo = focusTo, _focusOwn = focusOwn, _label = label
  , _textInputType = textInputType, _textInputAction = textInputAction, super(key: key);

  final TextEditingController _controller;
  final FocusNode _focusTo;
  final FocusNode _focusOwn;
  final TextInputType _textInputType;
  final TextInputAction _textInputAction;
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
          keyboardType: _textInputType,
          focusNode: _focusOwn,
          textInputAction: _textInputAction,
          controller: _controller,
          decoration: InputDecoration(
            fillColor: Color.fromRGBO(233, 233, 233, 1),
            filled: true,
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(Sizing.borderRadiusFormText),
            ),
            contentPadding: EdgeInsets.all(15.0),
            labelText: _label,
          ),
          validator: ((val) {
            if (val.isEmpty) return 'Fill the $_label field';
          }),
          onFieldSubmitted: (value) {
            if(_focusTo != null)
              FocusScope.of(context).requestFocus(_focusTo);
          },
        ),
      ),
    );
  }
}