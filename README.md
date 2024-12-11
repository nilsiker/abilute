# Abilute

> ⚠️ This is a WIP repo for a Godot plugin used for my personal projects. Do not expect any useful features at this point.

**Abilute** (portmanteau of *ability* and *attribute*) is a gameplay ability plugin for Godot, heavily inspired by the Unreal Gameplay Ability System (GAS).
 
## Planned features

**Abilute** aims to provide a framework for:
	
* **Attributes** representing meaningful resources for game entities.
* **Effects** that modify attributes.
* **Abilities** that can be granted and activated by game entities, applying effects to any attribute-haver.

## Design overview

```mermaid
classDiagram
direction BT
namespace Godot {
    class Node
    class Resource
}

namespace Abilute {
    class AttributeChangeData {
        attribute: StringName
        old_value: float
        new_value: float
    }
    class AbiluteComponent {
        add_effect() bool
        get_attribute_base(EAttribute) float
        get_attribute_value(EAttribute) float
        _get_attributes() Attribute[]
        _apply_effect() void
        _trigger_effect() void
        _remove_effect() void

        _pre_attribute_change(AttributeChangeData)
        _on_attribute_change(AttributeChangeData)
        _post_attribute_change(AttributeChangeData)
    }
    class Attribute {
        signal base_value_changed(AttributeChangeData)
        signal value_changed(AttributeChangeData)
        
        get_base_value() float
        get_value() float
        ~ _init(AttributeData)
        + init() void
        + add_base_modifier(Modifier)
        + add_modifier(Modifier)
        - _on_modifier_tree_exited()
        - _on_max_attribute_value_updated
    }
    class AttributeData {
        _attribute: StringName
        _max_attribute: StringName
        _base_value : float
        _allow_negative: bool
    }
    class Effect {
        signal application_requested(BaseEffect)
        signal trigger_requested(BaseEffect)
        signal removal_requested(BaseEffect)
        ~ _init(BaseEffect)
        ~ _ready()
        + time_left() float
        - _trigger_instant()
        - _trigger_duration()
        - _trigger_infinite()
        - _add_duration_timer
        - _request_application()
        - _request_trigger()
        - _request_removal()
    }
    class BaseEffect {
        + modifiers: ModifierData[]
        + trigger_blocked_by: BaseEffect[]
        + application_blocked_by: BaseEffect[]
        + removes: BaseEffect[]
        + success_effects: BaseEffect[]
        + failure_effects: BaseEffect[]
        + modifies_base() bool
    }
    class DurationEffect {
        + duration : float
        + period : float
        + allow_reapply : bool
    }
    class InfiniteEffect {
        + period : float   
    }
    class Ability
    class AbilityData
    class Modifier {
        - _data : ModifierData
        ~ _init(ModifierData, Signal)
        + modify(float) : float
    }
    class ModifierData {
        + attribute : StringName
        + operation : Operation
        + magnitude : float
    }
    class Operation {
        <<enum>>
        Add
    }
}

Attribute--|>Node
Effect--|>Node
AttributeData--|>Resource
BaseEffect--|>Resource
DurationEffect--|>BaseEffect
InfiniteEffect--|>BaseEffect

AbiluteComponent o-- Attribute: parents
AbiluteComponent o-- Effect: parents
Attribute o-- Modifier: parents

Attribute-->AttributeData
Effect-->BaseEffect
Modifier --> ModifierData

BaseEffect o-- ModifierData

AbiluteComponent --> Modifier: instantiates
AbiluteComponent --> Attribute: modifies base value
AbiluteComponent --> AttributeChangeData

```