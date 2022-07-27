// ignore_for_file: constant_identifier_names, unused_import

import 'dart:convert';
import 'dart:io';
import "package:collection/collection.dart";

import 'package:test_cloudwalk/models/game.dart';
import 'package:test_cloudwalk/models/kills.dart';
import 'package:test_cloudwalk/models/kills_by_means.dart';
import 'package:test_cloudwalk/models/player.dart';
import 'package:test_cloudwalk/models/round.dart';

const lineOut = '------------------------------------------------------------';
// 26  0:00 ------------------------------------------------------------
enum types {
  ShutdownGame,
  InitGame,
  Kill,
  ClientUserinfoChanged,
  score,
  ping,
  client,
}

void main() {
  const String path = './data/qgames.log';

  //get LOG QUAKE
  List<String> logQuake = File(path).readAsLinesSync();
  var newGame = [];

  List listNomes = <String>[];
  var listGames = <Round>[];

  int scores = 0;
  int gameCount = 0;
  int ping = 0;
  int startIndex = 0;
  int endIndex = 0;

  String nameEnd = '';
  String nameStart = '';
  String playersName = '';

  late Game game;
  late Round round;
  late Kills kill;
  late KillsByMeans killsByMeans;

  for (int i = 0; i < logQuake.length; i++) {
    if (logQuake[i].contains(lineOut)) {
      continue;
    } else {
      if (logQuake[i].contains(types.InitGame.name)) {
        kill = Kills(kills: {});
        killsByMeans = KillsByMeans(killsByMeans: {});
        round = Round(0, [], kill, [], killsByMeans);
        game = Game({round}, gameCount++);
        continue;
      } else if (logQuake[i].contains(types.score.name)) {
        // Find Players
        List newName = logQuake[i].split(' ').sublist(10);

        playersName = newName.where((element) => element.length > 1).join(' ');

        //Find Scores
        nameStart = types.score.name + ': ';
        nameEnd = types.ping.name;

        startIndex = logQuake[i].indexOf(nameStart);

        endIndex = logQuake[i].indexOf(nameEnd, startIndex + nameStart.length);

        scores = int.parse(logQuake[i].substring(
          startIndex + nameStart.length,
          endIndex,
        ));

        // Find Ping
        nameStart = types.ping.name + ': ';
        nameEnd = types.client.name;

        startIndex = logQuake[i].indexOf(nameStart);

        endIndex = logQuake[i].indexOf(nameEnd, startIndex + nameStart.length);

        ping = int.parse(logQuake[i].substring(
          startIndex + nameStart.length,
          endIndex,
        ));

        round.players?.add(Player(playersName, scores, ping));

        continue;
      } else if (logQuake[i].contains(types.Kill.name)) {
        List _equalList = listNomes;

        //Find Kills
        List newName = logQuake[i].split(' ').sublist(5);
        playersName = newName.where((element) => element.length > 1).join(' ');

        nameStart = ': ';
        nameEnd = ' killed';

        startIndex = playersName.indexOf(nameStart);

        endIndex = playersName.indexOf(nameEnd, startIndex + nameStart.length);

        String getName = playersName.substring(
          startIndex + nameStart.length,
          endIndex,
        );

        if (getName != '<world>') {
          listNomes.add(getName);
          for (String nome in listNomes) {
            if (nome == getName) {
              kill.kills!.addAll({nome: 0});
            }
            if (listNomes.any((item) => nome.contains(item))) {
              // kill.kills!.map((key, value) {
              //   Kills.fromMap({key: value + 1});
              // });

              // kill.kills![e] = kill.kills![e] ?? playerKillCount++;

              // round.kills?.addAll({getName: kill.kills![e]!});
            }
          }
        }
        switch (logQuake[i].contains(types.Kill.name)) {
          case true:
            List newName = logQuake[i].split(' ').sublist(5);
            playersName =
                newName.where((element) => element.length > 1).join(' ');
            // print(playersName);
            nameStart = types.Kill.name + ': ';
            nameEnd = ' killed';

            killsByMeans.killsByMeans
                .addAll({playersName.split(' ').removeLast(): 0});
            break;
          default:
        }
        continue;
      }

      if (game.game
          .where((element) => element.players!.isNotEmpty)
          .isNotEmpty) {
        print(game.toMap());
      }

      newGame.add(logQuake);
      if (logQuake[i].contains(types.ShutdownGame.name)) {
        listGames.add(round);
      }
      if (logQuake[i].contains(lineOut)) {
      } else {
        newGame.add(logQuake[i]);
      }
    }
  }
}
