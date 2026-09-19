// Wandstrike C++ GDExtension skeleton (alternative to Rust - pick ONE).
// Build steps (Windows):
//   1. Clone godot-cpp into cpp/godot-cpp (matching your Godot version, e.g. 4.6)
//   2. scons platform=windows target=template_debug
//   3. scons platform=windows target=template_debug (this extension)
// Output: cpp/bin/wandstrike_cpp.windows.template_debug.x86_64.dll
// Loaded via extensions/wandstrike_cpp.gdextension
//
// Start here for: custom physics, audio DSP for spells, nav optimizations.
// Keep gameplay in GDScript first.
#pragma once
#include <godot_cpp/classes/node.hpp>

namespace wandstrike {

class SpellMathCpp : public godot::Node {
    GDCLASS(SpellMathCpp, godot::Node)
public:
    static void _bind_methods();
    double damage_falloff(double base_damage, double distance, double max_distance) const;
};

} // namespace wandstrike
