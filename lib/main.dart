import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: PostList(),
  ));
}

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  List posts = [];

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  fetchPosts() async {
    var response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      setState(() {
        posts = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(posts[index]['title']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CommentList(postId: posts[index]['id']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CommentList extends StatefulWidget {
  final int postId;

  CommentList({required this.postId});

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  List comments = [];

  @override
  void initState() {
    super.initState();
    fetchComments();
  }

  fetchComments() async {
    var response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/posts/${widget.postId}/comments'));
    if (response.statusCode == 200) {
      setState(() {
        comments = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: ListView.builder(
        itemCount: comments.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(comments[index]['name']),
            subtitle: Text(comments[index]['body']),
          );
        },
      ),
    );
  }
}
