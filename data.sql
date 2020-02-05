/***********************************************************************
 * INIT
 ***********************************************************************/
drop database if exists wainwright_fells;
create database wainwright_fells;
set collation_connection = 'utf8_general_ci';
alter database wainwright_fells character set utf8 collate utf8_general_ci;
use wainwright_fells;

/***************************************************************************************************
 * REGIONS
 **************************************************************************************************/
create table regions (
    region_id int not null auto_increment,
    region_name varchar(20) not null,
    primary key (region_id)
);

set @book1_region = 'Eastern Fells';
set @book2_region = 'Far Eastern Fells';
set @book3_region = 'Central Fells';
set @book4_region = 'Southern Fells';
set @book5_region = 'Northern Fells';
set @book6_region = 'North Western Fells';
set @book7_region = 'Western Fells';

insert into regions (region_name) values (@book1_region); 
insert into regions (region_name) values (@book2_region); 
insert into regions (region_name) values (@book3_region); 
insert into regions (region_name) values (@book4_region);
insert into regions (region_name) values (@book5_region);
insert into regions (region_name) values (@book6_region);
insert into regions (region_name) values (@book7_region); 

/***************************************************************************************************
 * FELLS
 **************************************************************************************************/
create table fells (
    fell_id int not null auto_increment,
    fell_name varchar(25) not null,
    fell_height_meters int not null,
    overall_height_rank int, -- is modified to be not null after the overall_height_ranks have been calculated and inserted
    region_id int not null,
    prominence_meters int not null,
    os_map_ref varchar(8) not null,
    primary key (fell_id),
    foreign key (region_id) references regions(region_id)
);

-- assign region ids to vars to be used in the fell insert function
set @e = (select region_id from regions where region_name = @book1_region);
set @fe = (select region_id from regions where region_name = @book2_region);
set @c = (select region_id from regions where region_name = @book3_region);
set @s = (select region_id from regions where region_name = @book4_region);
set @n = (select region_id from regions where region_name = @book5_region);
set @nw = (select region_id from regions where region_name = @book6_region);
set @w = (select region_id from regions where region_name = @book7_region);

-- a function that inserts a fell into the database
-- the resulting function call is shorter and simpler to work with and maintain
drop function if exists fell_insert;
delimiter //
create function fell_insert(
    fell_name varchar(50), 
    fell_height_meters int, 
    region_id int, 
    prominence_meters int,
    os_map_ref varchar(8)) 
returns int
deterministic
begin
    insert into fells (fell_name, fell_height_meters, region_id, prominence_meters, os_map_ref) 
        values (fell_name, fell_height_meters, region_id, prominence_meters, os_map_ref);

    return last_insert_id();
end//
delimiter ;

set @helvellyn = 'Helvellyn';
set @nethermost_pike = 'Nethermost Pike';
set @catstye_cam = 'Catstye Cam';
set @raise = 'Raise';
set @fairfield = 'Fairfield';
set @white_side = 'White Side';
set @dollywaggon_pike = 'Dollywaggon Pike';
set @great_dodd = 'Great Dodd';
set @styebarrow_dodd = 'Styebarrow Dodd';
set @st_sunday_crag = 'St Sunday Crag';
set @hart_crag = 'Hart Crag';
set @dove_crag = 'Dove Crag';
set @watsons_dodd = "Watson's Dodd";
set @red_screes = 'Red Screes';
set @great_rigg = 'Great Rigg';
set @hart_side = 'Hart Side';
set @seat_sandal = 'Seat Sandal';
set @clough_head = 'Clough Head';
set @birkhouse_moor = 'Birkhouse Moor';
set @sheffield_pike = 'Sheffield Pike';
set @high_pike_scandale = 'High Pike (Scandale)';
set @middle_dodd = 'Middle Dodd';
set @little_hart_crag = 'Little Hart Crag';
set @birks = 'Birks';
set @heron_pike = 'Heron Pike';
set @hartsop_above_how = 'Hartsop Above How';
set @great_mell_fell = 'Great Mell Fell';
set @high_hartsop_dodd = 'High Hartsop Dodd';
set @low_pike = 'Low Pike';
set @little_mell_fell = 'Little Mell Fell';
set @stone_arthur = 'Stone Arthur';
set @gowbarrow_fell = 'Gowbarrow Fell';
set @nab_scar = 'Nab Scar';
set @glenridding_dodd = 'Glenridding Dodd';
set @arnison_crag = 'Arnison Crag';

-- eastern fells
set @helvellyn_id           = (select fell_insert(@helvellyn, 950, @e, 712, 'NY342151'));

set @nethermost_pike_id     = (select fell_insert(@nethermost_pike, 891, @e, 22, 'NY343142'));

set @catstye_cam_id         = (select fell_insert(@catstye_cam, 890, @e, 63, 'NY348158'));

set @raise_id               = (select fell_insert(@raise, 883, @e, 88, 'NY342174'));

set @fairfield_id           = (select fell_insert(@fairfield, 873, @e, 299, 'NY358117'));

set @white_side_id          = (select fell_insert(@white_side, 863, @e, 42, 'NY337166'));

set @dollywaggon_pike_id    = (select fell_insert(@dollywaggon_pike, 858, @e, 50, 'NY346130'));

set @great_dodd_id          = (select fell_insert(@great_dodd, 857, @e, 109, 'NY342205'));

set @styebarrow_dodd_id     = (select fell_insert(@styebarrow_dodd, 843, @e, 68, 'NY343189'));

set @st_sunday_crag_id      = (select fell_insert(@st_sunday_crag, 841, @e, 166, 'NY369135'));

