extends Node
class_name BandLeader

# May become child script instead of entity
var band_members: Array[Entity]

func _ready() -> void:
	band_members = [get_parent()]

func add_member(member: BandMemberController):
	member.front_member = band_members.back()
	get_parent().get_parent().add_child(member.get_parent())
	band_members.append(member.entity)
