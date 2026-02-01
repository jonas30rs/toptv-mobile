class CategoryOrganizerService {
  static List<dynamic> organizeCategories(List<String> rawCategories, List<dynamic> rules) {
    Map<String, List<String>> foldersContent = {};
    List<String> rootCategories = [];

    for (var rule in rules) {
      foldersContent[rule['folder_name']] = [];
    }

    for (String categoryName in rawCategories) {
      bool matched = false;
      String upperName = categoryName.toUpperCase();

      for (var rule in rules) {
        List<dynamic> prefixes = rule['prefixes'];
        String folderName = rule['folder_name'];
        
        // Verifica se algum prefixo bate
        bool hasPrefix = prefixes.any((prefix) => upperName.contains(prefix.toString().toUpperCase()));

        if (hasPrefix) {
          foldersContent[folderName]!.add(categoryName);
          matched = true;
          break;
        }
      }

      if (!matched) {
        rootCategories.add(categoryName);
      }
    }

    List<dynamic> uiStructure = [];
    for (var rule in rules) {
      String folderName = rule['folder_name'];
      String icon = rule['icon'];
      List<String> contents = foldersContent[folderName]!;

      if (contents.isNotEmpty) {
        uiStructure.add({
          'type': 'folder',
          'name': folderName,
          'icon': icon,
          'children': contents,
          'count': contents.length
        });
      }
    }

    for (var cat in rootCategories) {
      uiStructure.add({
        'type': 'category',
        'name': cat,
        'icon': 'folder_open'
      });
    }

    return uiStructure;
  }
}