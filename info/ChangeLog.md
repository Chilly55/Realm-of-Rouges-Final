# Change Log

Where changes are placed

## 1.0

* Game Complete

## 0.4.3

* Added gui sprites
* Added control hints

## 0.4.2

* Coyote Jump implemented

## 0.4.1

* Added victory screen that links to main menu

## 0.4

* New sprites added
	* Water contianer
	* In danger 
	* NPC
	* Axe
	* Hose
	* Spear
	* Slash
	* Goblin
	* Water
	* Fire
	* Fountain
* The player can now respawn at the starting point or any fountain touched
* goblins now have their sprites
* NPC has their sprite
* In danger npc's now have sprites
* all weapons now have sprites
* all projectiles now have sprites
* The water fountain now has a sprite

## 0.3.1

* The Npc now works

## 0.3

* added scene change button
* Projectiles now have damage, spawn, and collison sounds
* Goblin's spearns now make sounds
* Slimes will make sounds when hurt
* The dialouge player export was fixed
* the _on_npc_you_saved_everyone, added a pass to resolve conflicts
* The fountains will make sounds when giving water
* Added sfx

## 0.2.1
* Added NPC dialogue script
	* Added npc dialogue text apon first interaction and collectable completion 
	* Added ability for dailogue box to appear and diasapear when talking to npc


## 0.2.0

* created the signal bus
* Player can now get data from the map
  * The player's pointer will not fire if disabled
* Base map script created
* The Item holder will now emit a signal when it's a collevtable and is collected
* Created Level 1

## 0.1.11

* New walk sprites for the player
* Player head can follow the mouse
* Slime sprite created
* Slime sprite changed to new sprites

## 0.1.10

* Added NPC Placeholder Asset
* Added NPC IDlE
* Added NPC Dialogue box

## 0.1.9

* All actors now inherit from the actor base class
  * Player
  * Goblin
  * Slime
* All actors can now take damage
* The projectile's collison mask can now be assigned by the pointer

## 0.1.8

* Added goblin placeholder
* pointer is now completly seperate from the player
* Added unimplemented menues
* added fonts
	* Flames
	* Imortal

## 0.1.7

* the player can now use water
* the hose can now consume water
* Water fountain has been added

## 0.1.6

* added dev tileset for terrian

## 0.1.5

* Changed the collison layer of the player to be player instead of terrian
* fixed the capitalization
* The player can now pick up collectables and items

## 0.1.4

* Added slime enemy collision
* Slime will chase player in detection area 
* Added slime enemy walk, idle, and death animation

## 0.1.3

* Added ItemResource
	* Added Axe Item
	* Added Water Container Item
	* Added Water Hose Item
* Added Item Holder
* The player can now hold weapon items
* The player can now switch between weapons

## 0.1.2
* Added Slime enemy Sprite Animation 

## 0.1.1

* Added projectile resource
* player can now shoot different projectiles

## 0.1

* Added actor resource
* Added player
* Added pointer
* Added stats manager