set @hart_crag_id           = (select fell_insert(@hart_crag, 822, @e, 50, 'NY368113'));

set @dove_crag_id           = (select fell_insert(@dove_crag, 792, @e, 50, 'NY374104'));

set @watsons_dodd_id        = (select fell_insert(@watsons_dodd, 789, @e, 11, 'NY336196'));

set @red_screes_id          = (select fell_insert(@red_screes, 776, @e, 260, 'NY396087'));

set @great_rigg_id          = (select fell_insert(@great_rigg, 766, @e, 31, 'NY355104'));

set @hart_side_id           = (select fell_insert(@hart_side, 756, @e, 23, 'NY359198'));

set @seat_sandal_id         = (select fell_insert(@seat_sandal, 736, @e, 150, 'NY343115'));

set @clough_head_id         = (select fell_insert(@clough_head, 726, @e, 108, 'NY333225'));

set @birkhouse_moor_id      = (select fell_insert(@birkhouse_moor, 718, @e, 20, 'NY364160'));

set @sheffield_pike_id      = (select fell_insert(@sheffield_pike, 675, @e, 91, 'NY368182'));

set @high_pike_scandale_id  = (select fell_insert(@high_pike_scandale, 656, @e, 5, 'NY373088'));

set @middle_dodd_id         = (select fell_insert(@middle_dodd, 654, @e, 10, 'NY397096'));

set @little_hart_crag_id    = (select fell_insert(@little_hart_crag, 637, @e, 34, 'NY387100'));

set @birks_id               = (select fell_insert(@birks, 622, @e, 19, 'NY380143'));

set @heron_pike_id          = (select fell_insert(@heron_pike, 612, @e, 21, 'NY355082'));

set @hartsop_above_how_id   = (select fell_insert(@hartsop_above_how, 570, @e, 30, 'NY383120'));

set @great_mell_fell_id     = (select fell_insert(@great_mell_fell, 537, @e, 198, 'NY397254'));

set @high_hartsop_dodd_id   = (select fell_insert(@high_hartsop_dodd, 519, @e, 5, 'NY393108'));

set @low_pike_id            = (select fell_insert(@low_pike, 508, @e, 28, 'NY373077'));

set @little_mell_fell_id    = (select fell_insert(@little_mell_fell, 505, @e, 226, 'NY423240'));

set @stone_arthur_id        = (select fell_insert(@stone_arthur, 500, @e, 2, 'NY348093'));

set @gowbarrow_fell_id      = (select fell_insert(@gowbarrow_fell, 481, @e, 100, 'NY408219'));

set @nab_scar_id            = (select fell_insert(@nab_scar, 450, @e, 5, 'NY356073'));

set @glenridding_dodd_id    = (select fell_insert(@glenridding_dodd, 442, @e, 45, 'NY381175'));

set @arnison_crag_id        = (select fell_insert(@arnison_crag, 433, @e, 10, 'NY393150'));

-- far eastern fells
set @high_street_id = (select fell_insert('High Street', 828, @fe, 373, 'NY440110'));

set @high_raise_haweswater_id = (select fell_insert('High Raise (Haweswater)', 802, @fe, 90, 'NY448135'));

set @rampsgill_head_id = (select fell_insert('Rampsgill Head', 792, @fe, 40, 'NY443128'));

set @thornthwaite_crag_id = (select fell_insert('Thornthwaite Crag', 784, @fe, 30, 'NY432101'));

set @kidsty_pike_id = (select fell_insert('Kidsty Pike', 780, @fe, 15, 'NY447126'));

set @harter_fell_mardale_id = (select fell_insert('Harter Fell (Mardale)', 778, @fe, 149, 'NY459093'));

set @caudale_moor_id = (select fell_insert('Caudale Moor', 763, @fe, 171, 'NY417100'));

set @mardale_ill_bell_id = (select fell_insert('Mardale Ill Bell', 760, @fe, 14, 'NY448102'));

set @ill_bell_id = (select fell_insert('Ill Bell', 757, @fe, 124, 'NY436078'));

set @the_knott_id = (select fell_insert('The Knott', 739, @fe, 14, 'NY436127'));

set @kentmere_pike_id = (select fell_insert('Kentmere Pike', 730, @fe, 35, 'NY465078'));

set @froswick_id = (select fell_insert('Froswick', 720, @fe, 75, 'NY435085'));

set @branstree_id = (select fell_insert('Branstree', 713, @fe, 137, 'NY477100'));

set @yoke_id = (select fell_insert('Yoke', 706, @fe, 38, 'NY437067'));

set @gray_crag_id = (select fell_insert('Gray Crag', 699, @fe, 15, 'NY427117')); -- this is GR(A)Y Crag, there is a different GR(E)Y Crag fell

set @rest_dodd_id = (select fell_insert('Rest Dodd', 696, @fe, 111, 'NY432137'));

set @loadpot_hill_id = (select fell_insert('Loadpot Hill', 671, @fe, 50, 'NY457181'));

set @wether_hill_id = (select fell_insert('Wether Hill', 670, @fe, 20, 'NY456167'));

set @tarn_crag_longsleddale_id = (select fell_insert('Tarn Crag (Longsleddale)', 664, @fe, 160, 'NY488078'));

set @place_fell_id = (select fell_insert('Place Fell', 657, @fe, 262, 'NY405169'));

set @selside_pike_id = (select fell_insert('Selside Pike', 655, @fe, 40, 'NY490111'));

set @grey_crag_id = (select fell_insert('Grey Crag', 638, @fe, 45, 'NY497072')); -- this is GR(E)Y Crag, there is a different GR(A)Y Crag fell

