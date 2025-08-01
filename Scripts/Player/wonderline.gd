class_name Wonderline extends Node2D


@export var line_gradient : Gradient

@export var _line : Line2D
var _width := 5.0

var _segments : Node2D
var _loops : Node2D

var _points : PackedVector2Array = PackedVector2Array()
@export var max_points : float = 200
@export var _max_distance: float = 0

var drawing : bool = false
var looped : bool = false
var looped_segment
var looped_points = PackedVector2Array()
var captured_enemies = []

func _ready() -> void:
	#_line = Line2D.new()
	#_line.name = "_line"
	#_line.gradient = line_gradient
	#_line.width = 5
	#add_child(_line)
	_segments = Node2D.new()
	_segments.name = "_segments"
	add_child(_segments)
	_loops = Node2D.new()
	_loops.name = "_loops"
	add_child(_loops)

func _physics_process(delta: float) -> void:
	global_position = Vector2.ZERO
	global_rotation = 0
	if drawing:
		add_position(get_parent().global_position)


func add_position(pos : Vector2) -> void:
	var point_count := _points.size()
	if point_count == 0:
		_points.append(pos)
		_points.append(pos)
		add_segment(pos, pos)
	elif point_count == 1:
		_points.append(pos)
		add_segment(_points[-2], pos)
	elif point_count > max_points:
		purge(point_count - max_points)
	else:
		if _points[-2].distance_to(pos) > _max_distance:
			_points.append(pos)
			add_segment(_points[-2], pos)
		else:
			_points[-1] = pos
			change_segment(_points[-2], pos)

	_line.points = _points
	process_loop()

func add_segment(start:Vector2, end:Vector2) -> void:
	var points := rotated_rectangle_points(start, end, _width)
	var segment := Area2D.new()
	var collision := create_collision_polygon(points)
	segment.add_child(collision)
	_segments.add_child(segment)

func change_segment(start:Vector2, end:Vector2) -> void:
	var points := rotated_rectangle_points(start, end, _width)
	var segment := (_segments.get_child(_segments.get_child_count() - 1) as Area2D)
	var collision := (segment.get_child(0) as CollisionPolygon2D)
	collision.set_polygon(points)

func rotated_rectangle_points(start:Vector2, end:Vector2, width:float) -> Array:
	var diff := end - start
	var normal := diff.rotated(TAU/4).normalized()
	var offset := normal * width * 0.5
	return [start + offset, start - offset, end - offset, end + offset]

func create_collision_polygon(points:Array) -> CollisionPolygon2D:
	var result := CollisionPolygon2D.new()
	result.set_polygon(points)
	return result

func total_purge() -> void:
	purge(_points.size())
	purge_loops()
	looped = false
	looped_points.clear()
	
func purge(index:int) -> void:
	var segments := _segments.get_children()
	for _index in range(0, index):
		if _points.size() > 0:
			_points.remove_at(0)
		if segments.size() > 0:
			_segments.remove_child(segments[0])
			segments[0].queue_free()
			segments.remove_at(0)
	
	_line.points = _points

func purge_loops() -> void:
	for loop in _loops.get_children():
		if is_instance_valid(loop):
			loop.queue_free()

func process_loop() -> void:
	var segments := _segments.get_children()
	for index in range(segments.size() - 1, 0, -1):
		var segment:Area2D = segments[index]
		var candidates := segment.get_overlapping_areas()
		for candidate in candidates:
			var candidate_index := segments.find(candidate)
			if candidate_index == -1:
				continue
			
			
			elif abs(candidate_index - index) > 2:
				if looped:
					if !looped_segment:
						looped = false
						print("No longer Looped")
					return
				looped = true
				looped_segment = candidate
				print("Looped")
				push_loop(candidate_index, index)
				#purge(index)
				return

func push_loop(first_index:int, second_index:int) -> void:
	looped_points.clear()
	
	var loop := Area2D.new()
	
	for point_index in _points.size():
		if point_index >= first_index + 1:
			looped_points.append(_points[point_index])
		#points.remove_at(0)
	
	var collision := create_collision_polygon(looped_points)
	loop.add_child(collision)
	_loops.add_child(loop)


func check_for_capture() -> void:
	if looped:
		for loop in _loops.get_children():
			for i in loop.get_overlapping_bodies():
				if i.is_in_group("Enemy"):
					print(i.name, " is Looped")
		#for i in get_tree().get_nodes_in_group("Enemy"):
			#if Geometry2D.is_point_in_polygon(i.global_position, looped_points):
				#print(i.name," is Looped")
