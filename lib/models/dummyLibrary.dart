import 'package:flutter/material.dart';
import 'package:L2P/components/guideSection.dart';
import './gameData.dart';

/**
 * Game Data can be added like this for now:
 * new GameData(
 *  TITLE
 *  DESCRIPTION
 *  ACCENT COLOR
 * )
 */

final guideSections = List<GuideSection>.from([
  GuideSection(
    title: "Beginner Tutorial",
    body:
        "If you haven’t played before, we recommend playing through this guided tutorial first. You’ll need two players.",
    ordered: false,
    buttonTitles: List<String>.from(["Play Tutorial"]),
  ),
  GuideSection(
    title: "Setup",
    body: "Before you play, let's setup a few components.",
    ordered: true,
    buttonTitles:
        List<String>.from(["Setting up the board", "Do another thing"]),
  ),
  GuideSection(
    title: "Construction",
    body:
        "For the majority of the game, you'll construct buildings. There are a number of ways to do this.",
    ordered: true,
    buttonTitles: List<String>.from(
        ["Setting up the board", "Do another thing", "And another!"]),
  ),
  GuideSection(
    title: "Winning the game",
    body:
        "For the majority of the game, you'll construct buildings. There are a number of ways to do this.",
    ordered: true,
    buttonTitles: List<String>.from(
        ["Earning Victory Points", "Miliatary Victory", "Cultural Victory"]),
  ),
]);

final libraryData = [
  new GameData(
      '7_Wonders_Duel', // Title
      '7 Wonders Duel is a quick-fire, two-player variant of the hit game 7 Wonders. This guide will take you all the way from setup to playing through a full game, and contains a number of handy reference materials to keep your game going smoothly.',
      Color.fromRGBO(101, 212, 186, 1),
      List<String>.from(["Tag A", "Tag B"]),
      guideSections // Special Accent Color
      ),
  new GameData(
      'Fog_Of_Love',
      'This thematic roleplaying/board game hybrid will see you and your fellow players tell the story of the great city of Icarus. Will it prosper and grow under your leadership, or was it always doomed to fail? This easy guide gets you started with Icarus straight away.',
      Color.fromRGBO(101, 212, 186, 1),
      List<String>.from(["Tag A", "Tag B"]),
      guideSections),
  new GameData(
      'Marvel_Crisis_Protocol',
      'All your favorite heroes and villains from the Marvel universe clash in this epic tabletop tactics game. In this guide, we’ll help you play through your first demo game and provide some easy to use rules reference pages for the advanced concepts!',
      Color.fromRGBO(101, 212, 186, 1),
      List<String>.from(["Tag A", "Tag B"]),
      guideSections),
  new GameData(
      'Star_Realms',
      'Take to the stars and build your galactic empire in Star Realms! This guide helps you play the 2-player competitive game, as well as the new mechanics introduced in Frontiers, Gambit, and Unity.',
      Color.fromRGBO(101, 212, 186, 1),
      List<String>.from(["Tag A", "Tag B"]),
      guideSections),
  new GameData(
      'X-Wing_Miniatures',
      'Ready to jump into the least popular miniatures game this side of the galactic core? This advanced guide for Star Wars X-Wing will help you setup and play your first game, as well as provide a helpful rules reference.',
      Color.fromRGBO(101, 212, 186, 1),
      List<String>.from(["Tag A", "Tag B"]),
      guideSections),
  new GameData(
      'Sushi_Go!',
      'In Sushi Go!, you are eating at a sushi restaurant and trying to grab the best combination of sushi dishes as they whiz by. Score points for collecting the most sushi rolls or making a full set of sashimi.',
      Color.fromRGBO(101, 212, 186, 1),
      List<String>.from(["Tag A", "Tag B"]),
      guideSections),
  new GameData(
      'Secret_Hitler!',
      'Each player is randomly and secretly assigned to be a liberal or a fascist, and one player is Secret Hitler. The fascists coordinate to sow distrust and install their cold-blooded leader; the liberals must find and stop the Secret Hitler before it is too late.',
      Color.fromRGBO(101, 212, 186, 1),
      List<String>.from(["Tag A", "Tag B"]),
      guideSections),
];