set @hartsop_dodd_id = (select fell_insert('Hartsopp Dodd', 618, @fe, 20, 'NY412118'));

set @shipman_knotts_id = (select fell_insert('Shipman Knotts', 587, @fe, 10, 'NY472063'));

set @the_nab_id = (select fell_insert('The Nab', 576, @fe, 61, 'NY434152'));

set @angletarn_pikes_id = (select fell_insert('Angletarn Pikes', 567, @fe, 80, 'NY413148'));

set @brock_crags_id = (select fell_insert('Brock Crags', 561, @fe, 25, 'NY419137'));

set @arthurs_pike_id = (select fell_insert("Arthur's Pike", 533, @fe, 10, 'NY461206'));

set @bonscale_pike_id = (select fell_insert('Bonscale Pike', 524, @fe, 10, 'NY453201'));

set @sallows_id = (select fell_insert('Sallows', 516, @fe, 69, 'NY437040'));

set @beda_fell_id = (select fell_insert('Beda Fell', 509, @fe, 60, 'NY427171'));

set @wansfell_id = (select fell_insert('Wansfell', 488, @fe, 147, 'NY403051'));

set @sour_howes_id = (select fell_insert('Sour Howes', 483, @fe, 34, 'NY427032'));

set @steel_knotts_id = (select fell_insert('Steel Knots', 432, @fe, 45, 'NY440181'));

set @hallin_fell_id = (select fell_insert('Hallin Fell', 388, @fe, 163, 'NY433198'));

set @troutbeck_tongue_id = (select fell_insert('Troutbeck Tongue', 364, @fe, 70, 'NY422064'));

-- central fells
set @high_raise_langdale_id = (select fell_insert('High Raise (Langdale)', 762, @c, 283, 'NY280095'));

set @sergeant_man_id = (select fell_insert('Sergeant Man', 736, @c, 10, 'NY286089'));

set @harrison_stickle_id = (select fell_insert('Harrison Stickle', 736, @c, 53, 'NY281074'));

set @ullscarth_id = (select fell_insert('Ullscarf', 726, @c, 115, 'NY292122'));

set @thunacar_knott_id = (select fell_insert('Thunacar Knott', 723, @c, 27, 'NY279079'));

set @pike_of_stickle_id = (select fell_insert('Pike Of Stickle', 709, @c, 54, 'NY273073'));

set @pavey_ark_id = (select fell_insert('Pavey Ark', 700, @c, 15, 'NY285079'));

set @loft_crag_id = (select fell_insert('Loft Crag', 680, @c, 25, 'NY277071'));

set @high_seat_id = (select fell_insert('High Seat', 608, @c, 124, 'NY287180'));

set @bleaberry_fell_id = (select fell_insert('Bleaberry Fell', 590, @c, 40, 'NY285195'));

set @sergeants_crag_id = (select fell_insert("Sergeant's Crag", 571, @c, 45, 'NY274114'));

set @steel_fell_id = (select fell_insert('Steel Fell', 553, @c, 70, 'NY319112'));

set @tarn_crag_easedale_id = (select fell_insert('Tarn Crag (Easedale)', 550, @c, 5, 'NY301093'));

set @blea_rigg_id = (select fell_insert('Blea Rigg', 541, @c, 20, 'NY302078'));

set @calf_crag_id = (select fell_insert('Calf Crag', 537, @c, 40, 'NY302105'));

set @high_tove_id = (select fell_insert('High Tove', 515, @c, 16, 'NY288166'));

set @eagle_crag_id = (select fell_insert('Eagle Crag', 525, @c, 25, 'NY275121'));

set @armboth_fell_id = (select fell_insert('Armboth Fell', 479, @c, 25, 'NY297159'));

set @raven_crag_id = (select fell_insert('Raven Crag', 461, @c, 45, 'NY304188'));

set @great_crag_id = (select fell_insert('Great Crag', 450, @c, 27, 'NY269147'));

set @gibson_knott_id = (select fell_insert('Gibson Knott', 420, @c, 10, 'NY319099'));

set @grange_fell_id = (select fell_insert('Grange Fell', 415, @c, 94, 'NY268172'));

set @helm_crag_id = (select fell_insert('Helm Crag', 405, @c, 60, 'NY327094'));

set @silver_how_id = (select fell_insert('Silver How', 395, @c, 30, 'NY325066'));

set @walla_crag_id = (select fell_insert('Walla Crag', 376, @c, 24, 'NY276212'));

set @high_rigg_id = (select fell_insert('High Rigg', 357, @c, 189, 'NY308220'));

set @loughrigg_fell_id = (select fell_insert('Loughrigg Fell', 335, @c, 172, 'NY347051'));

-- southern fells
set @scafell_pike_id = (select fell_insert('Scafell Pike', 978, @s, 912, 'NY215072'));

set @scafell_id = (select fell_insert('Scafell', 964, @s, 133, 'NY206064'));

set @great_end_id = (select fell_insert('Great End', 910, @s, 56, 'NY226084'));

set @bowfell_id = (select fell_insert('Bowfell', 903, @s, 146, 'NY245064'));

set @esk_pike_id = (select fell_insert('Esk Pike', 885, @s, 105, 'NY236074'));

set @crinkle_crags_id = (select fell_insert('Crinkle Crags', 859, @s, 138, 'NY248048'));

set @lingmell_id = (select fell_insert('Lingmell', 807, @s, 72, 'NY209081'));

set @coniston_old_man_id = (select fell_insert('Coniston Old Man', 803, @s, 416, 'SD272978'));

