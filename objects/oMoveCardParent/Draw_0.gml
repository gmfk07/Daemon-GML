if (!surface_exists(surf))
{
    surf = surface_create(sprite_width, sprite_height);
}

surface_set_target(surf);
draw_clear_alpha(c_white, 1);
draw_set_alpha(1);
draw_set_color(c_white);
draw_sprite(get_card_shell_sprite_from_class(move.class), image_index, sprite_width/2, sprite_height/2);
draw_sprite(move.art, 0, 14, 17);
draw_sprite(sPointCost, 0, 0, sprite_height/2 - 32);
draw_sprite(get_target_sprite(move.targets), 0, sprite_width - 32, sprite_height - 32);
draw_sprite(get_phase_sprite_from_battle_phase(move.phase), 0, 0, sprite_height - 32);

draw_set_font(-1);

draw_set_halign(fa_left);
draw_set_font(fnt_card_text);
draw_text(0, 0, move.name);
type(16, sprite_width/2 + 32, get_description_string(move.effects, move.self_effects, move.restrictions), string_length(get_description_string(move.effects, move.self_effects, move.restrictions)), sprite_width - 16);

draw_set_halign(fa_center);
draw_text(16, sprite_height/2 - 16, move.cost + (same_class ? 0 : 1));

draw_set_halign(fa_left);
draw_sprite(get_class_icon(move.class), 0, sprite_width-16, 0);

surface_reset_target();

draw_surface_ext(surf, x - (sprite_width * image_scale)/2, y - (sprite_height * image_scale)/2, image_scale, image_scale, 0, c_white, 1);