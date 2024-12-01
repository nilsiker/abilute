@tool
class_name Effect extends Node

enum Kind {
    Instant,
    Duration,
    Infinite
}

#region Properties
var kind: Kind:
    get: return kind
    set(k):
        kind = k
        notify_property_list_changed()

var modifiers: Array[Modifier]
var duration: float
var period: float

func _get_property_list() -> Array[Dictionary]:
    var ret: Array[Dictionary] = []

    # Add kind property
    ret.append({
        name = "kind",
        type = TYPE_INT,
        hint = PROPERTY_HINT_ENUM,
        hint_string = "Instant,Duration,Infinite",
        usage = PROPERTY_USAGE_DEFAULT
    })

    # Add properties conditionally based on kind
    if kind == Kind.Duration:
        ret.append({
            name = "duration",
            type = TYPE_FLOAT,
            usage = PROPERTY_USAGE_DEFAULT,
            group = "Duration"
        })


    if kind != Kind.Instant:
        # Add periodic effect properties
        ret.append({
            name = "period",
            type = TYPE_FLOAT,
            usage = PROPERTY_USAGE_DEFAULT,
            group = "Periodic Effect"
        })

    # Always include modifiers
    ret.append({
        name = "modifiers",
        type = TYPE_ARRAY,
        hint_string = "%s/%s:Modifier" % [TYPE_OBJECT, TYPE_BASIS],
        usage = PROPERTY_USAGE_DEFAULT
    })
    
    return ret
#endregion

#region Overrides
func _ready() -> void:
    match kind:
        Kind.Instant: _trigger_instant()
        Kind.Duration: _trigger_duration()
        Kind.Infinite: _apply_infinite()
#endregion


#region Effect Triggers
func _trigger_instant():
    for modifier in modifiers:
        var node = get_parent(). \
            get_node(Attribute.str(modifier.attribute)) \
            as Attribute
        node.add(modifier.magnitude)

    queue_free()

func _trigger_duration():
    print("todo implement duration effect")

func _apply_infinite():
    if period > 0.0:
        var timer = Timer.new()
        timer.wait_time = period
        timer.autostart = true
        timer.one_shot = false
        timer.timeout.connect(_trigger_infinite)
        add_child(timer)
    else:
        _trigger_infinite()

#endregion


#region Effect Triggers
func _trigger_infinite():
    for modifier in modifiers:
        var node = get_parent(). \
            get_node(Attribute.str(modifier.attribute)) \
            as Attribute
        node.add(modifier.magnitude)
#endregion
