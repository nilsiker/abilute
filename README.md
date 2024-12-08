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
        old_value: float
        new_value: float
    }
    class AbilitySystem {
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
        signal base_changed(float)
        signal value_changed(float)
        
        get_value() float
        get_base() float

    }
    class AttributeResource {
        _base_value : float
    }
    class Effect {
        signal application_requested(Effect)
        signal trigger_requested(Effect)
        signal removal_requested(Effect)
    }
    class EffectResource
    class Ability
    class AbilityResource
    class Modifier {
        magnitude: float
    }
    class EDuration {
        <<enum>>
        Instant,
        Duration,
        Infinite
    }
    class EOperation {
        <<enum>>
        Add,
        Multiply,
        Override
    }
    class EAttribute {
        <<enum>>
        Health,
        Stamina,
        Mana
    }
}

Attribute--|>Node
Effect--|>Node
AttributeResource--|>Resource
EffectResource--|>Resource

AbilitySystem o-- Attribute: parents
AbilitySystem o-- Effect: parents
AbilitySystem o-- Ability: parents

Attribute-->AttributeResource
Effect-->EffectResource

Ability-->AbilityResource
AbilityResource o-- EffectResource
Ability --> AbilitySystem: performs logic on

Modifier --> EAttribute
Modifier --> EOperation
Modifier --> EDuration

EffectResource o-- Modifier

AbilitySystem --> Attribute: modifies
AbilitySystem --> AttributeChangeData

```