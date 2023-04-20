import 'package:chatgpt/constants/constants.dart';
import 'package:chatgpt/models/models.dart';
import 'package:chatgpt/providers/models_providers.dart';
import 'package:chatgpt/services/api_services.dart';
import 'package:chatgpt/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class ModalDropDownWidget extends StatefulWidget {
  const ModalDropDownWidget({super.key});

  @override
  State<ModalDropDownWidget> createState() => _ModalDropDownWidgetState();
}

class _ModalDropDownWidgetState extends State<ModalDropDownWidget> {
  String? currentModal;
  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context, listen: false);
    currentModal = modelsProvider.getCurrentModel;
    return FutureBuilder<List<ModelsModel>>(
      future: modelsProvider.getAllModels(),
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return Center(
            child: TextWidget(
              label: snapshot.error.toString(),
            ),
          );
        return snapshot.data == null || snapshot.data!.isEmpty
            ? const SizedBox.shrink()
            : FittedBox(
                child: DropdownButton(
                  dropdownColor: scaffoldBackgroundColor,
                  iconEnabledColor: Colors.white,
                  items: List<DropdownMenuItem<String>>.generate(
                    snapshot.data!.length,
                    (index) => DropdownMenuItem(
                      value: snapshot.data![index].id,
                      child: TextWidget(
                        label: snapshot.data![index].id,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  value: currentModal,
                  onChanged: (value) {
                    setState(() {
                      currentModal = value.toString();
                    });
                    modelsProvider.setCurrentModel(
                      value.toString(),
                    );
                  },
                ),
              );
      },
    );
  }
}



// DropdownButton(
//       dropdownColor: scaffoldBackgroundColor,
//       iconEnabledColor: Colors.white,
//       items: getModelsItem,
//       value: currentModal,
//       onChanged: (value) {
//         setState(() {
//           currentModal = value.toString();
//         });
//       },
//     );