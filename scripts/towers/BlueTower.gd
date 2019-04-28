extends Tower

var packetBullet = preload("res://scenes/Bullet.tscn")

var shootingSpeed = 4
var bulletSpeed = 200

func shootAt(mob):
    var center = self.position + Vector2(32, 32)
    var futureMobPos = mob.position
    var dir = futureMobPos - center
    var travelTime: float
    for i in range(4):
        var dist = dir.length()
        travelTime = dist / bulletSpeed
        futureMobPos = mob.futurePosition(travelTime)
        dir = futureMobPos - center
    if travelTime < self.sightRange / bulletSpeed:
        var bullet = packetBullet.instance()
        bullet.init("blueBullet", 4, self.sightRange / bulletSpeed, dir * (bulletSpeed / dir.length()))
        bullet.connect("hit", self, "onBulletHit")
        bullet.position = Vector2(32, 32)
        call_deferred("add_child", bullet)
        return true
    else:
        return false

func onBulletHit(bullet, mob):
    if mob != null:
        mob.attack(self.power / shootingSpeed, self)
        if mob.isDead:
            emit_signal("killedMob", mob)
    call_deferred("remove_child", bullet)

func onMobInSight(mob):
    if self.mobsInSight.empty() && $ShootingTimer.is_stopped():
        $ShootingTimer.start(1.0 / shootingSpeed)
        shootAt(mob)

func onMobOutOfSight(mob):
    if mobsInSight.empty() && not $ShootingTimer.is_stopped():
        $ShootingTimer.stop()

func _on_ShootingTimer_timeout():
    for mob in mobsInSight:
        if shootAt(mob):
            break
