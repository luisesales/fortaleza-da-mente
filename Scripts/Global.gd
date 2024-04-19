extends Node

## Enum that determines the state of the game 
enum state {MENULOBBY, SEARCHING, GAMELOBBY, INGAME}

## Global variables for player 
@export var PLAYER_MOVE_SPEED = 500
@export var PLAYER_ACCELERATION = 2000
@export var PLAYER_FRICTION = 1200
