extends Node
class_name BandLeader

# May become child script instead of entity
var band_members: Array[Entity]
var track_players: Dictionary

func _ready() -> void:
	band_members = [get_parent()]

func add_member(member: BandMemberController):
	member.front_member = band_members.back()
	print(str(member.front_member.position) + " " + member.front_member.name)
	get_parent().get_parent().add_child(member.get_parent())
	band_members.append(member.entity)

func add_track(track: AudioStreamWAV) -> void:
	if track_players.has(track): return
	
	var track_player := AudioStreamPlayer.new()
	track_player.stream = track
	track_player.bus = "Music"
	add_child(track_player)
	track_players[track] = track_player
	if track_players.is_empty():
		track_player.play()
	else:
		track_player.play(track_players.values()[0].get_playback_position())
	
	track_player.finished.connect(track_player.play)
