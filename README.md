# parse_quake_log

:warning: **IMPORTANT**: 
   
   - For better viewing the commetaries, use the extension for Visual Studio Code `Better Comments` 
   - This project is a challenge for a certain company, as a means of respect for the company and the future people who will join it, I will not disclose the name of the company.

## What Tasks did I do from the challenge

   - I did everything asked in the repository, but I changed some information about `Players`, instead of being a **List** it is a             **Map** where it lists the player's name, his score and his ping at the end of the game
   - I did this because two reasons, first i like to innovate and second i believed i could learn more, and i did it

## What response will be show up
   - An example of a JSON from the last game and his ranking:
 ```json
   {
   "game_20":{
      "totalKills":130,
      "players":[
         {
            "name":"Oootsimo",
            "score":20,
            "ping":8
         },
         {
            "name":"Zeh",
            "score":19,
            "ping":14
         },
         {
            "name":"Isgalamido",
            "score":17,
            "ping":1
         },
         {
            "name":"Assasinu Credi",
            "score":13,
            "ping":0
         },
         {
            "name":"Dono da Bola",
            "score":10,
            "ping":8
         },
         {
            "name":"Mal",
            "score":6,
            "ping":19
         }
      ],
      "kills":{
         "Oootsimo":20,
         "Zeh":19,
         "Isgalamido":17,
         "Assasinu Credi":13,
         "Dono da Bola":10,
         "Mal":6
      },
      "killsByMeans":{
         "MOD_ROCKET":37,
         "MOD_TRIGGER_HURT":14,
         "MOD_RAILGUN":9,
         "MOD_ROCKET_SPLASH":60,
         "MOD_MACHINEGUN":4,
         "MOD_SHOTGUN":4,
         "MOD_FALLING":3
      }
   }
}
```
     --------------------Ranking--------------------
    1º Oootsimo with 20 kills and 18 deaths
    2º Zeh with 19 kills and 15 deaths
    3º Isgalamido with 17 kills and 19 deaths
    4º Assasinu Credi with 13 kills and 30 deaths
    5º Dono da Bola with 10 kills and 19 deaths
    6º Mal with 6 kills and 30 deaths

## Run the project

   First of all, clone the project and then open your terminal and copy & paste this code <code>flutter pub get</code>

   Run properly you have to add in your terminal these commands <code>cd lib</code> and <code>dart run main.dart</code>

   You need to create inside the lib file, the data folder and have the .log file to work
