import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:giphy_get/giphy_get.dart';
import 'package:testing1/config.dart';
import 'package:testing1/health_flex_bloc/health_flex_bloc.dart';
import 'package:testing1/ui/health_flex_trending.dart';

class HealthFlexHomeScreen extends StatefulWidget {
  final String title;

  const HealthFlexHomeScreen({required this.title, super.key});
  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HealthFlexHomeScreen> {
  final HealthFlexBloc _bloc = HealthFlexBloc();
  // late ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

  //Gif
  GiphyGif? currentGif;

  // Giphy Client
  late GiphyClient client = GiphyClient(apiKey: giphyApiKey, randomId: '');

  // Random ID
  String randomId = "";

  String giphyApiKey = "eAX6zBlzuVvcLTHHR1Pf13qIbfLwM6Nl";

  @override
  void initState() {
    super.initState();
    _bloc.add(HealthFlexTrendingEvent());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      client.getRandomId().then((value) {
        setState(() {
          randomId = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GiphyGetWrapper(
        giphy_api_key: giphyApiKey,
        builder: (stream, giphyGetWrapper) {
          stream.listen((gif) {
            setState(() {
              currentGif = gif;
            });
          });

          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  const Text("GET DEMO")
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(child: Text("Dark Mode")),
                      Switch(
                          value: currentTheme.currentTheme() == ThemeMode.dark,
                          onChanged: (value) {
                            currentTheme.toggleTheme();
                          })
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Selected GIF",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  currentGif != null
                      ? SizedBox(
                    child: GiphyGifWidget(
                      imageAlignment: Alignment.center,
                      gif: currentGif!,
                      giphyGetWrapper: giphyGetWrapper,
                      borderRadius: BorderRadius.circular(30),
                      showGiphyLabel: true,
                    ),
                  )
                      : const Text("No GIF"),

                  const SizedBox(
                    height: 40
                  ),
                  Bounceable(onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HealthFlexTrending(gif: _bloc.gif!)),
                    );
                  },
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Text(
                            "Trending Gifs",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )

                  )
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  giphyGetWrapper.getGif(
                    "",
                    context,
                    showGIFs: true,
                    showStickers: false,
                    showEmojis: false,
                  );
                },
                tooltip: 'Open Sticker',
                child: const Icon(Icons
                    .insert_emoticon)), // This trailing comma makes auto-formatting nicer for build methods.
          );
        });
  }
}
