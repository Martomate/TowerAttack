extends Node2D

signal statusInfoChanged()

var mobTypes: MobTypes
var towerTypes: TowerTypes

var playerData = PlayerData.new()
var aiData = AIData.new()

var ai

func _ready():
    playerData.reset()
    aiData.reset()
    
    playerData.money = 400
    aiData.money = 600
    
    $MobTypeConfig.init()
    $TowerTypesConfig.init()
    
    mobTypes = $MobTypeConfig.mobTypes
    towerTypes = $TowerTypesConfig.towerTypes
    
    $Mobs.init(mobTypes)
    $Towers.init(towerTypes)
    
    loadLevel(1)
    $Mobs.initPath($Ground)
    $Ground.init()
    
    var towerManager = TowerManager.new(towerTypes)
    towerManager.connect("buildTower", self, "buildTower")
    ai = AI.new(TileMapAnalyzer.new($Ground), towerManager, aiData)

func _physics_process(delta):
    ai.update()

func loadLevel(level: int):
    $Ground.loadLevel(level)
    for y in range($Ground.HEIGHT):
        if $Ground.walkableAt(0, y):
            $Mobs.mobStartY = y
            $Ground.mobStartY = y
            break

func reducePlayerMoney(amt):
    playerData.money -= amt

func _on_Mobs_earnMoney(dm):
    playerData.money += dm
    playerData.score += dm
    emit_signal("statusInfoChanged")

func _on_Towers_moneyEarned(dm):
    aiData.money += dm
    emit_signal("statusInfoChanged")

func buildTower(idx: int, type):
    aiData.money -= type.price()
    $Towers.addTower(idx % $Ground.WIDTH, idx / $Ground.WIDTH, type)

func reset():
    _ready()

func _on_Mobs_mobHasInvaded():
    aiData.invaders += 1
    emit_signal("statusInfoChanged")
