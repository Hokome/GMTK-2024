extends Node
class_name BandLeader

# May become child script instead of entity
var band_members: Array[Entity]
var track_players: Dictionary

func _ready() -> void:
	band_members = [get_parent()]

func add_member(member: BandMemberController):
	member.front_member = band_members.back()
	get_parent().get_parent().add_child(member.get_parent())
	band_members.append(member.entity)

func add_track(track: AudioStreamWAV) -> void:
	if track_players.has(track): return
	
	var track_player := AudioStreamPlayer.new()
	track_player.stream = track
	track_player.bus = "Music"
	add_child(track_player)
	track_players[track] = track_player
	track_player.play()
	track_player.volume_db = -INF
	
	track_player.finished.connect(track_player.play)

func unmute_track(track: AudioStreamWAV):
	track_players[track].volume_db = 0

func fade_tracks():
	for t: AudioStreamPlayer in track_players.values():
		t.volume_db = -INF
