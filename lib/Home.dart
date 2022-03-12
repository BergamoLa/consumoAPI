
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List> _loadData() async {
    List posts = [];
    try {
      const API = 'https://jsonplaceholder.typicode.com/posts';
      final http.Response response = await http.get(Uri.parse(API));
      posts = json.decode(response.body);
    } catch (err) {
      print(err);
    }

    return posts;
  }

  //metodo post
  Future _post() async {
    var corpo = json.encode(
      {
        "userId": 120,
        "id": null,
        "title": "Titulo",
        "body": "Corpo da postagem",
      },
    );
    const API = 'https://jsonplaceholder.typicode.com/posts';
    final http.Response response = await http.post(Uri.parse(API),
        headers: {"Content-type": "application/json; charset=UTF-8"},
        body: corpo);

    print("resposta: ${response.statusCode}");
    print("resposta: ${response.body}");
  }

  //METODO PUT
  Future _put() async {
    var corpo = json.encode(
      {
        "userId": 120,
        "id": null,
        "title": "Titulo alterado",
        "body": "Corpo da postagem alterado",
      },
    );
    const API = 'https://jsonplaceholder.typicode.com/posts/2';
    final http.Response response = await http.put(Uri.parse(API),
        headers: {"Content-type": "application/json; charset=UTF-8"},
        body: corpo);

    print("resposta: ${response.statusCode}");
    print("resposta: ${response.body}");
  }
//metodo PATCH
  Future _patch() async {
    var corpo = json.encode(
      {
        "userId": 120,
        "id": null,
        "title": null,
        "body": "Corpo da postagem alterado patch",
      },
    );
    const API = 'https://jsonplaceholder.typicode.com/posts/2';
    final http.Response response = await http.put(Uri.parse(API),
        headers: {"Content-type": "application/json; charset=UTF-8"},
        body: corpo);

    print("resposta: ${response.statusCode}");
    print("resposta: ${response.body}");
  }
  //METODO DELETE
  Future _delete() async {
    var corpo = json.encode(
      {
        "userId": 120,
        "id": null,
        "title": "Titulo alterado",
        "body": "Corpo da postagem alterado",
      },
    );
    const API = 'https://jsonplaceholder.typicode.com/posts/2';
    final http.Response response = await http.delete(Uri.parse(API),
        headers: {"Content-type": "application/json; charset=UTF-8"},
        body: corpo);

    print("resposta: ${response.statusCode}");
    print("resposta: ${response.body}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PostsApp'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      _post();
                    },
                    child: Text("Salvar")),
                ElevatedButton(
                    onPressed: () {
                      _delete();
                    },
                    child: Text("Remover")),
                ElevatedButton(
                    onPressed: () {
                      //_put();
                      _patch();
                    },
                    child: Text("Atualizar")),
              ],
            ),
            Expanded(
              child: FutureBuilder(
                  future: _loadData(),
                  builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                      snapshot.hasData
                          ? ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, index) =>
                                  Card(
                                margin: const EdgeInsets.all(10),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(10),
                                  title: Text(snapshot.data![index]['title']),
                                  subtitle: Text(snapshot.data![index]['body']),
                                ),
                              ),
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            )),
            ),
          ],
        ),
      ),
    );
  }
}
