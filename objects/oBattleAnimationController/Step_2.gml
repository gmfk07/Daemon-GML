/// @description Check to advance to next animation
if (in_animation && num_ongoing_animations == 0)
{
    animation_index++;
    if (animation_index < array_length(animation))
    {
        perform_animation(animation[animation_index]);
    }
    else
    {
        if (!move_animation_card.is_moused_over)
        {
            in_animation = false;
            with (move_animation_card)
            {
                instance_destroy();
            }
        }
    }
}



