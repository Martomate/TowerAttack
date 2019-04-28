extends ScrollContainer

signal startWave(wave)
signal costChanged(newCost)

var packetIconAndInfo = preload("res://scenes/hud/IconAndInfo.tscn")
var images = preload("res://tilesets/MobImages.tres")

var wave = []

var totalCost = 0

var mobTypes: MobTypes
func init(mobTypes: MobTypes):
    self.mobTypes = mobTypes

func addMobToWave(mob, quantity):
    var cost = quantity * mob.price()
    
    for i in range(quantity):
        wave.append(mob)
    
    var name = mob.type.name
    var info = str("Health:\nSpeed:\nQuantity: ", quantity)
    var textureId = images.find_tile_by_name(name)
    var tex = images.tile_get_texture(textureId)
    
    var uiThing = packetIconAndInfo.instance()
    uiThing.quantity = quantity
    uiThing.setup = mob
    uiThing.icon = tex
    uiThing.info = info
    uiThing.connect("somethingChanged", self, "calculateTotalCost")
    $VBox.add_child(uiThing)
    
    calculateTotalCost()

func calculateTotalCost():
    totalCost = 0
    for mob in wave:
        totalCost += mob.price()
    emit_signal("costChanged", totalCost)

func _on_Clear_wave_pressed():
    clearList()

func clearList():
    wave.clear()
    for child in $VBox.get_children():
        $VBox.remove_child(child)
    
    calculateTotalCost()


func _on_Start_wave_pressed():
    var waveCopy = []
    for mob in wave:
        waveCopy.append(mob.copy(MobSetup.new()))
    emit_signal("startWave", waveCopy)

func reset():
    clearList()
