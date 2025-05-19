# 官方原版 state_machine.gd 文件内容
extends Node

var owner
var current_state = null
var states = {}

func Init(_owner):
    owner = _owner
    for child in get_children():
        if child is State:
            states[child.Name] = child
            child.state_machine = self
    if states.has("Idle"):
        ChangeState("Idle")

func ChangeState(state_name):
    if current_state:
        current_state.Exit()
    current_state = states[state_name]
    current_state.Enter()

func _process(delta):
    if current_state:
        current_state.Update(delta)
