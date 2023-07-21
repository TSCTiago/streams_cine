import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streams_cine/providers/config_app_provider.dart';

import 'color_picker_modal.dart';

class ConfigurationModal extends StatefulWidget {
  const ConfigurationModal({
    super.key,
  });

  @override
  State<ConfigurationModal> createState() => _ConfigurationModalState();
}

class _ConfigurationModalState extends State<ConfigurationModal> {
  late bool switchValue;
  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.dark_mode);
      }
      return const Icon(
        Icons.light_mode,
        color: Colors.white,
      );
    },
  );
  @override
  void initState() {
    super.initState();
    final configApp = Provider.of<ConfigAppProvider>(context, listen: false);
    switchValue = configApp.isDark;
  }

  @override
  Widget build(BuildContext context) {
    final configApp = Provider.of<ConfigAppProvider>(context, listen: true);
    return SizedBox(
      height: 300,
      // color: Colors.amber,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Configurações',
              style: TextStyle(fontSize: 25.0),
            ),
            Divider(
              thickness: 2.0,
              indent: 50.0,
              endIndent: 50.0,
              color: Theme.of(context).primaryColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Selecione o tema',
                  style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Switch(
                  thumbIcon: thumbIcon,
                  value: switchValue,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (bool value) {
                    setState(() {
                      switchValue = value;
                      configApp.changeTheme(switchValue);
                    });
                  },
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const ColorPickerDialog();
                      });
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Theme.of(context).primaryColor),
                ),
                child: const Text(
                  "Select color",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            ElevatedButton(
              child: const Text('Fechar'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
