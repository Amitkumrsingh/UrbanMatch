import 'package:flutter/material.dart';
import 'package:github_api_app/api_service.dart';
import 'package:github_api_app/repository.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService _apiService = ApiService();
  late Future<List<Repository>> _repositories;

  @override
  void initState() {
    super.initState();
    _repositories = _apiService.getRepositories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Github Repositories'),
      ),
      body: Center(
        child: FutureBuilder<List<Repository>>(
          future: _repositories,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Repository repository = snapshot.data![index];

                  return ListTile(
                    title: Text(repository.name),
                    subtitle: Text(repository.description),
                    trailing: Text('${repository.stars} stars'),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error retrieving repositories');
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
