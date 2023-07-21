import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streams_cine/app/rotes_app.dart';

import '../providers/titles_provider.dart';

class TextFieldTitle extends StatefulWidget {
  final String text;
  const TextFieldTitle({
    super.key,
    required this.text,
  });

  @override
  State<TextFieldTitle> createState() => _TextFieldTitleState();
}

class _TextFieldTitleState extends State<TextFieldTitle> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isOnRoute(BuildContext context, String routeName) {
    String? currentRoute = ModalRoute.of(context)?.settings.name;
    return currentRoute == routeName;
  }

  void _submitValue(context) {
    String value = _controller.text;
    debugPrint(value);

    final provider = Provider.of<TitleProvider>(context, listen: false);
    provider.clearList(provider.searchedTitles);
    provider.isSearching = true;
    provider.searchTitle(value).then((value) => debugPrint('Acabou'));

    if (!isOnRoute(context, RoutesApp.search)) {
      _controller.text = "";
      Navigator.of(context).pushNamed(RoutesApp.search, arguments: value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
              child: TextField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 1.0),
              labelText: 'Pesquisar Títulos',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2.0,
                ),
              ),
              floatingLabelStyle: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            controller: _controller,
            onSubmitted: (String value) {
              _submitValue(context);
            },
          )),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                _submitValue(context);
              },
              icon: const Icon(
                Icons.search,
                size: 30.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
