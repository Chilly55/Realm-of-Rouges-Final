# Plan for Ignatius

## High Priority

* Actors - have a way to store stats
  * Player Controller
    * Jumping
      * double jump with water container
    * Weapons
      * Weapon aiming via mouse
      * Fire Axe
      * Water hose
    * Able to pick up items
      * Power ups
      * The Impearled
  * Enemy
    * Slime
      * Needs to store water and burst into water projectiles
    * Goblin
      * Needs to be able to aim their flame spears and leave fire
* Item - an object that contains data for pick ups.
  * Abilities
    * Water Container - double jump
    * water Hose - allows for ranged attacks
  * Rescue items
    * People
    * Belongings
* Intractable
  * NPCs - to ask the player to rescue the people in the building
  * Water fountains - to refill the water container
* Cut scenes
  * Intro - could be text
  * Outro - could be text
  * Defeat - text

## Low priority

* Cutscene Manager - to control and create cutscenes using lists

## Hierarchy - Directory

This is the bare minimum.

* Info
  * Changelog
  * Notes - Not needed
  * Manual - Not needed
* Assets
  * Music
  * Sound Effects
  * Sprites
* Resources - These are a type of file created by Godot to store information
  * Items
    * Abilities
      * Fire Axe
      * Water Hose
      * Water container
    * Collectables
      * belongings
      * person
  * Actors
    * Player
    * Slime
    * Goblin
* Scenes
  * Actors
    * Player
    * Slime
    * Goblin
    * NPC
  * Intractable
    * Water fountain
  * Items
    * Abilities
    * Collectables
  * Levels
    * Level_1
  * CutScenes
    * Intro
    * Outro
  * Menues
    * MainMenu
    * Pause
    * GameOver
* Scripts
  * Resources
    * ActorResource
    * Ability Resource
    * Collectable Resource
  * Actors
    * Player
    * Slime
    * Goblin
    * NPC
  * Items
    * Abilities
    * Collectables
  * Levels
    * Level_1
  * CutScenes
    * Intro
    * Outro
  * Menues
    * MainMenu
    * Pause
    * GameOver
