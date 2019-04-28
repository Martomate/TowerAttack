extends Control

signal resetGame()

func updatePlayerData(player: PlayerData):
    $Panel/Top/Margins1/HBox/PlayerInfo/Money.text = str("Money: $", round(player.money))
    $Panel/Top/Margins1/HBox/PlayerInfo/Score.text = str("Score: ", round(player.score))

func updateAIData(ai: AIData):
    $Panel/Top/Margins2/AIInfo/Money.text = str("AI money: $", round(ai.money))
    $Panel/Top/Margins2/AIInfo/Invaders.text = str("Invaders: ", ai.invaders)


func _on_Reset_pressed():
    emit_signal("resetGame")
