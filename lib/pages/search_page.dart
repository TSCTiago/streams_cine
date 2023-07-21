import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/titles_provider.dart';
import '../widgets/skeleton/skeleton_progress_grid_view.dart';
import '../widgets/text_field.dart';
import '../widgets/title_card.dart';

class SearchPage extends StatelessWidget {
  final String initialValueText;
  const SearchPage({super.key, required this.initialValueText});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TitleProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(title: const Text('Pesquisar Títulos')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFieldTitle(text: initialValueText),
            provider.isSearching
                ? const SkeletonProgressGridView()
                : _buildSearchResults(provider),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults(TitleProvider provider) {
    if (provider.searchedTitles.isEmpty) {
      return const SizedBox(
          height: 80.0,
          child: Center(child: Text('Nenhum resultado encontrado.')));
    } else {
      return SizedBox(
        height: 900.0,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 2,
            childAspectRatio: 0.8,
          ),
          itemCount: provider.searchedTitles.length,
          itemBuilder: (BuildContext context, int index) {
            // debugPrint(provider.searchedTitles[index].toString());
            return TitleCard(title: provider.searchedTitles[index]);
          },
        ),
      );
    }
  }
}
