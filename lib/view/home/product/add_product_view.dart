import 'package:flutter/material.dart';
import 'package:onurun/product/widget/textformfield/custom_text_form_field.dart';
import 'package:onurun/services/cloudfirestore/product/product-service.dart';

class AppProductView extends StatefulWidget {
  const AppProductView({Key? key}) : super(key: key);

  @override
  State<AppProductView> createState() => AppProductViewState();
}

class AppProductViewState extends State<AppProductView> {
  var formKey = GlobalKey<FormState>();

  late final TextEditingController productNameController;
  late final TextEditingController productDescriptionController;

  @override
  void initState() {
    productNameController = TextEditingController();
    productDescriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    productNameController.dispose();
    productDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AppProduct',
          style: TextStyle(color: Colors.red),
        ),
      ),
      body: Scaffold(
        body: Form(
          key: formKey,
          child: Column(
            children: [
              CustomTextFormField(
                controller: productNameController,
                labelText: 'name',
                prefix: const Icon(
                  Icons.production_quantity_limits,
                ),
              ),
              CustomTextFormField(
                  line: 4,
                  controller: productDescriptionController,
                  labelText: 'description',
                  prefix: const SizedBox.shrink()),
              ElevatedButton(
                onPressed: () {
                  ProductCloudFireStoreService.instance.addProduct(
                    productName: productNameController.text,
                    productDescription: productDescriptionController.text,
                  );
                  Navigator.of(context).pop();
                },
                child: const Text('add product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
