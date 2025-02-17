extends CollisionObject2D

class_name Interactable

@export var waterable: bool
@export var destroyable: bool
@export var requires_hand: bool

func interact(_player): pass
