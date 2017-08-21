extends Node

onready var mi = get_node('terrain')
onready var vp = get_node('vp')
onready var simplex = get_node('vp/simplex')
var size = 64
var scale = 8.0
var cur_offset = Vector2(0, 0)
var update_interval = 1.0
var timer = 0.0

func _ready():
    var t = ImageTexture.new()
    t.create(size, size, 0, 0)
    simplex.texture = t
    vp.size = Vector2(size, size)

    simplex.get_material().set_shader_param('scale', scale)
    mi.get_multimesh().instance_count = size * size

func _process(delta):
    timer += delta
    cur_offset += Vector2(delta, delta)
    if timer >= update_interval:
        timer = 0.0

        var mm = mi.get_multimesh()

        var t = Transform()
        var s = vp.get_texture().get_data()
        s.lock()
        var p
        for x in range(size):
            for y in range(size):
                p = s.get_pixel(x, y).a
                print(p)
                mm.set_instance_transform(x*size+y, t.translated(Vector3(x, (2.0+p)*2.0, y)))
        s.unlock()
        simplex.get_material().set_shader_param('offset', cur_offset)





