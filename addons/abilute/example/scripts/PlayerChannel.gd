extends Node

signal player_ready(player)
signal died

func broadcast_player_ready(player):
    player_ready.emit(player)

func die():
    died.emit()