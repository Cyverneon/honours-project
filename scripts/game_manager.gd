extends Node

const group : int = 2

var photos_count : int = 0

var start_time : float
var end_time : float

func set_start_time():
	start_time = Time.get_unix_time_from_system()

func set_end_time():
	end_time = Time.get_unix_time_from_system()
