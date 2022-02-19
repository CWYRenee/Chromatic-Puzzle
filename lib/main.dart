import 'package:audioplayers/audioplayers.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'colors.dart';

void main() {
  runApp(const MyApp());
}

// Audio Cache---------------------------------------------------

class SoundService {
  // private constructor
  SoundService._();

  /// Cached instance of [SoundService]
  static SoundService? _instance;

  /// return an instance of [SoundService]
  static SoundService get instance {
    // set the instance if it's null
    _instance ??= SoundService._();
    // return the instance
    return _instance!;
  }

  final AudioCache _player = AudioCache(
    prefix: 'audio/',
    fixedPlayer: AudioPlayer(),
  );

  Future<void> loadSounds() async {
    await _player.load('shuffle.mp3');
    await _player.load('startEnd.mp3');
    await _player.load('cChromatic.mp3');
    await _player.load('c.mp3');
    await _player.load('cSharp.mp3');
    await _player.load('d.mp3');
    await _player.load('dSharp.mp3');
    await _player.load('e.mp3');
    await _player.load('f.mp3');
    await _player.load('fSharp.mp3');
    await _player.load('g.mp3');
    await _player.load('gSharp.mp3');
    await _player.load('a.mp3');
    await _player.load('aSharp.mp3');
    await _player.load('b.mp3');
    await _player.load('highC.mp3');
  }

  bool checkIfPlaying() {
    PlayerState _playerState = PlayerState.PLAYING;
    // ignore: non_constant_identifier_names
    bool isPlaying() => _playerState == PlayerState.PLAYING;
    return true;
  }

  Future<void> playShuffleSound() async {
    await _player.play('shuffle.mp3',
        mode: PlayerMode.LOW_LATENCY, stayAwake: false, volume: 1.0);
  }

  Future<void> playStartEndSound() async {
    await _player.play('startEnd.mp3',
        mode: PlayerMode.LOW_LATENCY, stayAwake: false, volume: 1.0);
  }

  Future<void> playCSound() async {
    await _player.play('c.mp3',
        mode: PlayerMode.LOW_LATENCY, stayAwake: false, volume: 0.1);
  }

  Future<void> playCSharpSound() async {
    await _player.play('cSharp.mp3',
        mode: PlayerMode.LOW_LATENCY, stayAwake: false, volume: 0.1);
  }

  Future<void> playDSound() async {
    await _player.play('d.mp3',
        mode: PlayerMode.LOW_LATENCY, stayAwake: false, volume: 0.1);
  }

  Future<void> playDSharpSound() async {
    await _player.play('dSharp.mp3',
        mode: PlayerMode.LOW_LATENCY, stayAwake: false, volume: 0.1);
  }

  Future<void> playESound() async {
    await _player.play('e.mp3',
        mode: PlayerMode.LOW_LATENCY, stayAwake: false, volume: 0.1);
  }

  Future<void> playFSound() async {
    await _player.play('f.mp3',
        mode: PlayerMode.LOW_LATENCY, stayAwake: false, volume: 0.1);
  }

  Future<void> playFSharpSound() async {
    await _player.play('fSharp.mp3',
        mode: PlayerMode.LOW_LATENCY, stayAwake: false, volume: 0.1);
  }

  Future<void> playGSound() async {
    await _player.play('g.mp3',
        mode: PlayerMode.LOW_LATENCY, stayAwake: false, volume: 0.1);
  }

  Future<void> playGSharpSound() async {
    await _player.play('gSharp.mp3',
        mode: PlayerMode.LOW_LATENCY, stayAwake: false, volume: 0.1);
  }

  Future<void> playASound() async {
    await _player.play('a.mp3',
        mode: PlayerMode.LOW_LATENCY, stayAwake: false, volume: 0.1);
  }

  Future<void> playASharpSound() async {
    await _player.play('aSharp.mp3',
        mode: PlayerMode.LOW_LATENCY, stayAwake: false, volume: 0.1);
  }

  Future<void> playBSound() async {
    await _player.play('b.mp3',
        mode: PlayerMode.LOW_LATENCY, stayAwake: false, volume: 0.1);
  }

  Future<void> playHighCSound() async {
    await _player.play('highC.mp3',
        mode: PlayerMode.LOW_LATENCY, stayAwake: false, volume: 0.1);
  }

