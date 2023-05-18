if (!surface_exists(surf))
{
    surf = surface_create(sprite_width, sprite_height);
}

surface_set_target(surf);
draw_clear_alpha(c_white, 1);
draw_set_alpha(1);
draw_sprite(sprite_index, image_index, sprite_width/2, sprite_height/2);
draw_text(0, 0, move_name);
surface_reset_target();

draw_surface_ext(surf, x - (sprite_width * image_scale)/2, y - (sprite_height * image_scale)/2, image_scale, image_scale, 0, c_white, 1);
//draw_surface_stretched(surf, x, y, sprite_width*image_scale, sprite_height*image_scale);
//draw_surface_stretched(surf, x, y, sprite_width*image_scale, sprite_height*image_scale);