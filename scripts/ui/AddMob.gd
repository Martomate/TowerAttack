extends HBoxContainer

signal addMobsToWave(type, quantity)

var mobTypes: MobTypes

func init(mobTypes: MobTypes):
    self.mobTypes = mobTypes

func _ready():
    var blueTex = load("res://images/mobs/blue.png")
    var yellowTex = load("res://images/mobs/yellow.png")
    $Icon.add_icon_item(blueTex, "", 0)
    $Icon.add_icon_item(yellowTex, "", 1)

func _on_Add_pressed():
    var qty = int($TheRest/Quantity.text)
    if qty > 0:
        $TheRest/Quantity.text = ""
        updatePrice()
        var type = selectedType()
        var setup = MobSetup.new()
        setup.type = mobTypes.byName(type)
        emit_signal("addMobsToWave", setup, qty)

func selectedType():
    if $Icon.selected == 0:
        return "Blue"
    else:
        return "Yellow"

func _on_Quantity_text_changed(new_text):
    updatePrice()

func updatePrice():
    var new_text = $TheRest/Quantity.text
    if new_text == "":
        $TheRest/Buy/Price.text = ""
    elif new_text.is_valid_integer():
        var qty = int(new_text)
        if qty > 0:
            var price  = qty * mobTypes.byName(selectedType()).price()
            $TheRest/Buy/Price.text = str("$", price)
        else:
            $TheRest/Buy/Price.text = "---"
    else:
        $TheRest/Buy/Price.text = "---"


func _on_Icon_item_selected(ID):
    updatePrice()
