// test/screens/map_screen_test.dart
//
// Widget tests do screen de Mapa (filtros, toggle, lista "Nearby Players",
// botões Challenge/Message, bottom nav e painel arrastável).
//
// O mapa real (flutter_map) é substituído por um stub via `mapBuilder`,
// para os testes não dependerem de rede nem de tiles.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';

// Ajusta estes imports ao `name:` do teu pubspec.yaml e à tua estrutura.
import 'package:tcmatcher/models/player.dart';
import 'package:tcmatcher/models/tcg_game.dart';
import 'package:tcmatcher/screens/map_screen.dart';
import 'package:tcmatcher/widgets/map/game_filter_chips.dart';
import 'package:tcmatcher/widgets/map/player_card.dart';

// ---------------------------------------------------------------------------
// Dados de teste
// ---------------------------------------------------------------------------

const _pokemon = TcgGame(name: 'Pokémon', color: Color(0xFF2A7F7F));
const _magic = TcgGame(name: 'Magic', color: Color(0xFF4B3FA0));
const _yugioh = TcgGame(name: 'Yu-Gi-Oh!', color: Color(0xFF6B2FA0));
const _onePiece = TcgGame(name: 'One Piece', color: Color(0xFF3A3A8C));

final _mika = Player(
  id: '1',
  username: 'MikaCards',
  distanceMeters: 300,
  isReady: true,
  games: const [_pokemon, _magic],
  position: LatLng(38.7223, -9.1393),
);

final _theo = Player(
  id: '2',
  username: 'TheoDraws',
  distanceMeters: 650,
  isReady: true,
  games: const [_yugioh, _onePiece],
  position: LatLng(38.7230, -9.1380),
);

// Não está "ready": só aparece com o toggle "Available to Play" desligado.
final _sora = Player(
  id: '3',
  username: 'SoraPlays',
  distanceMeters: 900,
  isReady: false,
  games: const [_magic],
  position: LatLng(38.7210, -9.1400),
);

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

/// Último conjunto de jogadores que o screen passou ao mapa.
List<Player> _playersOnMap = [];