  Future<void> playCChromaticSound() async {
    await _player.play('cChromatic.mp3',
        mode: PlayerMode.LOW_LATENCY, stayAwake: false, volume: 0.1);
  }

  Future<void> stopSound() async {
    await _player.fixedPlayer?.stop();
  }
}

// END: Audio Cache ----------------------------------------------
class PlayButton extends StatelessWidget {
  const PlayButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      startDelay: const Duration(milliseconds: 1000),
      glowColor: Colors.grey,
      endRadius: 60.0,
      duration: const Duration(milliseconds: 2000),
      repeat: true,
      showTwoGlows: true,
      repeatPauseDuration: const Duration(milliseconds: 100),
      child: MaterialButton(
        onPressed: () {
          if (SoundService.instance.checkIfPlaying() == true) {
            SoundService.instance.stopSound();
          } else {}
          SoundService.instance.playCChromaticSound();
        },
        elevation: 20.0,
        shape: const CircleBorder(),
        child: Container(
          width: 60.0,
          height: 60.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: PuzzleColors.darkGrey,
              borderRadius: BorderRadius.circular(60.0)),
          child: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(
                    Icons.play_arrow,
                    size: 30,
                    color: Colors.white,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

List<int?> puzzlePieces = <int?>[];

int numMoves = 0;
enum PossibleSwap {
  LEFT,
  UP,
  DOWN,
  RIGHT,
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  @override
  void initState() {
    SoundService.instance.loadSounds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chromatic Puzzle',
      theme: ThemeData(primarySwatch: Colors.grey),
      // darkTheme: ThemeData.dark(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const double PADDING_SIZED = 10;
  static const BorderRadiusGeometry border =
      BorderRadius.all(Radius.circular(20));
  static const Color lightGrey = PuzzleColors.lightGrey;
  static const Color darkGrey = PuzzleColors.darkGrey;
  int? highlightedValue;

  Widget makeCell(int num) {
    return Material(
      color: num == highlightedValue ? const Color(0xFF4A4A4A) : darkGrey,
      borderRadius: border,
      child: InkWell(
        customBorder: const RoundedRectangleBorder(borderRadius: border),
        hoverColor: Colors.grey[600],
        splashColor: tileColor(num),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (num == 1) ...[
                const AutoSizeText(
                  'START',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w900),
                )
              ] else if (num == 15) ...[
                const AutoSizeText(
                  'END',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w900),
                )
              ]
            ],
          ),
        ),
        onTap: () {
          trySwapGivenNum(num);
          tileAudio(num);
          tileColor(num);
        },
      ),
    );
  }

  bool canSwapHoleWithLeft(int holeIndex) => holeIndex % 4 != 0;
  bool canSwapHoleWithRight(int holeIndex) => holeIndex % 4 != 3;
  bool canSwapHoleWithUp(int holeIndex) => holeIndex >= 4;
  bool canSwapHoleWithDown(int holeIndex) => holeIndex <= 11;
  void swapHoleWithLeft(int holeIndex) => swap(holeIndex, holeIndex - 1);
  void swapHoleWithRight(int holeIndex) => swap(holeIndex, holeIndex + 1);
  void swapHoleWithUp(int holeIndex) => swap(holeIndex, holeIndex - 4);
  void swapHoleWithDown(int holeIndex) => swap(holeIndex, holeIndex + 4);
  void swap(int piece1, int piece2) {
    final int? temp = puzzlePieces[piece1];
    puzzlePieces[piece1] = puzzlePieces[piece2];
    puzzlePieces[piece2] = temp;
  }

  Future<void> tileAudio(int tileNum) async {
    switch (tileNum) {
      case 1:
        await SoundService.instance.playStartEndSound();
        break;

      case 2:
        await SoundService.instance.playCSound();
        break;

      case 3:
        await SoundService.instance.playCSharpSound();
        break;

      case 4:
        await SoundService.instance.playDSound();
        break;

      case 5:
        await SoundService.instance.playDSharpSound();
        break;

      case 6:
        await SoundService.instance.playESound();
        break;

      case 7:
        await SoundService.instance.playFSound();
        break;

      case 8:
        await SoundService.instance.playFSharpSound();
        break;

      case 9:
        await SoundService.instance.playGSound();
        break;

      case 10:
        await SoundService.instance.playGSharpSound();
        break;

      case 11:
        await SoundService.instance.playASound();
        break;

      case 12:
        await SoundService.instance.playASharpSound();
        break;

      case 13:
        await SoundService.instance.playBSound();
        break;

      case 14:
        await SoundService.instance.playHighCSound();
        break;

      case 15:
        await SoundService.instance.playStartEndSound();
        break;
    }
  }

  Color? tileColor(int tileNum) {
    switch (tileNum) {
      case 1:
        return Colors.grey;

      case 2:
        return Colors.redAccent;

      case 3:
        return Colors.purpleAccent;

      case 4:
        return Colors.yellowAccent;

      case 5:
        return Colors.pink[200];

      case 6:
        return Colors.cyan[50];

      case 7:
        return Colors.red[900];

      case 8:
        return Colors.blueAccent[100];

      case 9:
        return Colors.orangeAccent;

      case 10:
        return Colors.purple[100];

      case 11:
        return Colors.greenAccent[400];

      case 12:
        return Colors.red[100];

      case 13:
        return Colors.blue[200];

      case 14:
        return Colors.redAccent[400];

      case 15:
        return Colors.grey;
    }
    return Colors.black;
  }

  void trySwapGivenNum(int numToSwap) {
    final int numIndex = puzzlePieces.indexOf(numToSwap);
    final int holeIndex = puzzlePieces.indexOf(null);
    void onSuccess() {
      setState(() {
        highlightedValue = numToSwap;
        numMoves++;
      });
    }

    if (numIndex == holeIndex - 1 && canSwapHoleWithLeft(holeIndex)) {
      swapHoleWithLeft(holeIndex);
      onSuccess();
    } else if (numIndex == holeIndex + 1 && canSwapHoleWithRight(holeIndex)) {
      swapHoleWithRight(holeIndex);
      onSuccess();
    } else if (numIndex == holeIndex - 4 && canSwapHoleWithUp(holeIndex)) {
      swapHoleWithUp(holeIndex);
      onSuccess();
    } else if (numIndex == holeIndex + 4 && canSwapHoleWithDown(holeIndex)) {
      swapHoleWithDown(holeIndex);
      onSuccess();
    }
  }

  // Resets everything and shuffles the tiles with the following algorithm:
  // start sorted and then apply 1000 random shuffles
  void resetAndShuffle() {
    numMoves = 0;
    highlightedValue = null;
    puzzlePieces = <int?>[
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      null
    ];

    final Random rng = Random();
    final List<PossibleSwap> swaps = <PossibleSwap>[];
    for (int i = 0; i < 1000; i++) {
      swaps.clear();
      final int holeIndex = puzzlePieces.indexOf(null);
      if (canSwapHoleWithLeft(holeIndex)) {
        swaps.add(PossibleSwap.LEFT);
      }
      if (canSwapHoleWithRight(holeIndex)) {
        swaps.add(PossibleSwap.RIGHT);
      }
      if (canSwapHoleWithUp(holeIndex)) {
        swaps.add(PossibleSwap.UP);
      }
      if (canSwapHoleWithDown(holeIndex)) {
        swaps.add(PossibleSwap.DOWN);
      }
      final PossibleSwap chosenSwap = swaps[rng.nextInt(swaps.length)];
      if (chosenSwap == PossibleSwap.LEFT) {
        swapHoleWithLeft(holeIndex);
      } else if (chosenSwap == PossibleSwap.RIGHT) {
        swapHoleWithRight(holeIndex);
      } else if (chosenSwap == PossibleSwap.UP) {
        swapHoleWithUp(holeIndex);
      } else if (chosenSwap == PossibleSwap.DOWN) {
        swapHoleWithDown(holeIndex);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (puzzlePieces.isEmpty) {
      resetAndShuffle();
    }
    final List<Widget> cells = <Widget>[];
    for (int i = 0; i < puzzlePieces.length; i++) {
      if (puzzlePieces[i] == null) {
        cells.add(Container());
      } else {
        cells.add(makeCell(puzzlePieces[i]!));
      }
    }
    return Scaffold(
      body: MediaQuery.of(context).size.width < 1300
          ? buildCompact(cells, 15 - numPiecesInRightPlace())
          : buildWideScreen(cells, 15 - numPiecesInRightPlace()),
    );
  }

  int numPiecesInRightPlace() {
    int counter = 0;
    for (int i = 0; i < puzzlePieces.length; i++) {
      if (puzzlePieces[i] == null) {
        continue;
      } else if (i == puzzlePieces[i]! - 1) {
        counter++;
      }
    }
    return counter;
  }

  Widget buildCompact(List<Widget> cells, int numPiecesInWrongPlace) {
    const double COMPACT_GRID_SIZE = 350;
    return Column(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                numPiecesInWrongPlace == 0
                    ? "Well Done. Congrats!"
                    : "Chromatic Sound Puzzle",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                "\nClick to move the tile and to hear the music note.\nThe play button at the bottom is what you're trying to solve!\n",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
              Text.rich(
                TextSpan(
                  style: const TextStyle(
                      fontSize: 16, color: PuzzleColors.darkGrey),
                  children: <InlineSpan>[
                    TextSpan(
                        text: numMoves.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(text: " Moves | "),
                    TextSpan(
                        text: numPiecesInWrongPlace.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(text: " Tiles in the Wrong Place"),
                  ],
                ),
              ),
              const Text(
                "Hint: the notes are correspondant to Scriabin's sound-to-color associations",
                style: TextStyle(
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: SizedBox(
            height: COMPACT_GRID_SIZE,
            width: COMPACT_GRID_SIZE,
            child: GridView.count(
              mainAxisSpacing: PADDING_SIZED,
              crossAxisSpacing: PADDING_SIZED,
              crossAxisCount: 4,
              children: cells,
            ),
          ),
        ),
        const SizedBox(height: 40),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[PlayButton()],
        ),
        Flexible(
          flex: 1,
          child: Center(
            child: GestureDetector(
              child: Container(
                width: COMPACT_GRID_SIZE * (1.5 / 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(COMPACT_GRID_SIZE),
                  color: PuzzleColors.darkGrey,
                ),
                height: 30,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(
                        Icons.refresh,
                        size: 20,
                        color: Colors.white,
                      ),
                      Text(
                        "Shuffle",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () async {
                await SoundService.instance.playShuffleSound();
                resetAndShuffle();
                setState(() {});
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildWideScreen(List<Widget> cells, int numPiecesInWrongPlace) {
    const double WIDE_GRID_SIZE = 600;
    return Stack(
      children: <Widget>[
        Container(
          alignment: const Alignment(-0.5, 0.0),
          child: Padding(
            padding: const EdgeInsets.only(right: 200),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  numPiecesInWrongPlace == 0
                      ? "Well Done.\nCongrats!"
                      : "Chromatic\nPuzzle",
                  style: const TextStyle(
                      fontSize: 50, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "\nClick to move the tile and to hear the music note.\n\nThe play button below is what you're trying to solve!",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                Text.rich(
                  TextSpan(
                    style: const TextStyle(
                        fontSize: 20, color: PuzzleColors.darkGrey),
                    children: <InlineSpan>[
                      TextSpan(
                          text: numMoves.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const TextSpan(text: " Moves | "),
                      TextSpan(
                          text: numPiecesInWrongPlace.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const TextSpan(text: " Tiles in the Wrong Place"),
                    ],
                  ),
                ),
                const Text(
                  "\nHint: the notes are correspondant to Scriabin's\nsound-to-color associations\n",
                  style: TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  child: Container(
                    width: WIDE_GRID_SIZE * (1.5 / 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(WIDE_GRID_SIZE),
                      color: PuzzleColors.darkGrey,
                    ),
                    height: 50,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Icon(
                            Icons.refresh,
                            size: 30,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text("Shuffle",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25))
                        ],
                      ),
                    ),
                  ),
                  onTap: () async {
                    await SoundService.instance.playShuffleSound();
                    resetAndShuffle();
                    setState(() {});
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: WIDE_GRID_SIZE * (1.5 / 4),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[PlayButton()]),
                )
              ],
            ),
          ),
        ),
        Container(
          alignment: const Alignment(0.5, 0.0),
          child: SizedBox(
            height: WIDE_GRID_SIZE,
            width: WIDE_GRID_SIZE,
            child: GridView.count(
              padding: const EdgeInsets.only(left: 10),
              mainAxisSpacing: PADDING_SIZED,
              crossAxisSpacing: PADDING_SIZED,
              crossAxisCount: 4,
              children: cells,
            ),
          ),
        ),
      ],
    );
  }
}
