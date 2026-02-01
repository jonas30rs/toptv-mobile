import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/app_config_service.dart';
import '../services/category_organizer_service.dart';
import '../services/xtream_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> organizedList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _processCategories();
  }

  void _processCategories() async {
    final rules = Provider.of<AppConfigService>(context, listen: false).layoutRules;
    final xtream = Provider.of<XtreamService>(context, listen: false);
    final rawCategories = await xtream.getLiveCategories();

    if (mounted) {
      setState(() {
        organizedList = CategoryOrganizerService.organizeCategories(rawCategories, rules);
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final banners = Provider.of<AppConfigService>(context, listen: false).banners;
    return Scaffold(
      appBar: AppBar(title: const Text('TopTV - TV Ao Vivo')),
      body: isLoading 
        ? const Center(child: CircularProgressIndicator())
        : Column(
          children: [
            if (banners.isNotEmpty)
              SizedBox(height: 150, child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: banners.length,
                itemBuilder: (ctx, i) => Container(
                  width: 300, margin: const EdgeInsets.all(8),
                  color: Colors.grey[800],
                  child: Center(child: Text(banners[i]['target'], style: const TextStyle(color: Colors.white))),
                ),
              )),
            Expanded(child: ListView.builder(
              itemCount: organizedList.length,
              itemBuilder: (ctx, i) {
                final item = organizedList[i];
                if (item['type'] == 'folder') {
                  return ListTile(
                    leading: const Icon(Icons.folder, color: Colors.blue),
                    title: Text(item['name'], style: const TextStyle(color: Colors.white)),
                    subtitle: Text('${item['count']} canais', style: const TextStyle(color: Colors.grey)),
                    onTap: () {},
                  );
                } else {
                  return ListTile(
                    leading: const Icon(Icons.tv, color: Colors.white70),
                    title: Text(item['name'], style: const TextStyle(color: Colors.white70)),
                  );
                }
              },
            )),
          ],
        ),
    );
  }
}