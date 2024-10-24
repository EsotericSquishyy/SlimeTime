extends Node

enum GameState {
    PLAYER,
    ANIM_PLAYER,
    ENEMY,
    ANIM_ENEMY
}

var current_state: GameState = GameState.PLAYER

func _ready():
    set_process(true)

func _process(_delta):
    match current_state:
        GameState.PLAYER:
            handle_player_phase()
        GameState.ANIM_PLAYER:
            handle_animation_phase()
        GameState.ENEMY:
            handle_enemy_phase()
        GameState.ANIM_ENEMY:
            handle_enemy_animation_phase()

func handle_player_phase():
    # ...
    current_state = GameState.ANIM_PLAYER

func handle_animation_phase():
    # ...
    current_state = GameState.ENEMY

func handle_enemy_phase():
    # ...
    current_state = GameState.ANIM_ENEMY

func handle_enemy_animation_phase():
    # ...
    current_state = GameState.PLAYER

