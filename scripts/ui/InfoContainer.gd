extends VBoxContainer

var playerData: PlayerData
var cost = 0

func init(mobTypes: MobTypes, playerData: PlayerData):
    self.playerData = playerData
    
    $WaveList.init(mobTypes)
    $MobInfo.init(mobTypes)
    $VBoxContainer2/AddMob.init(mobTypes)

func _process(delta):
    updateWaveButton()

func _on_WaveList_costChanged(newCost):
    cost = newCost
    $TotalCost.text = str("Total cost: $", round(newCost))

func updateWaveButton():
    var playerMoney = playerData.money
    $MarginContainer/HBoxContainer/StartWave.disabled = cost > playerMoney