set @swirl_how_id = (select fell_insert('Swirl How', 802, @s, 112, 'NY273006'));

set @brim_fell_id = (select fell_insert('Brim Fell', 796, @s, 25, 'SD271986'));

set @great_carrs_id = (select fell_insert('Great Carrs', 785, @s, 20, 'NY271009'));

set @allen_crags_id = (select fell_insert('Allen Crags', 785, @s, 60, 'NY236085'));

set @glaramara_id = (select fell_insert('Glaramara', 783, @s, 121, 'NY246104'));

set @dow_crag_id = (select fell_insert('Dow Crag', 778, @s, 129, 'SD262977'));

set @grey_friar_id = (select fell_insert('Grey Friar', 773, @s, 78, 'NY259003'));

set @wetherlam_id = (select fell_insert('Wetherlam', 763, @s, 145, 'NY288011'));

set @slight_side_id = (select fell_insert('Slight Side', 762, @s, 14, 'NY209050'));

set @pike_o_blisco_id = (select fell_insert("Pike o' Blisco", 709, @s, 177, 'NY271042'));

set @cold_pike_id = (select fell_insert('Cold Pike', 701, @s, 46, 'NY262035'));

set @harter_fell_eskdale_id = (select fell_insert('Harter Fell (Eskdale)', 654, @s, 276, 'SD218997'));

set @rossett_pike_id = (select fell_insert('Rossett Pike', 651, @s, 35, 'NY249076'));

set @illgill_head_id = (select fell_insert('Illgill Head', 609, @s, 314, 'NY169049'));

set @seathwaite_fell_id = (select fell_insert('Seathwaite Fell', 601, @s, 31, 'NY227097'));

set @rosthwaite_fell_id = (select fell_insert('Rosthwaite Fell', 551, @s, 15, 'NY255118'));

set @hard_knott_id = (select fell_insert('Hard Knott', 549, @s, 154, 'NY231023'));

set @whin_rigg_id = (select fell_insert('Whin Rigg', 535, @s, 58, 'NY151034'));

set @green_crag_id = (select fell_insert('Green Crag', 489, @s, 145, 'SD200982'));

set @lingmoor_fell_id = (select fell_insert('Lingmoor Fell', 469, @s, 245, 'NY302046'));

set @black_fell_id = (select fell_insert('Black Fell', 323, @s, 126, 'NY341016'));

set @holme_fell_id = (select fell_insert('Holme Fell', 317, @s, 165, 'NY315006'));

-- northern fells
set @skiddaw_id = (select fell_insert('Skiddaw', 931, @n, 709, 'NY260290'));

set @blencathra_id = (select fell_insert('Blencathra', 868, @n, 461, 'NY323277'));

set @skiddaw_little_man_id = (select fell_insert('Skiddaw Little Man', 865, @n, 61, 'NY266277'));

set @carl_side_id = (select fell_insert('Carl Side', 746, @n, 30, 'NY255280'));

set @long_side_id = (select fell_insert('Long Side', 734, @n, 40, 'NY248284'));

set @lonscale_fell_id = (select fell_insert('Lonscale Fell', 715, @n, 50, 'NY285272'));

set @knott_id = (select fell_insert('Knott', 710, @n, 242, 'NY296329'));

set @bowscale_fell_id = (select fell_insert('Bowscale Fell', 702, @n, 90, 'NY334305'));

set @great_calva_id = (select fell_insert('Great Calva', 690, @n, 142, 'NY291312'));

set @ullock_pike_id = (select fell_insert('Ullock Pike', 690, @n, 14, 'NY244287'));

set @bannerdale_crags_id = (select fell_insert('Bannerdale Crags', 683, @n, 37, 'NY335290'));

set @bakestall_id = (select fell_insert('Bakestall', 673, @n, 8, 'NY266307'));

set @carrock_fell_id = (select fell_insert('Carrock Fell', 663, @n, 91, 'NY341336'));

set @high_pike_caldbeck_id = (select fell_insert('High Pike (Caldbeck)', 658, @n, 69, 'NY318350'));

set @great_sca_fell_id = (select fell_insert('Great Sca Fell', 651, @n, 13, 'NY291338'));

set @mungrisdale_common_id = (select fell_insert('Mungrisdale Common', 633, @n, 2, 'NY312292'));

set @brae_fell_id = (select fell_insert('Brae Fell', 586, @n, 16, 'NY288351'));

set @meal_fell_id = (select fell_insert('Meal Fell', 550, @n, 30, 'NY282337'));

set @great_cockup_id = (select fell_insert('Great Cockup', 526, @n, 85, 'NY273333'));

set @souther_fell_id = (select fell_insert('Souther Fell', 522, @n, 87, 'NY355292'));

set @dodd_id = (select fell_insert('Dodd', 502, @n, 120, 'NY244273'));

set @longlands_fell_id = (select fell_insert('Longlands Fell', 483, @n, 33, 'NY275353'));

set @binsey_id = (select fell_insert('Binsey', 447, @n, 242, 'NY225355'));

set @latrigg_id = (select fell_insert('Latrigg', 367, @n, 70, 'NY279247'));

-- north western fells
set @grasmoor_id = (select fell_insert('Grasmoor', 852, @nw, 519, 'NY174203'));

set @eel_crag_crag_hill_id = (select fell_insert('Eel Crag (Crag Hill)', 839, @nw, 117, 'NY192203'));

set @grisdale_pike_id = (select fell_insert('Grisedale Pike', 791, @nw, 189, 'NY198225'));

set @sail_id = (select fell_insert('Sail', 773, @nw, 32, 'NY198204'));

