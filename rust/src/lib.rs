use godot::prelude::*;

struct WandstrikeRust;

#[gdextension]
unsafe impl ExtensionLibrary for WandstrikeRust {}

/// Fast wand spell math (ported from GDScript when stable).
/// Keep gameplay in GDScript first, move only hot loops here.
#[derive(GodotClass)]
#[class(base=Node)]
struct SpellMath {
    base: Base<Node>,
}

#[godot_api]
impl INode for SpellMath {
    fn init(base: Base<Node>) -> Self {
        Self { base }
    }
}

#[godot_api]
impl SpellMath {
    #[func]
    fn damage_falloff(&self, base_damage: f64, distance: f64, max_distance: f64) -> f64 {
        if distance >= max_distance {
            return 0.0;
        }
        let t = distance / max_distance;
        base_damage * (1.0 - t * t)
    }
}
