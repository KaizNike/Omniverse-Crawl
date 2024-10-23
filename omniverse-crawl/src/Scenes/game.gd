class_name Game
extends Node2D

const PLAYER_DEFINITION: EntityDefinition = preload("res://src/Entities/Actors/entity_definition_player.tres")

@onready var player: Entity
@onready var event_handler: EventHandler = $EventHandler
@onready var entities: Node2D = $Entities
@onready var map: Map = $Map

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player_start_pos: Vector2i = Grid.convert_world_to_grid(get_viewport_rect().size.floor() / 2)
	player = Entity.new(player_start_pos, PLAYER_DEFINITION)
	entities.add_child(player)
	var npc := Entity.new(player_start_pos + Vector2i.RIGHT,PLAYER_DEFINITION)
	npc.modulate = Color.ORANGE
	entities.add_child(npc)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var action: Action = event_handler.get_action()
	
	if action is MovementAction:
		player.move(action.offset)
	elif action is EscapeAction:
		get_tree().quit(33) ## 33 is good!
	
	pass


func get_map_data() -> MapData:
	return map.map_data