set @wandope_id = (select fell_insert('Wandope', 772, @nw, 30, 'NY188197'));

set @hopegill_head_id = (select fell_insert('Hopegill Head', 770, @nw, 97, 'NY185221'));

set @dale_head_id = (select fell_insert('Dale Head', 753, @nw, 397, 'NY223153'));

set @robinson_id = (select fell_insert('Robinson', 737, @nw, 161, 'NY201168'));

set @hindscarth_id = (select fell_insert('Hindscarth', 727, @nw, 71, 'NY215165'));

set @whiteside_id = (select fell_insert('Whiteside', 707, @nw, 34, 'NY175221'));

set @scar_crags_id = (select fell_insert('Scar Crags', 672, @nw, 55, 'NY208206'));

set @whiteless_pike_id = (select fell_insert('Whiteless Pike', 660, @nw, 35, 'NY180189'));

set @high_spy_id = (select fell_insert('High Spy', 653, @nw, 148, 'NY234162'));

set @causey_pike_id = (select fell_insert('Causey Pike', 637, @nw, 40, 'NY218208'));

set @maiden_moor_id = (select fell_insert('Maiden Moor', 575, @nw, 16, 'NY236182'));

set @ard_crags_id = (select fell_insert('Ard Crags', 581, @nw, 120, 'NY206197'));

set @outerside_id = (select fell_insert('Outerside', 568, @nw, 70, 'NY211214'));

set @knott_rigg_id = (select fell_insert('Knott Rigg', 556, @nw, 61, 'NY197188'));

set @lords_seat_id = (select fell_insert("Lord's Seat", 552, @nw, 237, 'NY204265'));

set @whinlatter_id = (select fell_insert('Whinlatter', 517, @nw, 60, 'NY197249'));

set @broom_fell_id = (select fell_insert('Broom Fell', 511, @nw, 25, 'NY195271'));

set @barf_id = (select fell_insert('Barf', 468, @nw, 20, 'NY216267'));

set @barrow_id = (select fell_insert('Barrow', 455, @nw, 60, 'NY226218'));

set @graystones_id = (select fell_insert('Graystones', 452, @nw, 80, 'NY177266'));

set @catbells_id = (select fell_insert('Catbells', 451, @nw, 86, 'NY244199'));

set @ling_fell_id = (select fell_insert('Ling Fell', 373, @nw, 97, 'NY179286'));

set @sale_fell_id = (select fell_insert('Sale Fell', 359, @nw, 125, 'NY194297'));

set @rannerdale_knotts_id = (select fell_insert('Rannerdale Knotts', 355, @nw, 70, 'NY167182'));

set @castle_crag_id = (select fell_insert('Castle Crag', 298, @nw, 75, 'NY249159'));

-- western fells
set @great_gable_id = (select fell_insert('Great Gable', 899, @w, 425, 'NY211104'));

set @pillar_id = (select fell_insert('Pillar', 892, @w, 348, 'NY171121'));

set @scoat_fell_id = (select fell_insert('Scoat Fell', 841, @w, 46, 'NY159113'));

set @red_pike_wasdale_id = (select fell_insert('Red Pike (Wasdale)', 826, @w, 62, 'NY165105'));

set @steeple_id = (select fell_insert('Steeple', 819, @w, 21, 'NY157116'));

set @high_stile_id = (select fell_insert('High Stile', 807, @w, 362, 'NY170148'));

set @kirk_fell_id = (select fell_insert('Kirk Fell', 802, @w, 181, 'NY195104'));

set @green_gable_id = (select fell_insert('Green Gable', 801, @w, 50, 'NY214107'));

set @haycock_id = (select fell_insert('Haycock', 797, @w, 94, 'NY144107'));

set @red_pike_buttermere_id = (select fell_insert('Red Pike (Buttermere)', 755, @w, 40, 'NY160154'));

set @high_crag_id = (select fell_insert('High Crag', 744, @w, 29, 'NY180140'));

set @brandreth_id = (select fell_insert('Brandreth', 715, @w, 60, 'NY215119'));

set @caw_fell_id = (select fell_insert('Caw Fell', 697, @w, 22, 'NY132109'));

set @grey_knotts_id = (select fell_insert('Grey Knotts', 697, @w, 15, 'NY217125'));

set @seatallan_id = (select fell_insert('Seatallan', 692, @w, 193, 'NY139084'));

set @fleetwith_pike_id = (select fell_insert('Fleetwith Pike', 648, @w, 117, 'NY205141'));

set @base_brown_id = (select fell_insert('Base Brown', 646, @w, 38, 'NY225114'));

set @starling_dodd_id = (select fell_insert('Starling Dodd', 633, @w, 60, 'NY142158'));

set @yewbarrow_id = (select fell_insert('Yewbarrow', 628, @w, 142, 'NY173084'));

set @great_borne_id = (select fell_insert('Great Borne', 616, @w, 113, 'NY124163'));

set @haystacks_id = (select fell_insert('Haystacks', 597, @w, 92, 'NY193131'));

set @middle_fell_id = (select fell_insert('Middle Fell', 582, @w, 117, 'NY151072'));

set @blake_fell_id = (select fell_insert('Blake Fell', 573, @w, 164, 'NY110196'));

set @lank_rigg_id = (select fell_insert('Lank Rigg', 541, @w, 111, 'NY092119'));

set @gavel_fell_id = (select fell_insert('Gavel Fell', 526, @w, 75, 'NY117184'));

set @crag_fell_id = (select fell_insert('Crag Fell', 523, @w, 115, 'NY097144'));

set @mellbreak_id = (select fell_insert('Mellbreak', 512, @w, 260, 'NY148186'));

