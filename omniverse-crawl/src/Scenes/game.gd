class_name Game
extends Node2D

const PLAYER_DEFINITION: EntityDefinition = preload("res://src/Entities/Actors/entity_definition_player.tres")

@onready var player: Entity
@onready var event_handler: EventHandler = $EventHandler
@onready var entities: Node2D = $Entities
@onready var map: Map = $Map
@onready var camera: Camera2D = $Camera2D
@onready var torch: PointLight2D = $PointLight2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = Entity.new(Vector2i.ZERO, PLAYER_DEFINITION)
	entities.add_child(player)
	camera.reparent(player)
	torch.reparent(player)
	torch.offset = Vector2i(player.texture.get_size()/2)
	#var npc := Entity.new(player_start_pos + Vector2i.RIGHT,PLAYER_DEFINITION)
	#npc.modulate = Color.ORANGE
	#entities.add_child(npc)
	map.generate(player)
	map.update_fov(player.grid_position)


func _physics_process(delta: float) -> void:
	var action: Action = event_handler.get_action()
	if action:
		var previous_player_position: Vector2i = player.grid_position
		action.perform(self,player)
		if player.grid_position != previous_player_position:
			map.update_fov(player.grid_position)


func get_map_data() -> MapData:
	return map.map_data