Future<void> _pumpMapScreen(
  WidgetTester tester, {
  List<Player>? players,
  ValueChanged<Player>? onChallenge,
  ValueChanged<Player>? onMessage,
}) async {
  // Tamanho do design (776x1684 @2x ≈ 388x842 dp).
  tester.view.physicalSize = const Size(776, 1684);
  tester.view.devicePixelRatio = 2.0;
  addTearDown(tester.view.reset);

  _playersOnMap = [];

  await tester.pumpWidget(
    MaterialApp(
      // theme: AppTheme.dark, // descomenta se o screen depender do teu tema
      home: MapScreen(
        players: players ?? [_mika, _theo, _sora],
        mapBuilder: (context, visiblePlayers) {
          _playersOnMap = visiblePlayers;
          return const ColoredBox(color: Colors.black);
        },
        onChallenge: onChallenge,
        onMessage: onMessage,
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Finder _card(String username) => find.ancestor(
      of: find.text(username, skipOffstage: false),
      matching: find.byType(PlayerCard, skipOffstage: false),
    );

Finder _inCard(String username, String text) => find.descendant(
      of: _card(username),
      matching: find.text(text, skipOffstage: false),
    );

Finder _chip(String label) => find.descendant(
      of: find.byType(GameFilterChips),
      matching: find.text(label),
    );

// ---------------------------------------------------------------------------
// Testes
// ---------------------------------------------------------------------------

void main() {
  group('Estrutura do screen', () {
    testWidgets('mostra a barra de pesquisa', (tester) async {
      await _pumpMapScreen(tester);

      expect(find.text('Find players or stores'), findsOneWidget);
    });

    testWidgets('mostra os chips de filtro por jogo', (tester) async {
      await _pumpMapScreen(tester);

      for (final label in ['All', 'Pokémon', 'Yu-Gi-Oh!', 'Magic', 'One Piece']) {
        expect(_chip(label), findsOneWidget, reason: 'chip "$label" em falta');
      }
    });

    testWidgets('"Available to Play" começa ligado', (tester) async {
      await _pumpMapScreen(tester);

      expect(find.text('Available to Play'), findsOneWidget);
      expect(tester.widget<Switch>(find.byType(Switch)).value, isTrue);
    });

    testWidgets('mostra as 4 tabs da bottom nav', (tester) async {
      await _pumpMapScreen(tester);

      for (final label in ['Map', 'Community', 'Events', 'Profile']) {
        expect(
          find.descendant(
            of: find.byType(NavigationBar),
            matching: find.text(label),
          ),
          findsOneWidget,
          reason: 'tab "$label" em falta',
        );
      }
    });
  });

  group('Nearby Players', () {
    testWidgets('mostra o título e o contador de jogadores visíveis',
        (tester) async {
      await _pumpMapScreen(tester);

      expect(find.text('Nearby Players'), findsOneWidget);
      // Toggle ligado => só os 2 jogadores READY.
      expect(find.text('2 nearby'), findsOneWidget);
    });

    testWidgets('cada card mostra nome, distância, READY e tags de jogos',
        (tester) async {
      await _pumpMapScreen(tester);

      expect(_inCard('MikaCards', '300m away'), findsOneWidget);
      expect(_inCard('MikaCards', 'READY'), findsOneWidget);
      expect(_inCard('MikaCards', 'Pokémon'), findsOneWidget);
      expect(_inCard('MikaCards', 'Magic'), findsOneWidget);

      expect(_inCard('TheoDraws', '650m away'), findsOneWidget);
      expect(_inCard('TheoDraws', 'Yu-Gi-Oh!'), findsOneWidget);
      expect(_inCard('TheoDraws', 'One Piece'), findsOneWidget);
    });

    testWidgets('Challenge chama o callback com o jogador certo',
        (tester) async {
      Player? challenged;
      await _pumpMapScreen(tester, onChallenge: (p) => challenged = p);

      await tester.tap(_inCard('MikaCards', 'Challenge'));
      await tester.pump();

      expect(challenged?.id, _mika.id);
    });

    testWidgets('Message chama o callback com o jogador certo', (tester) async {
      Player? messaged;
      await _pumpMapScreen(tester, onMessage: (p) => messaged = p);

      // O segundo card pode estar fora da área visível do painel.
      await tester.ensureVisible(_inCard('TheoDraws', 'Message'));
      await tester.pumpAndSettle();
      await tester.tap(_inCard('TheoDraws', 'Message'));
      await tester.pump();

      expect(messaged?.id, _theo.id);
    });

    testWidgets('arrastar o painel para cima expande-o', (tester) async {
      await _pumpMapScreen(tester);

      final before = tester.getTopLeft(find.text('Nearby Players')).dy;

      await tester.drag(find.byType(PlayerCard).first, const Offset(0, -300));
      await tester.pumpAndSettle();

      final after = tester.getTopLeft(find.text('Nearby Players')).dy;
      expect(after, lessThan(before));
    });
  });

  group('Filtros', () {
    testWidgets('chip "Magic" esconde jogadores sem Magic', (tester) async {
      await _pumpMapScreen(tester);

      await tester.tap(_chip('Magic'));
      await tester.pumpAndSettle();

      expect(find.text('MikaCards'), findsOneWidget);
      expect(find.text('TheoDraws'), findsNothing);
      expect(find.text('1 nearby'), findsOneWidget);
    });

    testWidgets('chip "All" repõe todos os jogadores', (tester) async {
      await _pumpMapScreen(tester);

      await tester.tap(_chip('Magic'));
      await tester.pumpAndSettle();
      await tester.tap(_chip('All'));
      await tester.pumpAndSettle();

      expect(find.text('MikaCards'), findsOneWidget);
      expect(find.text('TheoDraws', skipOffstage: false), findsOneWidget);
    });

    testWidgets('desligar "Available to Play" mostra jogadores não ready',
        (tester) async {
      await _pumpMapScreen(tester);

      expect(find.text('SoraPlays', skipOffstage: false), findsNothing);

      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();

      expect(find.text('SoraPlays', skipOffstage: false), findsOneWidget);
      expect(find.text('3 nearby'), findsOneWidget);
    });

    testWidgets('o mapa recebe a mesma lista filtrada que o painel',
        (tester) async {
      await _pumpMapScreen(tester);
      expect(_playersOnMap.map((p) => p.username),
          unorderedEquals(['MikaCards', 'TheoDraws']));

      await tester.tap(_chip('Magic'));
      await tester.pumpAndSettle();

      expect(_playersOnMap.map((p) => p.username), ['MikaCards']);
    });
  });

  group('Estados limite', () {
    testWidgets('sem jogadores mostra 0 nearby e nenhum card', (tester) async {
      await _pumpMapScreen(tester, players: const []);

      expect(find.text('0 nearby'), findsOneWidget);
      expect(find.byType(PlayerCard), findsNothing);
    });
  });
}