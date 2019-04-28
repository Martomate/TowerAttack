extends MarginContainer

signal somethingChanged()

export(Texture) var icon
export(String, MULTILINE) var info setget set_info, get_info

var healthLevel = 0
var speedLevel = 0

var setup: MobSetup
var quantity: int

func _ready():
    $HBox/Icon.texture = icon
    $HBox/Info.text = info
    if setup != null:
        $HBox/Actions/Health.text = str(setup.maxHealth())
        $HBox/Actions/Speed.text = str(setup.speed())
        updateInfoText()
    else:
        $HBox/Actions.hide()

func set_info(newInfo):
    info = newInfo
    $HBox/Info.text = info

func get_info():
    return info

func _on_HealthPlus_pressed():
    setup.healthLevel += 1
    onHealthUpdated()

func _on_HealthMinus_pressed():
    setup.healthLevel -= 1
    onHealthUpdated()

func onHealthUpdated():
    $HBox/Actions/Health.text = str(setup.maxHealth())
    onChanged()


func _on_SpeedPlus_pressed():
    setup.speedLevel += 1
    onSpeedUpdated()

func _on_SpeedMinus_pressed():
    setup.speedLevel -= 1
    onSpeedUpdated()

func onSpeedUpdated():
    $HBox/Actions/Speed.text = str(setup.speed())
    onChanged()


func _on_Regen_toggled(button_pressed):
    setup.shouldRegen = button_pressed
    onChanged()

func _on_Reflect_toggled(button_pressed):
    setup.shouldReflect = button_pressed
    onChanged()

func _on_Dodge_toggled(button_pressed):
    setup.shouldDodge = button_pressed
    onChanged()

func updateInfoText():
    $HBox/Info.text = str("Amt: ", quantity, "\n1: $", round(setup.price()), "\n", quantity, ": $", round(setup.price() * quantity))

func onChanged():
    updateInfoText()
    emit_signal("somethingChanged")
