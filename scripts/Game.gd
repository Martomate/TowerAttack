extends Control

var mobTypes: MobTypes

func _ready():
    mobTypes = $World.mobTypes
    
    $SidePanel.init(mobTypes, $World.playerData)

func _on_World_statusInfoChanged():
    $HUD.updatePlayerData($World.playerData)
    $HUD.updateAIData($World.aiData)

func _on_SidePanel_startWave(wave):
    var cost = 0
    for mob in wave:
        cost += mob.price()
    $World.reducePlayerMoney(cost)
    $World/Mobs.spawnManyMobs(wave, 0.5)


func _on_HUD_resetGame():
    $World.reset()
    $SidePanel.reset()
