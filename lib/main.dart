import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AnimatedWidget(),
    );
  }
}

class AnimatedWidget extends StatefulWidget {
  AnimatedWidget({super.key});

  @override
  State<AnimatedWidget> createState() => _AnimatedWidgetState();
}

class _AnimatedWidgetState extends State<AnimatedWidget>
    with TickerProviderStateMixin {
  bool _bool = true;
  bool _first = true;
  double _fontSize = 30;
  String text = 'Bolu Abant Gölü';
  Color _color = Colors.blue;
  bool _isPlay = false;
  late AnimationController _controller;
  @override
  void initState() {
    //play animationcontroller için kullanılır
    _controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: double.infinity,
            height: 50,
          ),
          TextButton(
              onPressed: () {
                setState(() {
                  //boolean değişken tam tersi durum olması durumunda;
                  _bool = !_bool;
                  //Animated the
                  _first = !_first;
                  // _first == true ? _fontSize = 90 : _fontSize = 60;
                  _fontSize = _first ? 30 : 40;
                  _color = _first ? Colors.blue : Colors.green;
                  text = _first ? 'Bolu Abant Gölü' : 'Rize`nun yaylasi';
                });
              },
              child: Text(
                'Değiştir'.toUpperCase(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blueAccent),
              )),
          AnimatedCrossFade(
              //Birinci çocukla konulmak istenen widget konur
              firstChild: Image.network(
                  fit: BoxFit.fill,
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRv0dQw4eeV1YEa75oA5iHGpq5sop9yT5sdLphmR_I_FYlITREqtM3123Lvg_UiQV2MGmI&usqp=CAU'),
              //İkinci çocukla konulmak istenen widget
              secondChild: Image.network(
                  fit: BoxFit.fill,
                  'https://cdn1.ntv.com.tr/gorsel/C5J-rwU5CUOAQQsje4IvZw.jpg?width=1000&mode=crop&scale=both'),
              crossFadeState: //anlık durumu kontrol edilerek durumu göre sayfa getirilir.
                  _bool ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              duration: const Duration(seconds: 1)),
          const SizedBox(
            width: double.infinity,
            height: 40,
          ),
          SizedBox(
            height: 100,
            child: AnimatedDefaultTextStyle(
                child: Text(text),
                style: TextStyle(
                    fontSize: _fontSize,
                    fontWeight: FontWeight.bold,
                    color: _color),
                duration: const Duration(seconds: 1)),
          ),
          //Animated play and pause icon
          SizedBox(
            height: 100,
            child: Center(
              child: GestureDetector(
                child: AnimatedIcon(
                  size: 50,
                  icon: AnimatedIcons.play_pause,
                  progress: _controller,
                ),
                onTap: () {
                  if (_isPlay == false) {
                    _controller.forward();
                    _isPlay = true;
                  } else {
                    _controller.reverse();
                    _isPlay = false;
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

//Animated Font State
class AnimatedFontState extends StatefulWidget {
  AnimatedFontState({super.key});

  @override
  State<AnimatedFontState> createState() => _AnimatedFontStateState();
}

class _AnimatedFontStateState extends State<AnimatedFontState> {
  bool _first = true;

  double _fontSize = 60;

  Color _color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 120,
          child: AnimatedDefaultTextStyle(
              child: const Text('Animated'),
              style: TextStyle(
                  fontSize: _fontSize,
                  fontWeight: FontWeight.bold,
                  color: _color),
              duration: const Duration(seconds: 1)),
        ),
        TextButton(
            onPressed: () {
              setState(() {
                // _first == true ? _fontSize = 90 : _fontSize = 60;
                _fontSize = _first ? 90 : 60;
              });
            },
            child: const Text('Tıkla'))
      ],
    );
  }
}
