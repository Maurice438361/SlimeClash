extends Node3D

func _ready():
	for rock in get_children():
		if rock is MeshInstance3D:
			var static_body = StaticBody3D.new()
			var collision = CollisionShape3D.new()

			collision.shape = rock.mesh.create_trimesh_shape()

			static_body.add_child(collision)
			rock.add_child(static_body)
