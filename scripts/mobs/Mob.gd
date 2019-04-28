extends PathFollow2D

var images = preload("res://tilesets/MobImages.tres")

var isFinished = false
var isDead = false

var maxHealth = 100
var health = maxHealth

var maxSpeed = 120

var type: MobType
var setup: MobSetup

var canRegen = true
var canReflect = true
var canDodge = true

func init(setup: MobSetup):
    self.setup = setup
    self.type = setup.type
    maxSpeed = setup.speed()
    maxHealth = setup.maxHealth()
    health = maxHealth

func _ready():
    $Health.max_value = maxHealth
    $Health.value = health
    pass

func futurePosition(dt: float):
    var oldOffset = offset
    offset += dt * maxSpeed
    var futurePos = Vector2(position.x, position.y)
    offset = oldOffset
    return futurePos

func updateMob(delta):
    if _canRegenNow():
        health += setup.RegenSpeed * maxHealth / 100
    
    health = clamp(health, 0, maxHealth)
    $Health.value = health
    
    fixRotation()
    
    offset += maxSpeed * delta
    if unit_offset >= 1:
        isFinished = true

func fixRotation():
    var posNow = position
    offset += 32
    var posFut = position
    offset -= 32
    var direction = posFut - posNow
    $Area/Sprite.rotation = atan2(direction.y, direction.x)

func setType(type: MobType):
    var textureId = images.find_tile_by_name(type.name)
    if textureId != -1:
        $Area/Sprite.texture = images.tile_get_texture(textureId)

func attack(power: float, tower):
    health -= power
    if health <= 0:
        isDead = true

func _on_Area_body_entered(body):
    if body.is_in_group("bullet"):
        if _canReflectNow():
            body.linear_velocity *= -1
            afterReflect()
        elif _canDodgeNow():
            var dir = (round(randf()) * 2 - 1) * 25
            offset += dir
            afterDodge()
        else:
            body.mobWasHit(self)

func _canRegenNow():
    return setup.shouldRegen && canRegen

func _canReflectNow():
    return setup.shouldReflect && canReflect

func _canDodgeNow():
    return setup.shouldDodge && canDodge


func afterReflect():
    canReflect = false
    $Timers/EnableReflect.start(setup.ReflectTime)

func afterDodge():
    canDodge = false
    $Timers/EnableDodge.start(setup.DodgeTime)


func _on_StartRegen_timeout():
    canRegen = true

func _on_EnableReflect_timeout():
    canReflect = true

func _on_EnableDodge_timeout():
    canDodge = true
