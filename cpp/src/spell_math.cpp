#include "spell_math.h"
#include <godot_cpp/core/class_db.hpp>

namespace wandstrike {

void SpellMathCpp::_bind_methods() {
    godot::ClassDB::bind_method(godot::D_METHOD("damage_falloff", "base_damage", "distance", "max_distance"), &SpellMathCpp::damage_falloff);
}

double SpellMathCpp::damage_falloff(double base_damage, double distance, double max_distance) const {
    if (distance >= max_distance) return 0.0;
    double t = distance / max_distance;
    return base_damage * (1.0 - t * t);
}

} // namespace wandstrike
