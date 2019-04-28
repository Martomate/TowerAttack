class_name TowerTypes

var types: Dictionary

func byName(name: String):
    return types.get(name)

func register(type: TowerType):
    types[type.name] = type

func allTypes():
    return types.values()
