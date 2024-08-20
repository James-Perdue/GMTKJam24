extends TextureRect

signal exit_c()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PanelContainer/CellAnimation.modulate = Color("red")
	$PanelContainer2/CellAnimation.modulate = Color("blue")
	$PanelContainer3/CellAnimation.modulate = Color("pink")
	$PanelContainer4/CellAnimation.modulate = Color("black")
	$exit_cont/exit_button.pressed.connect(self._exit_screen)

func _exit_screen():
	exit_c.emit()
