extends Path2D

signal earnMoney(money)
signal mobHasInvaded()

var packedMob = preload("res://scenes/Mob.tscn")

export var MoneyPerMob = 1.0

var mobTypes: MobTypes

var mobs = []
var mobStartY = 0

func init(mobTypes: MobTypes):
    reset()
    self.mobTypes = mobTypes

func initPath(tiles: Ground):
    var startY = mobStartY
    curve.add_point(Vector2(-32, startY * 64 + 32))
    var cx = 0
    var cy = startY
    var px = -1
    var py = startY
    while (cx > -1 && cx < tiles.WIDTH && cy > -1 && cy < tiles.HEIGHT):
        var dx = [1, 0, -1, 0]
        var dy = [0, 1, 0, -1]
        var found = false
        for i in range(4):
            var xx = cx + dx[i]
            var yy = cy + dy[i]
            if ((xx != px || yy != py) && tiles.walkableAt(xx, yy)):
                curve.add_point(Vector2(xx * 64 + 32, yy * 64 + 32))
                px = cx
                py = cy
                cx = xx
                cy = yy
                found = true
                break
        if !found:
            break
    var nx = cx + (cx - px)
    var ny = cy + (cy - py)
    curve.add_point(Vector2(nx * 64 + 32, ny * 64 + 32))

func _physics_process(delta):
    for mob in mobs:
        mob.updateMob(delta)
        if mob.isFinished:
            despawnMob(mob)
            emit_signal("mobHasInvaded")
        elif mob.isDead:
            despawnMob(mob)
    
    var money = 0
    for mob in mobs:
        money += mob.health
    money *= MoneyPerMob * delta
    
    emit_signal("earnMoney", money)

func despawnMob(mob):
    mobs.erase(mob)
    remove_child(mob)

func spawnMob(setup: MobSetup):
    var mob = packedMob.instance()
    mob.init(setup)
    mob.add_to_group("mobs")
    mob.setType(setup.type)
    mobs.append(mob)
    add_child(mob)

var mobsToSpawn = []

func spawnManyMobs(mobs: Array, timerInterval: float):
    for mob in mobs:
        mobsToSpawn.append(mob)
    if $SpawnTimer.is_stopped():
        $SpawnTimer.start(timerInterval)

func _on_SpawnTimer_timeout():
    if (mobsToSpawn.size() > 0):
        var mob = mobsToSpawn.front()
        mobsToSpawn.pop_front()
        spawnMob(mob)
    else:
        $SpawnTimer.stop()

func reset():
    curve.clear_points()
    for mob in mobs:
        remove_child(mob)
    mobs.clear()
