extends Camera2D

# This will be changed depending on what type of background is being used. 
@export var groundlayer : TileMapLayer 	# NEEDS TO BE SET IN INSPECTOR


func _ready():
	var map_rect = groundlayer.get_used_rect()
	var tile_size = groundlayer.rendering_quadrant_size
	var world_size_in_pixels = map_rect.size * tile_size
	
	# Set Limits of camera based on size of background
	limit_right = world_size_in_pixels.x
	limit_bottom = world_size_in_pixels.y
	#limit_top = -world_size_in_pixels.y
	#limit_bottom = -world_size_in_pixels.x
