extends Panel

signal startWave(wave)

func init(mobTypes: MobTypes, playerData: PlayerData):
    $TabContainer/Waves/InfoContainer.init(mobTypes, playerData)

func _on_WaveList_startWave(wave):
    emit_signal("startWave", wave)

func reset():
    $TabContainer/Waves/InfoContainer/WaveList.reset()
