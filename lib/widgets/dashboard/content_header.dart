import 'package:flutter/material.dart';
import 'package:learning_management_system/Objects/pages.dart';
import 'package:learning_management_system/widgets/dashboard/widgets.dart';
import 'package:video_player/video_player.dart';

class ContentHeader extends StatelessWidget {
  final Content featuredContent;

  const ContentHeader({
    Key key,
    @required this.featuredContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _ContentHeaderMobile(featuredContent: featuredContent),
      desktop: _ContentHeaderDesktop(featuredContent: featuredContent),
    );
  }
}

class _ContentHeaderMobile extends StatelessWidget {
  final Content featuredContent;

  const _ContentHeaderMobile({
    Key key,
    @required this.featuredContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var screenSize = MediaQuery.of(context).size;
    // var screenWidth = screenSize.width;
    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
    //   children: <Widget>[
    //     Row(
    //       children: <Widget>[
    //         Container(
    //             child: Center(child : Text("Converted Visits")),
    //             height: 200.0,
    //             width: screenWidth,
    //             decoration: BoxDecoration(
    //                 image: DecorationImage(
    //               image: AssetImage(featuredContent.imageUrl),
    //               fit: BoxFit.cover,
    //             ))),
    //       ],
    //     ),
    //     Row(
    //       children: <Widget>[
    //         Container(
    //             child: Center(child : Text("All Visits")),
    //             height: 200.0,
    //             width: screenWidth,
    //             decoration: BoxDecoration(
    //                 image: DecorationImage(
    //               image: AssetImage(featuredContent.imageUrl),
    //               fit: BoxFit.cover,
    //             ))),
    //       ],
    //     ),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       children: <Widget>[
    //         VerticalIconButton(
    //           icon: Icons.add,
    //           title: 'Select Page',
    //           onTap: () => print('Select Page'),
    //         ),
    //         VerticalIconButton(
    //           icon: Icons.add,
    //           title: "Timeframe",
    //           onTap: () => print("Jan 2020 - Feb 2021"),
    //         ),
    //         //_PlayButton(),
    //         VerticalIconButton(
    //           icon: Icons.info_outline,
    //           title: 'Info',
    //           onTap: () => print('Info'),
    //         ),
    //       ],
    //     ),
    //   ],
    // );
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
         // child : Text("Converted Home Page"),
          height: 450.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(featuredContent.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 450.0,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        // Positioned(
        //   top: 50.0,
        //   left : 150.0,
        //   child: SizedBox(
        //     width: 250.0,
        //     child: Text("Converted Page",
        //     style : TextStyle(height : 20, fontWeight: FontWeight.bold),
        //   ),
        //   ),
        // ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              VerticalIconButton(
                icon: Icons.add,
                title: 'Type of User',
                onTap: () => print('Visit Type'),
              ),
              VerticalIconButton(
                icon: Icons.add,
                title: 'Select Page',
                onTap: () => print("Page Dropdown based on Volume of Visits per Page in Mongo"),
              ),
              //_PlayButton(),
              VerticalIconButton(
                icon: Icons.add,
                title: 'Timeframe',
                onTap: () => print('Jan 2020 - Feb 2021'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
class _ContentHeaderDesktop extends StatefulWidget {
  final Content featuredContent;

  const _ContentHeaderDesktop({
    Key key,
    @required this.featuredContent,
  }) : super(key: key);

  @override
  __ContentHeaderDesktopState createState() => __ContentHeaderDesktopState();
}

class __ContentHeaderDesktopState extends State<_ContentHeaderDesktop> {
  VideoPlayerController _videoController;
  bool _isMuted = true;

  @override
  void initState() {
    super.initState();
    _videoController =
        VideoPlayerController.network(widget.featuredContent.videoUrl)
          ..initialize().then((_) => setState(() {}))
          ..setVolume(0)
          ..play();
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _videoController.value.isPlaying
          ? _videoController.pause()
          : _videoController.play(),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          AspectRatio(
            aspectRatio: _videoController.value.initialized
                ? _videoController.value.aspectRatio
                : 2.344,
            child: _videoController.value.initialized
                ? VideoPlayer(_videoController)
                : Image.asset(
                    widget.featuredContent.imageUrl,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: -1.0,
            child: AspectRatio(
              aspectRatio: _videoController.value.initialized
                  ? _videoController.value.aspectRatio
                  : 2.344,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 60.0,
            right: 60.0,
            bottom: 150.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250.0,
                  child: Image.asset(widget.featuredContent.titleImageUrl),
                ),
                const SizedBox(height: 15.0),
                Text(
                  widget.featuredContent.description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(2.0, 4.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    _PlayButton(),
                    const SizedBox(width: 16.0),
                    FlatButton.icon(
                      padding:
                          const EdgeInsets.fromLTRB(25.0, 10.0, 30.0, 10.0),
                      onPressed: () => print('More Info'),
                      color: Colors.white,
                      icon: const Icon(Icons.info_outline, size: 30.0),
                      label: const Text(
                        'More Info',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    if (_videoController.value.initialized)
                      IconButton(
                        icon: Icon(
                          _isMuted ? Icons.volume_off : Icons.volume_up,
                        ),
                        color: Colors.white,
                        iconSize: 30.0,
                        onPressed: () => setState(() {
                          _isMuted
                              ? _videoController.setVolume(100)
                              : _videoController.setVolume(0);
                          _isMuted = _videoController.value.volume == 0;
                        }),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      padding: !Responsive.isDesktop(context)
          ? const EdgeInsets.fromLTRB(15.0, 5.0, 20.0, 5.0)
          : const EdgeInsets.fromLTRB(25.0, 10.0, 30.0, 10.0),
      onPressed: () => print('Play'),
      color: Colors.white,
      icon: const Icon(Icons.play_arrow, size: 30.0),
      label: const Text(
        'Play',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
