# My first Godot game

![Pixel Enemy Slayer](/banner.svg)

I finally decided to try out Godot. This game builds on what the amazing [Brackeys](https://www.youtube.com/@Brackeys/videos) started in this [tutorial](https://www.youtube.com/watch?v=LOhfqjmasi0&t). I improved the game by adding menus, more levels, the ability to hit enemies with a sword, a shield, double jumps, particle effects, and more.

I was surprised by how light and easy-to-use the Godot engine is. I also liked coding in GDScript because it’s similar to Python.

Overall, I had a lot of fun working on this project! Here are some of the things that I added to the original game.

## Menus

I have added menus to the game. The start menu appears after launching the game.

![start_menu](/images/start_menu.png)

Clicking on the start game button moves to the other menu that allows the users to select a level they want to play

![level_menu](/images/level_menu.png)

The controls button shows the actions that the player can perform in the game

![controls_menu](/images/controls_menu.png)

Clicking on the settings button shows the settings menu where users can control the sound level of the game and sound effects.

![settings_menu](/images/settings_menu.png)

Finally, when clicking on the exit button, the game closes.

When starting to play a level, you will notice that I added in game UI. It shows the amount of coins that you collected, the shield icon, and the pause button

![in_game_ui](/images/in_game_ui.png)

When hovering on the shield icon, a tooltip will be displayed with some information about the shield ability.

![shield_tooltip](/images/shield_tooltip.png)

Clicking on the pause button shows the pause menu. It allows you to quit the level if you want.

![pause_menu](/images/pause_menu.png)

If you die in the game, the game over menu is shown

![game_over_ui](/images/game_over_ui.png)

Finally, if you win, the win menu is displayed. It allows you to advance to the next level or go back to the main menu.

![win_menu](/images/win_menu.png)

## Slime flavours

I have created many flavours of the cute slime monster, ice, hell, and regular.

![slime_flavor](/images/slime_flavours.svg)

## Slime balls

Slimes can shoot slime balls on the player.
https://github.com/user-attachments/assets/e047d817-c3ef-485b-a5d5-029415b5dbb1

## Jumping

I have allowed the player to double jump instead of just performing one single jump. I have also added a jumping effect that plays whenever the player jumps.
https://github.com/user-attachments/assets/84a4966a-8026-44ef-8552-fa79b873fe57

## Sword

Since I have given slimes a weapon, I thought why not give the player a sword.
https://github.com/user-attachments/assets/b5109be3-e547-4448-87ab-f7146e20423a

When a slime is hit by the sword it explodes
https://github.com/user-attachments/assets/598fbd53-f3f9-419a-9d17-54990b5feb72

## Shield

This is a special ability that the player can use, it allows them to be safe for 5 seconds. Since this ability is very powerful, I decided to make it usable only once.
https://github.com/user-attachments/assets/e2280781-cc25-4332-a630-508d49507037

## Inverted gravity

In the third level, I decided to invert the gravity at some point.
https://github.com/user-attachments/assets/4c9aded9-8748-4030-951b-4851f72c9396

## Ladder climbing

In the presence of a ladder, the player can use up and down arrow keys to interact with the ladder.
https://github.com/user-attachments/assets/15dc3cd3-153c-40cb-b6da-5f0cf17603f4

## Jump off a platform

The player can use the down arrow key to jump off a platform quickly.
https://github.com/user-attachments/assets/6b22db68-0079-4287-a689-30a6fc8fd495

## Walking effect

I have added an effect when the player moves.
https://github.com/user-attachments/assets/91db87d8-6e35-4985-9dba-d8b484dafa12

## Saving the player's progress

The player's progress is saved and can be seen in the levels menu.

![level_menu_progress](/images/level_menu.png)