set @hen_comb_id = (select fell_insert('Hen Comb', 509, @w, 145, 'NY133181'));

set @grike_id = (select fell_insert('Grike', 488, @w, 37, 'NY086141'));

set @burnbank_fell_id = (select fell_insert('Burnbank Fell', 475, @w, 20, 'NY110209'));

set @low_fell_id = (select fell_insert('Low Fell', 423, @w, 270, 'NY137226'));

set @buckbarrow_id = (select fell_insert('Buckbarrow', 423, @w, 5, 'NY135061'));

set @fellbarrow_id = (select fell_insert('Fellbarrow', 416, @w, 50, 'NY132243'));

-- update overall height rank
set @row_number = 0;
UPDATE fells 
SET overall_height_rank = (
    SELECT @row_number := @row_number +1) 
    ORDER BY fell_height_meters desc;

alter table fells modify overall_height_rank int not null;

/***************************************************************************************************
* Listings
***************************************************************************************************/
create table listings (
    listing_id int not null unique auto_increment,
    listing_name varchar(25) not null,
    primary key (listing_id)
);

insert into listings (listing_name) 
values 
    ('Wainwright'),
    ('Hewitt'),
    ('Marilyn'),
    ('Nuttall'),
    ('Country high point');

/***************************************************************************************************
* OS MAPS
***************************************************************************************************/
create table os_maps (
    map_id int not null unique auto_increment,
    map_name varchar(25) not null,
    primary key (map_id)
);

insert into os_maps (map_name)
values 
    ('OS Landrangers 89'),
    ('OS Landrangers 90'),
    ('OS Landrangers 96'),
    ('OS Landrangers 97'),
    ('OS Explorer OL4'),
    ('OS Explorer OL5'),
    ('OS Explorer OL6'),
    ('OS Explorer OL7');

/***************************************************************************************************
* PARENT PEAKS
***************************************************************************************************/
create table parent_peaks (
    parent_peak_id int not null unique auto_increment,
    parent_peak_name varchar(25) not null,
    primary key (parent_peak_id)
);

insert into parent_peaks (parent_peak_name)
values 
    ('Snowdon'),
    ('Scafell Pike');

/***************************************************************************************************
* FELL DECIMAL COORDS
***************************************************************************************************/
create table fell_decimal_coords (
    fell_id int not null unique,
    latitude double not null,
    longitude double not null,
    primary key (fell_id)
);

