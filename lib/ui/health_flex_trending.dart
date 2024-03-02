import 'package:flutter/material.dart';
import 'package:giphy_get/giphy_get.dart';

class HealthFlexTrending extends StatefulWidget {
  final GiphyCollection gif;

  const HealthFlexTrending({required this.gif, Key? key}) : super(key: key);

  @override
  _HealthFlexTrendingState createState() => _HealthFlexTrendingState();
}

class _HealthFlexTrendingState extends State<HealthFlexTrending> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trending Giphy Picker Demo'),
      ),
      body: SafeArea(
        child: Container(
          child: _buildGiphyCollectionWidget(),
        ),
      ),
    );
  }

  Widget _buildGiphyCollectionWidget() {
    // Extract relevant data from GiphyCollection and use it to create a widget
    // Example: Assuming GiphyCollection has a list of GiphyGif objects
    List<GiphyGif> gifs = widget.gif.data;

    // Create a widget to display the gifs, such as ListView.builder
    return ListView.builder(
      itemCount: gifs.length,
      itemBuilder: (context, index) {
        // Create a widget to display each gif
        return ListTile(
          leading: Image.network(gifs[index].images!.original!.url!),
          title: Text(gifs[index].title!),
        );
      },
    );
  }
}
