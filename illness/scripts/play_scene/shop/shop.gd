extends Control
class_name Shop

var parent : PlayScene

func initialize(parameter : PlayScene) -> void:
	parent = parameter
	for child in get_children():
		if child.has_method("initialize"):
			child.initialize(self)

@export var card_slots : Array[ShopCardSlot]

const CARD = preload("uid://cqr2tljf25i0j")

func _on_shop_change_card_button_down() -> void:
	#这里写消耗的逻辑
	#get_random_card_to_sell()
	
	for card_slot in card_slots:
		var new_card : Card = CARD.instantiate()
		new_card.time = randi_range(0,7)
		new_card.card_detail = str(randf())
		
		if card_slot.card_in_slot:
			card_slot.card_in_slot.queue_free()
		card_slot.add_child(new_card)
		new_card.initialize(card_slot)
		card_slot.card_in_slot = new_card

func get_random_card_to_sell() -> Card:
	var result : Card = null
	pass
	#这里写随机取新牌的逻辑
	return result



func _on_shop_destroy_card_button_down() -> void:
	match ShopGlue.in_destroy_type:
		true:
			ShopGlue.in_destroy_type = false
			#这里写返还消耗的逻辑
		false:
			ShopGlue.in_destroy_type = true
			#这里写消耗的逻辑
