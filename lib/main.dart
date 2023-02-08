import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

// Flutter에서 앱 상태를 관리하는 강력한 방법 ChangeNotifier
/**
 * MyAppState앱이 작동하는 데 필요한 데이터를 정의합니다. 
 * 지금은 현재 임의의 단어 쌍이 있는 단일 변수만 포함합니다. 나중에 추가할 것입니다.
 * 상태 클래스는 확장 ChangeNotifier합니다. 즉, 자신의 변경 사항 을 다른 사람 에게 알릴 수 있습니다. 
 * 예를 들어 현재 단어 쌍이 변경되면 앱의 일부 위젯이 알아야 합니다.
 * 상태는 를 사용하여 전체 앱에 생성되고 제공됩니다 ChangeNotifierProvider(위의 코드 참조 MyApp). 
 * 이렇게 하면 앱의 모든 위젯이 상태를 유지할 수 있습니다.
 * MyAppState앱이 작동하는 데 필요한 데이터를 정의합니다. 지금은 현재 임의의 단어 쌍이 있는 단일 변수만 포함합니다. 나중에 추가할 것입니다.
 * 상태 클래스는 확장 ChangeNotifier합니다. 즉, 자신의 변경 사항 을 다른 사람 에게 알릴 수 있습니다 . 예를 들어 현재 단어 쌍이 변경되면 앱의 일부 위젯이 알아야 합니다.
 * 상태는 를 사용하여 전체 앱에 생성되고 제공됩니다 ChangeNotifierProvider(위의 코드 참조 MyApp). 이렇게 하면 앱의 모든 위젯이 상태를 유지할 수 있습니다.
 * 1. 모든 위젯은 build()위젯이 항상 최신 상태를 유지하도록 위젯의 상황이 바뀔 때마다 자동으로 호출되는 메서드를 정의합니다.
 * 2. MyHomePagewatch메서드 를 사용하여 앱의 현재 상태에 대한 변경 사항을 추적합니다 .
 * 3. 모든 build메서드는 위젯 또는 (보다 일반적으로) 중첩된 위젯 트리 를 반환해야 합니다 . 이 경우 최상위 위젯은 Scaffold입니다. 이 Codelab에서 작업 Scaffold하지는 않지만 유용한 위젯이며 대부분의 실제 Flutter 앱에서 찾을 수 있습니다.
 * 4. ColumnFlutter에서 가장 기본적인 레이아웃 위젯 중 하나입니다. 원하는 수의 자식을 가져와 위에서 아래로 열에 넣습니다. 기본적으로 열은 시각적으로 하위 항목을 맨 위에 배치합니다. 기둥이 중앙에 오도록 곧 변경할 것입니다.
 * 5. Text첫 번째 단계에서 이 위젯을 변경했습니다 .
 * 6. 이 두 번째 Text위젯은 appState을 사용하여 해당 클래스의 유일한 구성원( )에 액세스 current합니다 WordPair. 또는 WordPair와 같은 몇 가지 유용한 getter를 제공합니다 . 여기서는 사용 하지만 대안 중 하나를 선호하는 경우 지금 변경할 수 있습니다.asPascalCaseasSnakeCaseasLowerCase
 * 7. Flutter 코드가 어떻게 후행 쉼표를 많이 사용하는지 주목하세요. 이 특정 쉼표는 이 특정 매개변수 목록 children의 마지막(또한 유일한 ) 구성원 이기 때문에 여기에 있을 필요가 없습니다 . Column그러나 일반적으로 후행 쉼표를 사용하는 것이 좋습니다. 쉼표는 더 많은 멤버를 추가하는 것을 사소하게 만들고 Dart의 자동 서식 지정 도구가 줄 바꿈을 추가하도록 힌트 역할을 합니다. 자세한 내용은 코드 서식 지정 을 참조하십시오 .
 */ ///
class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = FavoritesPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite),
                    label: Text('Favorites'),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    Key? key,
    required this.pair,
  }) : super(key: key);

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    /**
     * 첫째, 코드는 를 사용하여 앱의 현재 테마를 요청합니다 Theme.of(context).
     * 그런 다음 코드는 카드의 색상을 테마의 colorScheme속성과 동일하게 정의합니다. 
     * 색 구성표는 많은 색을 포함 primary하며 앱의 색을 정의하는 가장 눈에 띄는 색입니다.
     * 이 색과 전체 앱의 색 구성표를 위로 스크롤 MyApp하고 거기에 대한 시드 색을 변경하여 변경할 수 ColorScheme있습니다.
     * Colors.deepOrangeColors.redColor.fromRGBO(0, 255, 0, 1.0)Color(0xFF00FF00)
     */
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
      color: theme.colorScheme.primary,
      child: Text(
        pair.asLowerCase,
        style: style,
        semanticsLabel: pair.asPascalCase,
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('You have '
              '${appState.favorites.length} favorites:'),
        ),
        for (var pair in appState.favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(pair.asLowerCase),
          ),
      ],
    );
  }
}
