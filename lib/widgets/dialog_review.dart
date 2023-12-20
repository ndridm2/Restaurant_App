import 'package:flutter/material.dart';
import '../data/enum/result_state.dart';
import '../provider/restaurant_detail_provider.dart';

class DialogReview extends StatelessWidget {
  final RestaurantDetailProvider provider;
  final String restaurantId;

  final _nameController = TextEditingController();
  final _reviewController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  DialogReview({
    super.key,
    required this.provider,
    required this.restaurantId,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      insetPadding: const EdgeInsets.all(16),
      title: const Text('Add Review'),
      titleTextStyle: Theme.of(context).textTheme.headlineSmall,
      content: Form(
        key: _formKey,
        child: SizedBox(
          width: width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  validator: (value){
                    if (value.toString().isEmpty){
                      return 'Name is not found!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _reviewController,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Review',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  validator: (value){
                    if (value.toString().isEmpty){
                      return 'Review is not found!';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),

      actionsPadding: const EdgeInsets.all(16),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            FormState? form = _formKey.currentState;

            if (form != null) {
              if(form.validate()) {
                provider
                .addReview(
                  id: restaurantId,
                  name: _nameController.text,
                  review: _reviewController.text)
                    .then((value) {
                      if(value == ResultState.succes){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Success added review'),
                          ),
                        );
                      }
                      Navigator.pop(context);
                  });
              }
            }
          },
          child: const Text(
            'Add Review',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
