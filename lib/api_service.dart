import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:github_api_app/repository.dart';

class ApiService {
  final String _baseUrl = 'https://api.github.com/users/amitkumrsingh/repos';

  Future<List<Repository>> getRepositories() async {
    List<Repository> repositories = [];

    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        for (var repo in data) {
          Repository repository = Repository(
            name: repo['name'],
            description: repo['description'] ?? '',
            stars: repo['stargazers_count'],
          );

          repositories.add(repository);
        }
      }
    } catch (e) {
      print('Error retrieving repositories: $e');
    }

    return repositories;
  }
}
