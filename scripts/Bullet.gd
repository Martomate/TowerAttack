extends RigidBody2D

signal hit(bullet, mob)

var lifeLeft: float

func init(type: String, radius, lifeLength: float, velocity: Vector2):
    $Sprite.texture = load("res://images/bullets/" + type + ".png")
    $Collider.shape.radius = radius
    lifeLeft = lifeLength
    linear_velocity = velocity

func _process(delta):
    lifeLeft -= delta
    if lifeLeft <= 0:
        emit_signal("hit", self, null)

func mobWasHit(mob):
    if mob.is_in_group("mobs"):
        emit_signal("hit", self, mob)
