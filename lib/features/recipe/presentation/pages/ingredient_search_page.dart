import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_finder/core/network/network_checker.dart';
import 'package:recipe_finder/core/theme.dart';
import 'package:recipe_finder/core/widgets/network_sensitive_widget.dart';
import 'package:recipe_finder/core/widgets/offline_banner.dart';

class IngredientSearchPage extends StatefulWidget {
  const IngredientSearchPage({super.key});

  @override
  State<IngredientSearchPage> createState() => _IngredientSearchPageState();
}

class _IngredientSearchPageState extends State<IngredientSearchPage> {
  final TextEditingController _controller = TextEditingController();
  bool isOffline = false;

  @override
  void initState() {
    super.initState();
    _checkNetwork();
  }

  Future<void> _checkNetwork() async {
    final online = await NetworkChecker.isOnline();
    if (!online) {
      setState(() => isOffline = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return NetworkSensitiveWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Find Recipes",
              style: Theme.of(context).textTheme.headlineLarge),
        ),
        body: Column(
          children: [
            // if (isOffline) const OfflineBanner(),
            Padding(
              padding: EdgeInsets.all(12),
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Search for ingredients...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: kSecondaryColor,
                    ),
                    onPressed: () async {
                      if (_controller.text.isNotEmpty) {
                        final ingredients = _controller.text.trim();
                        GoRouter.of(context)
                            .push('/recipes/search/$ingredients');
                        _controller.clear();
                        FocusManager.instance.primaryFocus?.unfocus();
                      }
                    },
                  ),
                ),
                onFieldSubmitted: (text) {
                  if (_controller.text.isNotEmpty) {
                    final ingredients = _controller.text.trim();
                    GoRouter.of(context).push('/recipes/search/$ingredients');
                    _controller.clear();
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
