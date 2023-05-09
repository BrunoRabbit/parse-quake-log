// ignore_for_file: constant_identifier_names, camel_case_types
import 'dart:io';
import 'package:parse_quake_log/models/deaths.dart';
import 'package:parse_quake_log/models/game.dart';
import 'package:parse_quake_log/models/kills.dart';
import 'package:parse_quake_log/models/kills_by_means.dart';
import 'package:parse_quake_log/models/player.dart';
import 'package:parse_quake_log/models/round.dart';

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

  //! LOG QUAKE
  List<String> logQuake = File(path).readAsLinesSync();

  var newGame = [];
  var listGames = <Round>[];

  int scores = 0;
  int gameCount = 0;
  int ping = 0;
  int characterRoxIndex = 0;
  int endIndex = 0;

  String rowEnd = '';
  String rowStart = '';
  String playersName = '';

  late Game game;
  late Round round;
  late Kills kill;
  late KillsByMeans killsByMeans;
  late Deaths deaths;
  late int totalKills;

  for (int i = 0; i < logQuake.length; i++) {
    if (logQuake[i].contains(lineOut)) {
      continue;
    } else {
      if (logQuake[i].contains(types.InitGame.name)) {
        kill = Kills(kills: {});
        killsByMeans = KillsByMeans(killsByMeans: {});
        deaths = Deaths({});
        round = Round(0, [], kill, killsByMeans, deaths);
        game = Game(round, gameCount++);
        totalKills = 0;
        continue;
      } else if (logQuake[i].contains(types.score.name)) {
        // ! Find Players
        List rowLog = logQuake[i].split(' ').sublist(10);

        playersName = rowLog.where((element) => element.length > 1).join(' ');

        // ! Find Scores
        rowStart = types.score.name + ': ';
        rowEnd = types.ping.name;

        characterRoxIndex = logQuake[i].indexOf(rowStart);

        endIndex = logQuake[i].indexOf(
          rowEnd,
          characterRoxIndex + rowStart.length,
        );

        scores = int.parse(logQuake[i].substring(
          characterRoxIndex + rowStart.length,
          endIndex,
        ));

        // ! Find Ping
        rowStart = types.ping.name + ': ';
        rowEnd = types.client.name;

        characterRoxIndex = logQuake[i].indexOf(rowStart);

        endIndex = logQuake[i].indexOf(
          rowEnd,
          characterRoxIndex + rowStart.length,
        );

        ping = int.parse(logQuake[i].substring(
          characterRoxIndex + rowStart.length,
          endIndex,
        ));

        // ? Add Player
        round.players?.add(
          Player(playersName, scores, ping),
        );

        // ? Add Kills
        round.kills!.kills!.addAll({playersName: scores});

        continue;
      } else if (logQuake[i].contains(types.Kill.name)) {
        // ? Add TotalKills
        round.totalKills = totalKills++;

        // ! Find Kills by means
        List killsByMeansList = logQuake[i].split(' ').sublist(5);
        playersName =
            killsByMeansList.where((element) => element.length > 1).join(' ');

        rowStart = types.Kill.name + ': ';
        rowEnd = ' killed';

        String name = playersName.split(' ').removeLast();

        if (killsByMeans.killsByMeans.keys.contains(name)) {
          killsByMeans.killsByMeans[name] = killsByMeans.killsByMeans[name] + 1;
        } else {
          killsByMeans.killsByMeans[name] = 1;
        }

        // ? Add Kills by means
        killsByMeans.killsByMeans.addAll(killsByMeans.killsByMeans);

        // ! Find Player Death count

        String row = playersName;

        rowStart = 'killed ';
        rowEnd = ' by';

        characterRoxIndex = row.indexOf(rowStart);

        endIndex = row.indexOf(
          rowEnd,
          characterRoxIndex + rowStart.length,
        );

        String getDeaths = row.substring(
          characterRoxIndex + rowStart.length,
          endIndex,
        );

        if (round.deaths.deathMap.keys.contains(getDeaths)) {
          round.deaths.deathMap[getDeaths] =
              round.deaths.deathMap[getDeaths]! + 1;
        } else {
          round.deaths.deathMap[getDeaths] = 1;
        }

        continue;
      }

      // ! Print result
      if (game.game.players!.isNotEmpty) {
        print('${game.toMap()}');
        print('-----------------Ranking-----------------');
        List<String> keys = game.game.kills!.kills!.keys.toList();
        List<int> values = game.game.kills!.kills!.values.toList();

        List<int> deathListValues = round.deaths.deathMap.values.toList();
        List<String> deathListKey = round.deaths.deathMap.keys.toList();

        for (var j = 0; j < keys.length; j++) {
          for (var n = 0; n < deathListKey.length; n++) {
            if (keys[j] == deathListKey[n]) {
              print(
                "${j + 1}º ${keys[j]} with ${values[j]} kills and ${deathListValues[n]} deaths",
              );
            }
          }
        }
        print('\n');
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
