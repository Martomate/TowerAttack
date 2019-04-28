extends VBoxContainer

var mobTypes: MobTypes

func init(mobTypes: MobTypes):
    self.mobTypes = mobTypes
    updateInfo()

func updateInfo():
    var blue = mobTypes.byName("Blue")
    var yellow = mobTypes.byName("Yellow")
    
    $Blue.info = mobInfoText(blue)
    $Yellow.info = mobInfoText(yellow)

func mobInfoText(mobType: MobType):
    return str("Name: ", mobType.name, "\nHealth: ", mobType.maxHealth, "\nSpeed: ", mobType.speed)