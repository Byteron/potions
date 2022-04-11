extends CanvasLayer
class_name HUD

signal level_selected(level: int)
signal escape_pressed()
signal back_pressed()

@onready var score_label: Label = $Stats/ScoreLabel
@onready var time_label: Label = $Stats/TimeLabel

@onready var container: OrderContainer = $OrderContainer

@onready var title_screen: TitleScreen = $TitleScreen
@onready var level_screen: LevelScreen = $LevelScreen
@onready var recipe_menu: RecipeMenu = $RecipeMenu
@onready var victory_screen: VictoryScreen = $VictoryScreen
@onready var escape_screen: EscapeScreen = $EscapeScreen


var selected_level := 0
var highest_unlocked_level := 0


func _ready() -> void:
	recipe_menu.disable()
	victory_screen.disable()
	title_screen.disable()
	level_screen.disable()
	escape_screen.disable()
	score_label.hide()
	time_label.hide()
	container.hide()


func _process(_delta: float) -> void:
	score_label.text = str(Recipes.score)


func show_score(outcome, win_score) -> void:
	victory_screen.enable(selected_level, outcome, win_score)
	escape_screen.disable()
	score_label.hide()
	time_label.hide()
	container.hide()


func show_labels() -> void:
	score_label.show()
	time_label.show()
	container.show()
	escape_screen.enable()


func show_menu() -> void:
	title_screen.enable()


func add_order(order: Order) -> void:
	container.add_order(order)


func remove_order(order: Order, successful := false) -> void:
	container.remove_order(order, successful)


func set_time_left(time_left: float) -> void:
	time_label.text = str(int(time_left))


func _on_title_screen_play_pressed() -> void:
	title_screen.disable()
	level_screen.enable(highest_unlocked_level)


func _on_title_screen_recipe_pressed() -> void:
	title_screen.disable()
	recipe_menu.enable()


func _on_recipe_menu_back_pressed() -> void:
	recipe_menu.disable()
	title_screen.enable()


func _on_victory_screen_back_pressed() -> void:
	back_pressed.emit()
	victory_screen.disable()


func _on_level_screen_level_selected(level: int) -> void:
	level_screen.disable()
	selected_level = level
	level_selected.emit(level)


func _on_level_screen_back_pressed() -> void:
	level_screen.disable()
	title_screen.enable()


func _on_escape_screen_escape_pressed() -> void:
	escape_pressed.emit()
