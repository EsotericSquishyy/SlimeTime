extends Node

enum GameState {
    PLAYER,
    PLAYER_ANIM,
    ENEMY,
    ENEMY_ANIM
}

var tileMap : TileMap
var player : Node2D
var cursor : Node2D

var current_state: GameState = GameState.PLAYER
    
func init(tileMap : TileMap, player : Node2D, cursor : Node2D):
    self.tileMap = tileMap
    self.player = player
    self.cursor = cursor
    
func _process(_delta):
    cursor.position = tileMap.get_cursor_pos();
    
    match current_state:
        GameState.PLAYER:
            current_state = GameState.PLAYER;
        GameState.PLAYER_ANIM:
            current_state = GameState.PLAYER_ANIM;
        GameState.ENEMY:
            current_state = GameState.ENEMY;
        GameState.ENEMY_ANIM:
            current_state = GameState.ENEMY_ANIM;
