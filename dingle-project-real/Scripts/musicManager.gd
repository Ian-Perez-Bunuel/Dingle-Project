extends AudioStreamPlayer
class_name MusicManager

enum Track
{
	Overworld,
	Dialogue,
	Minigame,
	Bar,
}

const overworldTheme: AudioStream = preload("res://Assets/Audio/Music/Something Phishy - Overworld Theme.mp3")
const dialogueTheme: AudioStream = preload("res://Assets/Audio/Music/Something Phishy - Dialogue Theme.mp3")
const mingameTheme: AudioStream = preload("res://Assets/Audio/Music/Something Phishy - Minigames Theme.mp3")
const barTheme: AudioStream = preload("res://Assets/Audio/Music/Something Phishy - Bar Theme.mp3")

var nameToMP3: Dictionary[Track, AudioStream]
var currentTrack: Track = Track.Overworld

func _ready() -> void:
	nameToMP3[Track.Overworld] = overworldTheme
	nameToMP3[Track.Dialogue] = dialogueTheme
	nameToMP3[Track.Minigame] = mingameTheme
	nameToMP3[Track.Bar] = barTheme
	
func set_music(t: Track):
	if currentTrack == t:
		return
	
	currentTrack = t
	stream = nameToMP3[t]
	volume_db = Options.musicVol
	play()
