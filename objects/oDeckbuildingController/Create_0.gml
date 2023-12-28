/// @description Init vars, create cards
global.deckbuilding_controller = self;
daemon_data = global.data_controller.deckbuilding_daemon;
species_data = get_species_data(daemon_data.index);
active_moves = daemon_data.moves;
unused_moves = daemon_data.unused_moves;
cards_per_row = 8;
min_cards = species_data.hand_size * 3;

create_deckbuilding_cards();