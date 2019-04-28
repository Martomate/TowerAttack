extends Tower

var line: Line2D
var target
var lineVisible = false

func _ready():
    line = Line2D.new()
    line.default_color = Color.red
    line.width = 2
    line.add_point(Vector2(32, 22))
    line.add_point(Vector2())

func _process(delta):
    var target
    if not mobsInSight.empty():
        target = mobsInSight.front()
    if target != null:
        if !lineVisible:
            lineVisible = true
            add_child(line)
        if not target.isDead:
            line.set_point_position(1, target.position - position)
            target.attack(power * delta, self)
            if target.isDead:
                emit_signal("killedMob", target)
    elif lineVisible:
        lineVisible = false
        remove_child(line)

func pickTarget():
    return mobsInSight.front()
