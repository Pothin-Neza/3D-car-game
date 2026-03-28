extends Node

var finish_time: String = "00:00"
var best_lap: String = "00:00"
var track_limit_count: int = 0
var crashed: bool = false
var lives: int = 4  # Start with 4 lightning bolts
var is_racing: bool = false
