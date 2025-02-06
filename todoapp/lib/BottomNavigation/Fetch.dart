import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Fetch extends StatefulWidget {
  const Fetch({super.key});

  @override
  State<Fetch> createState() => _FetchState();
}

class _FetchState extends State<Fetch> {
  List<dynamic> todos = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = Uri.parse('https://dummy-json.mock.beeceptor.com/todos');
    try {
      final response = await http.get(url);
      debugPrint('API Response: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is Map<String, dynamic> &&
            data.containsKey('todos') &&
            data['todos'] is List) {
          setState(() {
            todos = data['todos'];
            isLoading = false;
          });
        } else if (data is List) {
          setState(() {
            todos = data;
            isLoading = false;
          });
        } else {
          throw Exception("Unexpected API response structure");
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching data: $e';
        isLoading = false;
      });
      debugPrint('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
              child: const Text(
        'Todo App  Data',
        style: TextStyle(
            color: Colors.black, fontStyle: FontStyle.italic, fontSize: 18),
      ))),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(
                  child: Text(errorMessage,
                      style: const TextStyle(color: Colors.red)))
              : ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    final userId = todo['userId']?.toString() ?? 'N/A';
                    final id = todo['id']?.toString() ?? 'N/A';
                    final title = todo['title'] ?? 'No title';
                    final completed = todo['completed'] ?? false;

                    return Card(
                      margin: const EdgeInsets.all(10),
                      color: const Color.fromARGB(255, 106, 138, 165),
                      child: ListTile(
                        subtitle: Text('User ID: $userId \nID: $id'),
                        title: Text(
                          title,
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          completed ? Icons.check_circle : Icons.cancel,
                          color: completed ? Colors.green : Colors.red,
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