insert into fell_decimal_coords (fell_id, latitude, longitude)
values 
    -- eastern fells -----------------------------------------
    (@helvellyn_id, 54.527232, -3.016054),
    (@nethermost_pike_id, 54.51882, -3.01646),
    (@catstye_cam_id, 54.53326, -3.00909),
    (@raise_id, 54.547, -3.014),
    (@fairfield_id, 54.496883, -2.990594),
    (@white_side_id, 54.5403, -3.02626),
    (@dollywaggon_pike_id, 54.50807, -3.01156),
    (@great_dodd_id, 54.57541, -3.01941),
    (@styebarrow_dodd_id, 54.56105, -3.01751),
    (@st_sunday_crag_id, 54.51286, -2.97615),
    (@hart_crag_id, 54.49308, -2.97722),
    (@dove_crag_id, 54.48506, -2.96777),
    (@watsons_dodd_id, 54.56725, -3.02849),
    (@red_screes_id, 54.47006, -2.93347),
    (@great_rigg_id, 54.48483, -2.99709),
    (@hart_side_id, 54.56934, -2.99297),
    (@seat_sandal_id, 54.49456, -3.01585),
    (@clough_head_id, 54.59326, -3.03379),
    (@birkhouse_moor_id, 54.53526, -2.98441),
    (@sheffield_pike_id, 54.55508, -2.9787),
    (@high_pike_scandale_id, 54.47, -2.968),
    (@middle_dodd_id, 54.47815, -2.93211),
    (@little_hart_crag_id, 54.48163, -2.94762),
    (@birks_id, 54.52, -2.956),
    (@heron_pike_id, 54.46506, -2.99661),
    (@hartsop_above_how_id, 54.49955, -2.95421),
    (@great_mell_fell_id, 54.62, -2.933),
    (@high_hartsop_dodd_id, 54.48889, -2.93853),
    (@low_pike_id, 54.46079, -2.96874),
    (@little_mell_fell_id, 54.60785, -2.89482),
    (@stone_arthur_id, 54.47485, -3.00765),
    (@gowbarrow_fell_id, 54.58881, -2.91761),
    (@nab_scar_id, 54.457, -2.996),
    (@glenridding_dodd_id, 54.54895, -2.95846),
    (@arnison_crag_id, 54.52663, -2.93939),
    -- far eastern fells -----------------------------------------
    (@high_street_id, 54.492, -2.865),
    (@high_raise_haweswater_id, 54.513, -2.851),
    (@rampsgill_head_id, 54.50744, -2.86173),
    (@thornthwaite_crag_id, 54.48305, -2.8782),
    (@kidsty_pike_id, 54.50568, -2.85552),
    (@harter_fell_mardale_id, 54.476, -2.835),
    (@caudale_moor_id, 54.48198, -2.90133),
    (@mardale_ill_bell_id, 54.48413, -2.85352),
    (@ill_bell_id, 54.46243, -2.87158),
    (@the_knott_id, 54.50646, -2.87252),
    (@kentmere_pike_id, 54.46274, -2.82685),
    (@froswick_id, 54.46871, -2.87326),
    (@branstree_id, 54.48264, -2.80873),
    (@yoke_id, 54.451, -2.869),
    (@gray_crag_id, 54.49737, -2.88622),
    (@rest_dodd_id, 54.5154, -2.87889),
    (@loadpot_hill_id, 54.55521, -2.84109),
    (@wether_hill_id, 54.542, -2.839),
    (@tarn_crag_longsleddale_id, 54.463, -2.787),
    (@place_fell_id, 54.54384, -2.92124),
    (@selside_pike_id,54.49294, -2.78849),
    (@grey_crag_id, 54.45768, -2.77739),
    (@hartsop_dodd_id, 54.4981, -2.9094),
    (@shipman_knotts_id, @54.44934, -2.81579),
    (@the_nab_id, 54.5289, -2.87609),
    (@angletarn_pikes_id, 54.52507, -2.90845),
    (@brock_crags_id, 54.51525, -2.89897),
    (@arthurs_pike_id, 54.57772, -2.83537),
    (@bonscale_pike_id, 54.57314, -2.84765),
    (@sallows_id, 54.42829, -2.86932),
    (@beda_fell_id, 54.5459, -2.88728),
    (@wansfell_id, 54.43779, -2.92194),
    (@sour_howes_id, 54.42099, -2.88457),
    (@steel_knotts_id, 54.55503, -2.86737),
    (@hallin_fell_id, 54.57057, -2.876354),
    (@troutbeck_tongue_id, 54.44969, -2.8929),
    -- central fells -----------------------------------------
    (@high_raise_langdale_id, 54.476, -3.113),
    (@sergeant_man_id, 54.47042, -3.10321),
    (@harrison_stickle_id, 54.45687, -3.11056),
    (@ullscarth_id, 54.50016, -3.09475),
    (@thunacar_knott_id, 54.46134, -3.11376),
    (@pike_of_stickle_id, 54.45586, -3.12287),
    (@pavey_ark_id, 54.46142, -3.10451),
    (@loft_crag_id, 54.45412, -3.11665),
    (@high_seat_id, 54.552, -3.104),
    (@bleaberry_fell_id, 54.56565, -3.10733),
    (@sergeants_crag_id, 54.49271, -3.12234),
    (@steel_fell_id, 54.49154, -3.05283),
    (@tarn_crag_easedale_id, 54.473, -3.076),
    (@blea_rigg_id, 54.46076, -3.07827),
    (@calf_crag_id, 54.48502, -3.07891),
    (@high_tove_id, 54.53964, -3.10199),
    (@eagle_crag_id, 54.49902, -3.12097),
    (@armboth_fell_id, 54.53347, -3.08791),
    (@raven_crag_id, 54.55963, -3.07778),
    (@great_crag_id, 54.52229, -3.13087),
    (@gibson_knott_id, 54.47986, -3.05253),
    (@grange_fell_id, 54.54437, -3.13253),
    (@helm_crag_id, 54.47548, -3.04007),
    (@silver_how_id, 54.45029, -3.04252),
    (@walla_crag_id, 54.5808, -3.12166),
    (@high_rigg_id, 54.58843, -3.07235),
    (@loughrigg_fell_id, 54.4371, -3.00826),
    -- southern fells -----------------------------------------
    (@scafell_pike_id, 54.454222, -3.211528),
    (@scafell_id, 54.448, -3.225),
    (@great_end_id, 54.464, -3.194),
    (@bowfell_id, 54.44737, -3.16582),
    (@esk_pike_id, 54.45622, -3.17995),
    (@crinkle_crags_id, 54.433, -3.159),
    (@lingmell_id, 54.46209, -3.22178),
    (@coniston_old_man_id, 54.37, -3.119),
    (@swirl_how_id, 54.39566, -3.12123),
    (@brim_fell_id, 54.37766, -3.12381),
    (@great_carrs_id, 54.39833, -3.12438),
    (@allen_crags_id, 54.4661, -3.18024),
    (@glaramara_id, 54.48332, -3.1653),
    (@dow_crag_id, 54.36944, -3.13744),
    (@grey_friar_id, 54.39276, -3.14271),
    (@wetherlam_id, 54.401, -3.098),
    (@slight_side_id, 54.43424, -3.22095),
    (@pike_o_blisco_id, 54.42798, -3.12519),
    (@cold_pike_id, 54.421, -3.134),
    (@harter_fell_eskdale_id, 54.388333, -3.204167),
    (@rossett_pike_id, 54.45821, -3.15996),
    (@illgill_head_id, 54.4327, -3.28257),
    (@seathwaite_fell_id, 54.478, -3.192),
    (@rosthwaite_fell_id, 54.49603, -3.15176),
    (@hard_knott_id, 54.41032, -3.18634),
    (@whin_rigg_id, 54.41893, -3.30988),
    (@green_crag_id, 54.373889, -3.2325),
    (@lingmoor_fell_id, 54.43208, -3.07626),
    (@black_fell_id, 54.40557, -3.01673),
    (@holme_fell_id, 54.396, -3.056),
    -- northern fells -----------------------------------------
    (@skiddaw_id, 54.647, -3.146),
    (@blencathra_id, 54.63985, -3.05046),
    (@skiddaw_little_man_id, 54.63906, -3.13876),
    (@carl_side_id, 54.64159, -3.15588),
    (@long_side_id, 54.645, -3.165),
    (@lonscale_fell_id, 54.63484, -3.10921),
    (@knott_id, 54.68621, -3.09354),
    (@bowscale_fell_id, 54.66516, -3.03406),
    (@great_calva_id, 54.669, -3.102),
    (@ullock_pike_id, 54.648, -3.173),
    (@bannerdale_crags_id, 54.65169, -3.03217),
    (@bakestall_id, 54.65169, -3.03217),
    (@carrock_fell_id, 54.693561, -3.023148),
    (@high_pike_caldbeck_id, 54.705, -3.06),
    (@great_sca_fell_id, 54.69422, -3.10152),
    (@mungrisdale_common_id, 54.65227, -3.06938),
    (@brae_fell_id, 54.70586, -3.10649),
    (@meal_fell_id, 54.6932, -3.11545),
    (@great_cockup_id, 54.68947, -3.12931),
    (@souther_fell_id, 54.65375, -3.00122),
    (@dodd_id, 54.635, -3.17),
    (@longlands_fell_id, 54.70747, -3.12671),
    (@binsey_id, 54.70852, -3.20434),
    (@latrigg_id, 54.61229, -3.11788),
    -- north western fells -----------------------------------------
    (@grasmoor_id, 54.57115, -3.27918),
    (@eel_crag_crag_hill_id, 54.572, -3.25),
    (@grisdale_pike_id, 54.592, -3.241),
    (@sail_id, 54.571, -3.242),
    (@wandope_id, 54.56598, -3.25736),
    (@hopegill_head_id, 54.5875, -3.26267),
    (@dale_head_id, 54.527, -3.20208),
    (@robinson_id, 54.54, -3.236),
    (@hindscarth_id, 54.53766, -3.21476),
    (@whiteside_id, 54.587, -3.279),
    (@scar_crags_id, 54.57439, -3.22668),
    (@whiteless_pike_id, 54.55867, -3.26951),
    (@high_spy_id, 54.534, -3.185),
    (@causey_pike_id, 54.57634, -3.21127),
    (@maiden_moor_id, 54.55325, -3.18275),
    (@ard_crags_id, 54.56627, -3.22953),
    (@outerside_id, 54.58162, -3.22226),
    (@knott_rigg_id, 54.558, -3.242),
    (@lords_seat_id, 54.627, -3.235),
    (@whinlatter_id, 54.614, -3.252),
    (@broom_fell_id, 54.631, -3.248),
    (@barf_id, 54.63, -3.218),
    (@barrow_id, 54.585799, -3.197034),
    (@graystones_id, 54.627, -3.275),
    (@catbells_id, 54.56865, -3.17083),
    (@ling_fell_id, 54.645, -3.274),
    (@sale_fell_id, 54.656, -3.248),
    (@rannerdale_knotts_id, 54.55216, -3.28941),
    (@castle_crag_id, 54.53278, -3.16207),
    -- western fells -----------------------------------------
    (@great_gable_id, 54.482, -3.219),
    (@pillar_id, 54.497, -3.282),
    (@scoat_fell_id, 54.49004, -3.2998),
    (@red_pike_wasdale_id, 54.483, -3.29),
    (@steeple_id, 54.493, -3.302),
    (@high_stile_id, 54.52167, -3.28381),
    (@kirk_fell_id, 54.483, -3.242),
    (@green_gable_id, 54.48553, -3.21476),
    (@haycock_id, 54.4844, -3.32278),
    (@red_pike_buttermere_id, 54.526, -3.3),
    (@high_crag_id, 54.51464, -3.26814),
    (@brandreth_id, 54.496, -3.212),
    (@caw_fell_id, 54.486, -3.343),
    (@grey_knotts_id, 54.503, -3.208),
    (@seatallan_id, 54.46365, -3.32982),
    (@fleetwith_pike_id, 54.51594, -3.22956),
    (@base_brown_id, 54.49199, -3.19797),
    (@starling_dodd_id, 54.53018, -3.32735),
    (@yewbarrow_id, 54.46421, -3.27738),
    (@great_borne_id, 54.53435, -3.35685),
    (@haystacks_id, 54.508, -3.248),
    (@middle_fell_id, 54.454, -3.311),
    (@blake_fell_id, 54.56377, -3.37793),
    (@lank_rigg_id, 54.494, -3.403),
    (@gavel_fell_id, 54.553, -3.368),
    (@crag_fell_id, 54.517, -3.397),
    (@mellbreak_id, 54.55544, -3.31889),
    (@hen_comb_id, 54.551, -3.342),
    (@grike_id, 54.513, -3.415),
    (@burnbank_fell_id, 54.575, -3.375),
    (@low_fell_id, 54.59119, -3.33707),
    (@buckbarrow_id, 54.442, -3.33514),
    (@fellbarrow_id, 54.605, -3.342);

/***************************************************************************************************
* LAKES
***************************************************************************************************/
create table lakes (
    lake_id int not null auto_increment,
    lake_name varchar(25) not null,
    primary key (lake_id)
);

insert into lakes (lake_name) values ('Windermere');
insert into lakes (lake_name) values ('Ullswater');
insert into lakes (lake_name) values ('Derwentwater');
insert into lakes (lake_name) values ('Bassenthwaite Lake');
insert into lakes (lake_name) values ('Coniston Water');
insert into lakes (lake_name) values ('Haweswater');
insert into lakes (lake_name) values ('Thirlmere');
insert into lakes (lake_name) values ('Ennerdale Water');
insert into lakes (lake_name) values ('Wastwater');
insert into lakes (lake_name) values ('Crummock Water');
insert into lakes (lake_name) values ('Esthwaite Water');
insert into lakes (lake_name) values ('Buttermere');
insert into lakes (lake_name) values ('Grasmere');
insert into lakes (lake_name) values ('Loweswater');
insert into lakes (lake_name) values ('Rydal Water');
insert into lakes (lake_name) values ('Brotherswater');

