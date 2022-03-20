extends CanvasLayer
class_name HUD

signal play_pressed()
signal back_pressed()

@onready var score_label: Label = $VBoxContainer2/ScoreLabel
@onready var time_label: Label = $VBoxContainer2/TimeLabel

@onready var container: OrderContainer = $OrderContainer

@onready var title_screen: TitleScreen = $TitleScreen
@onready var recipe_menu: RecipeMenu = $RecipeMenu
@onready var help_menu: HelpMenu = $HelpMenu
@onready var victory_screen: VictoryScreen = $VictoryScreen


func _ready() -> void:
	recipe_menu.disable()
	victory_screen.disable()
	title_screen.disable()
	help_menu.disable()
	score_label.hide()
	time_label.hide()
	container.hide()


func _process(_delta: float) -> void:
	score_label.text = "Score: " + str(Recipes.score)


func show_score() -> void:
	victory_screen.enable()
	score_label.hide()
	time_label.hide()
	container.hide()


func show_labels() -> void:
	score_label.show()
	time_label.show()
	container.show()


func show_menu() -> void:
	title_screen.enable()


func add_order(order: Order) -> void:
	container.add_order(order)


func remove_order(order: Order, successful := false) -> void:
	container.remove_order(order, successful)


func set_time_left(time_left: float) -> void:
	time_label.text = "Time: " + str(int(time_left))


func _on_title_screen_help_pressed() -> void:
	title_screen.disable()
	help_menu.enable()


func _on_title_screen_play_pressed() -> void:
	title_screen.disable()
	play_pressed.emit()


func _on_title_screen_recipe_pressed() -> void:
	title_screen.disable()
	recipe_menu.enable()


func _on_recipe_menu_back_pressed() -> void:
	recipe_menu.disable()
	title_screen.enable()


func _on_victory_screen_back_pressed() -> void:
	back_pressed.emit()
	victory_screen.disable()


func _on_help_menu_back_pressed() -> void:
	help_menu.disable()
	title_screen.enable()
