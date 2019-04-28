class_name Tower extends Node2D

signal killedMob(mob)

var images = preload("res://tilesets/TowerTiles.tres")

var xpos: int
var ypos: int
var type: TowerType

var mobsInSight: Array = []
var sightRange: float

var power = 80

func init(x: int, y: int, type: TowerType):
    self.xpos = x
    self.ypos = y
    self.type = type
    position = Vector2(x * 64, y * 64)
    $Sprite.texture = images.tile_get_texture(images.find_tile_by_name(type.name))
    setRange(2)

func setRange(distance: float):
    sightRange = distance * 64
    $VisionArea/Shape.shape.radius = sightRange

func onMobInSight(mob):
    pass

func onMobOutOfSight(mob):
    pass

func _on_VisionArea_area_entered(area):
    var mob = area.get_parent()
    if mob.is_in_group("mobs"):
        onMobInSight(mob)
        mobsInSight.append(mob)

func _on_VisionArea_area_exited(area):
    var mob = area.get_parent()
    if mob.is_in_group("mobs"):
        mobsInSight.erase(mob)
        onMobOutOfSight(mob)
