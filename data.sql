/***********************************************************************
 * INIT
 ***********************************************************************/
DROP DATABASE IF EXISTS wainwright_fells;
CREATE DATABASE wainwright_fells;
SET collation_connection = 'utf8_general_ci';
ALTER DATABASE wainwright_fells CHARACTER SET utf8 collate utf8_general_ci;
USE wainwright_fells;

CREATE TABLE lakes (
    id INT NOT NULL auto_increment,
    name VARCHAR(25) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE regions (
    id INT NOT NULL auto_increment,
    name VARCHAR(30) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE os_maps (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(25) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE classifications (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(25) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE fells (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(25) NOT NULL,
    height_meters INT NOT NULL,
    prominence_meters INT NOT NULL,
    region_id INT NOT NULL,
    parent_peak_id INT, -- is modified to be NOT NULL after all the fells are inserted 
    PRIMARY KEY (id),
    FOREIGN KEY (region_id) REFERENCES regions(id),
    FOREIGN KEY (parent_peak_id) REFERENCES fells(id)
);

CREATE TABLE locations (
    fell_id INT NOT NULL UNIQUE,
    latitude double NOT NULL,
    longitude double NOT NULL,
    os_map_ref VARCHAR(8) NOT NULL UNIQUE,
    FOREIGN KEY (fell_id) REFERENCES fells(id),
    UNIQUE (latitude, longitude)
);

CREATE TABLE fells_classifications (
    fell_id INT NOT NULL,
    classification_id INT NOT NULL,
    FOREIGN KEY (fell_id) REFERENCES fells(id),
    FOREIGN KEY (classification_id) REFERENCES classifications(id),
    UNIQUE (fell_id, classification_id)
);

CREATE TABLE fells_osmaps (
    fell_id INT NOT NULL,
    os_map_id INT NOT NULL,
    FOREIGN KEY (fell_id) REFERENCES fells(id),
    FOREIGN KEY (os_map_id) REFERENCES os_maps(id),
    UNIQUE (fell_id, os_map_id)
);

/***************************************************************************************************
* LAKES
***************************************************************************************************/
INSERT INTO lakes (name) 
VALUES 
    ('Windermere'),
    ('Ullswater'),
    ('Derwentwater'),
    ('Bassenthwaite Lake'),
    ('Coniston Water'),
    ('Haweswater'),
    ('Thirlmere'),
    ('Ennerdale Water'),
    ('Wastwater'),
    ('Crummock Water'),
    ('Esthwaite Water'),
    ('Buttermere'),
    ('Grasmere'),
    ('Loweswater'),
    ('Rydal Water'),
    ('Brotherswater');

/***************************************************************************************************
 * REGIONS
 **************************************************************************************************/
INSERT INTO regions (name) VALUES('Eastern Lake District');
SET @e = (SELECT last_insert_id());

INSERT INTO regions (name) VALUES('Far Eastern Lake District');
SET @fe = (SELECT last_insert_id());

INSERT INTO regions (name) VALUES('Central Lake District');
SET @c = (SELECT last_insert_id());

INSERT INTO regions (name) VALUES('Southern Lake District');
SET @s = (SELECT last_insert_id());

INSERT INTO regions (name) VALUES('Northern Lake District');
SET @n = (SELECT last_insert_id());

INSERT INTO regions (name) VALUES('North Western Lake District');
SET @nw = (SELECT last_insert_id());

INSERT INTO regions (name) VALUES('Western Lake District');
SET @w = (SELECT last_insert_id());

INSERT INTO regions (name) VALUES('Scottish Highlands');
SET @sh = (SELECT last_insert_id());

INSERT INTO regions (name) VALUES('Snowdonia');
SET @sd = (SELECT last_insert_id());

/***************************************************************************************************
* OS MAPS
***************************************************************************************************/
INSERT INTO os_maps (name) VALUES ('OS Landrangers 89');
SET @os_map_lr_89_id = (SELECT last_insert_id());

INSERT INTO os_maps (name) VALUES ('OS Landrangers 90');
SET @os_map_lr_90_id = (SELECT last_insert_id());

INSERT INTO os_maps (name) VALUES ('OS Landrangers 96');
SET @os_map_lr_96_id = (SELECT last_insert_id());

INSERT INTO os_maps (name) VALUES ('OS Landrangers 97');
SET @os_map_lr_97_id = (SELECT last_insert_id());

INSERT INTO os_maps (name) VALUES ('OS Explorer OL4');
SET @os_map_ex_4_id = (SELECT last_insert_id());

INSERT INTO os_maps (name) VALUES ('OS Explorer OL5');
SET @os_map_ex_5_id = (SELECT last_insert_id());

INSERT INTO os_maps (name) VALUES ('OS Explorer OL6');
SET @os_map_ex_6_id = (SELECT last_insert_id());

INSERT INTO os_maps (name) VALUES ('OS Explorer OL7');
SET @os_map_ex_7_id = (SELECT last_insert_id());

/***************************************************************************************************
 * FELLS
 **************************************************************************************************/
DROP FUNCTION IF EXISTS fell_insert;
DELIMITER //
CREATE FUNCTION fell_insert(
    name VARCHAR(50), 
    height_meters INT, 
    region_id INT, 
    prominence_meters INT,
    parent_peak_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    INSERT INTO fells 
        (name, height_meters, region_id, prominence_meters, parent_peak_id) 
    VALUES 
        (name, height_meters, region_id, prominence_meters, parent_peak_id);

    RETURN last_insert_id();
END//
DELIMITER ;

SET @helvellyn = 'Helvellyn';
SET @nethermost_pike = 'Nethermost Pike';
SET @catstye_cam = 'Catstye Cam';
SET @raise = 'Raise';
SET @fairfield = 'Fairfield';
SET @white_side = 'White Side';
SET @dollywaggon_pike = 'Dollywaggon Pike';
SET @great_dodd = 'Great Dodd';
SET @stybarrow_dodd = 'Stybarrow Dodd';
SET @st_sunday_crag = 'St Sunday Crag';
SET @hart_crag = 'Hart Crag';
SET @dove_crag = 'Dove Crag';
SET @watsons_dodd = "Watson's Dodd";
SET @red_screes = 'Red Screes';
SET @great_rigg = 'Great Rigg';
SET @hart_side = 'Hart Side';
SET @seat_sandal = 'Seat Sandal';
SET @clough_head = 'Clough Head';
SET @birkhouse_moor = 'Birkhouse Moor';
SET @sheffield_pike = 'Sheffield Pike';
SET @high_pike_scandale = 'High Pike (Scandale)';
SET @middle_dodd = 'Middle Dodd';
SET @little_hart_crag = 'Little Hart Crag';
SET @birks = 'Birks';
SET @heron_pike = 'Heron Pike';
SET @hartsop_above_how = 'Hartsop Above How';
SET @great_mell_fell = 'Great Mell Fell';
SET @high_hartsop_dodd = 'High Hartsop Dodd';
SET @low_pike = 'Low Pike';
SET @little_mell_fell = 'Little Mell Fell';
SET @stone_arthur = 'Stone Arthur';
SET @gowbarrow_fell = 'Gowbarrow Fell';
SET @nab_scar = 'Nab Scar';
SET @glenridding_dodd = 'Glenridding Dodd';
SET @arnison_crag = 'Arnison Crag';

SET @ben_nevis_id = (SELECT fell_insert('Ben Nevis', 1344, @sh, 1344, 0));
UPDATE fells SET parent_peak_id = @ben_nevis_id WHERE id = @ben_nevis_id;

SET @snowdon_id = (SELECT fell_insert('Snowdon', 1085, @sd, 1039, @ben_nevis_id));

SET @scafell_pike_id = (SELECT fell_insert('Scafell Pike', 978, @s, 912, @snowdon_id));

SET @scafell_id = (SELECT fell_insert('Scafell', 964, @s, 133, @scafell_pike_id));

SET @helvellyn_id = (SELECT fell_insert(@helvellyn, 950, @e, 712, @scafell_pike_id));

SET @skiddaw_id = (SELECT fell_insert('Skiddaw', 931, @n, 709, 0));
UPDATE fells set parent_peak_id = @skiddaw_id WHERE id = @skiddaw_id;

SET @great_end_id = (SELECT fell_insert('Great End', 910, @s, 56, @scafell_pike_id));

SET @bowfell_id = (SELECT fell_insert('Bowfell', 903, @s, 146, @scafell_pike_id));

SET @great_gable_id = (SELECT fell_insert('Great Gable', 899, @w, 425, @scafell_pike_id));

SET @pillar_id = (SELECT fell_insert('Pillar', 892, @w, 348, @great_gable_id));

SET @nethermost_pike_id = (SELECT fell_insert(@nethermost_pike, 891, @e, 22, @helvellyn_id));

SET @catstye_cam_id = (SELECT fell_insert(@catstye_cam, 890, @e, 63, @helvellyn_id));

SET @esk_pike_id = (SELECT fell_insert('Esk Pike', 885, @s, 105, @bowfell_id));

SET @raise_id = (SELECT fell_insert(@raise, 883, @e, 88, @helvellyn_id));

SET @fairfield_id = (SELECT fell_insert(@fairfield, 873, @e, 299, @helvellyn_id));

SET @blencathra_id = (SELECT fell_insert('Blencathra', 868, @n, 461, @skiddaw_id));

SET @skiddaw_little_man_id = (SELECT fell_insert('Skiddaw Little Man', 865, @n, 61, @skiddaw_id));

SET @white_side_id = (SELECT fell_insert(@white_side, 863, @e, 42, @raise_id));

SET @crinkle_crags_id = (SELECT fell_insert('Crinkle Crags', 859, @s, 138, @scafell_pike_id));

SET @dollywaggon_pike_id = (SELECT fell_insert(@dollywaggon_pike, 858, @e, 50, @helvellyn_id));

SET @great_dodd_id = (SELECT fell_insert(@great_dodd, 857, @e, 109, @helvellyn_id));

SET @grasmoor_id = (SELECT fell_insert('Grasmoor', 852, @nw, 519, @scafell_pike_id));

SET @stybarrow_dodd_id = (SELECT fell_insert(@stybarrow_dodd, 843, @e, 68, @great_dodd_id));

SET @scoat_fell_id = (SELECT fell_insert('Scoat Fell', 841, @w, 46, @pillar_id));

SET @st_sunday_crag_id = (SELECT fell_insert(@st_sunday_crag, 841, @e, 166, @fairfield_id));

SET @eel_crag_crag_hill_id = (SELECT fell_insert('Eel Crag (Crag Hill)', 839, @nw, 117, @grasmoor_id));

SET @high_street_id = (SELECT fell_insert('High Street', 828, @fe, 373, @helvellyn_id));

SET @red_pike_wasdale_id = (SELECT fell_insert('Red Pike (Wasdale)', 826, @w, 62, @pillar_id));

SET @hart_crag_id = (SELECT fell_insert(@hart_crag, 822, @e, 50, @fairfield_id));

SET @steeple_id = (SELECT fell_insert('Steeple', 819, @w, 21, @pillar_id));

SET @lingmell_id = (SELECT fell_insert('Lingmell', 807, @s, 72, @scafell_pike_id));

SET @high_stile_id = (SELECT fell_insert('High Stile', 807, @w, 362, @great_gable_id));

SET @coniston_old_man_id = (SELECT fell_insert('Coniston Old Man', 803, @s, 416, 0));
UPDATE fells set parent_peak_id = @coniston_old_man_id WHERE id = @coniston_old_man_id;

SET @swirl_how_id = (SELECT fell_insert('Swirl How', 802, @s, 112, @coniston_old_man_id));

SET @kirk_fell_id = (SELECT fell_insert('Kirk Fell', 802, @w, 181, @great_gable_id));

SET @high_raise_haweswater_id = (SELECT fell_insert('High Raise (Haweswater)', 802, @fe, 90, @high_street_id));

SET @green_gable_id = (SELECT fell_insert('Green Gable', 801, @w, 50, @great_gable_id));

SET @haycock_id = (SELECT fell_insert('Haycock', 797, @w, 94, @pillar_id));

SET @brim_fell_id = (SELECT fell_insert('Brim Fell', 796, @s, 25, @coniston_old_man_id));

SET @rampsgill_head_id = (SELECT fell_insert('Rampsgill Head', 792, @fe, 40, @high_raise_haweswater_id));

SET @dove_crag_id = (SELECT fell_insert(@dove_crag, 792, @e, 50, @hart_crag_id));

SET @grisedale_pike_id = (SELECT fell_insert('Grisedale Pike', 791, @nw, 189, @grasmoor_id));

SET @watsons_dodd_id = (SELECT fell_insert(@watsons_dodd, 789, @e, 11, @great_dodd_id));

SET @allen_crags_id = (SELECT fell_insert('Allen Crags', 785, @s, 60, @scafell_pike_id));

SET @great_carrs_id = (SELECT fell_insert('Great Carrs', 785, @s, 20, @swirl_how_id));

SET @thornthwaite_crag_id = (SELECT fell_insert('Thornthwaite Crag', 784, @fe, 30, @high_street_id));

SET @glaramara_id = (SELECT fell_insert('Glaramara', 783, @s, 121, @scafell_pike_id));

SET @kidsty_pike_id = (SELECT fell_insert('Kidsty Pike', 780, @fe, 15, @rampsgill_head_id));

SET @harter_fell_mardale_id = (SELECT fell_insert('Harter Fell (Mardale)', 778, @fe, 149, @high_street_id));

SET @dow_crag_id = (SELECT fell_insert('Dow Crag', 778, @s, 129, @coniston_old_man_id));

SET @red_screes_id = (SELECT fell_insert(@red_screes, 776, @e, 260, @fairfield_id));

SET @sail_id = (SELECT fell_insert('Sail', 773, @nw, 32, @eel_crag_crag_hill_id));

SET @grey_friar_id = (SELECT fell_insert('Grey Friar', 773, @s, 78, @swirl_how_id));

SET @wandope_id = (SELECT fell_insert('Wandope', 772, @nw, 30, @eel_crag_crag_hill_id));

SET @hopegill_head_id = (SELECT fell_insert('Hopegill Head', 770, @nw, 97, @grisedale_pike_id));

SET @great_rigg_id = (SELECT fell_insert(@great_rigg, 766, @e, 31, @fairfield_id));

SET @caudale_moor_id = (SELECT fell_insert('Caudale Moor', 763, @fe, 171, @scafell_id));

SET @wetherlam_id = (SELECT fell_insert('Wetherlam', 763, @s, 145, @coniston_old_man_id));

SET @high_raise_langdale_id = (SELECT fell_insert('High Raise (Langdale)', 762, @c, 283, @scafell_pike_id));

SET @slight_side_id = (SELECT fell_insert('Slight Side', 762, @s, 14, @scafell_id));

SET @mardale_ill_bell_id = (SELECT fell_insert('Mardale Ill Bell', 760, @fe, 14, @high_street_id));

SET @ill_bell_id = (SELECT fell_insert('Ill Bell', 757, @fe, 124, @high_street_id));

SET @hart_side_id = (SELECT fell_insert(@hart_side, 756, @e, 23, @stybarrow_dodd_id));

SET @red_pike_buttermere_id = (SELECT fell_insert('Red Pike (Buttermere)', 755, @w, 40, @high_stile_id));

SET @dale_head_id = (SELECT fell_insert('Dale Head', 753, @nw, 397, @great_gable_id));

SET @carl_side_id = (SELECT fell_insert('Carl Side', 746, @n, 30, @skiddaw_id));

SET @high_crag_id = (SELECT fell_insert('High Crag', 744, @w, 29, @high_stile_id));

SET @the_knott_id = (SELECT fell_insert('The Knott', 739, @fe, 14, @rampsgill_head_id));

SET @robinson_id = (SELECT fell_insert('Robinson', 737, @nw, 161, @dale_head_id));

SET @seat_sandal_id = (SELECT fell_insert(@seat_sandal, 736, @e, 150, @fairfield_id));

SET @harrison_stickle_id = (SELECT fell_insert('Harrison Stickle', 736, @c, 53, @high_raise_langdale_id));

SET @sergeant_man_id = (SELECT fell_insert('Sergeant Man', 736, @c, 10, @high_raise_langdale_id));

SET @long_side_id = (SELECT fell_insert('Long Side', 734, @n, 40, @skiddaw_id));

SET @kentmere_pike_id = (SELECT fell_insert('Kentmere Pike', 730, @fe, 35, @harter_fell_mardale_id));

SET @hindscarth_id = (SELECT fell_insert('Hindscarth', 727, @nw, 71, @dale_head_id));

SET @ullscarf_id = (SELECT fell_insert('Ullscarf', 726, @c, 115, @high_raise_langdale_id));

SET @clough_head_id = (SELECT fell_insert(@clough_head, 726, @e, 108, @great_dodd_id));

SET @thunacar_knott_id = (SELECT fell_insert('Thunacar Knott', 723, @c, 27, @harrison_stickle_id));

SET @froswick_id = (SELECT fell_insert('Froswick', 720, @fe, 75, @ill_bell_id));

SET @birkhouse_moor_id = (SELECT fell_insert(@birkhouse_moor, 718, @e, 20, @helvellyn_id));

SET @lonscale_fell_id = (SELECT fell_insert('Lonscale Fell', 715, @n, 50, @skiddaw_little_man_id));

SET @brandreth_id = (SELECT fell_insert('Brandreth', 715, @w, 60, @great_gable_id));

SET @branstree_id = (SELECT fell_insert('Branstree', 713, @fe, 137, @harter_fell_mardale_id));

SET @knott_id = (SELECT fell_insert('Knott', 710, @n, 242, @skiddaw_id));

SET @pike_of_stickle_id = (SELECT fell_insert('Pike Of Stickle', 709, @c, 54, @high_raise_langdale_id));

SET @whiteside_id = (SELECT fell_insert('Whiteside', 707, @nw, 34, @hopegill_head_id));

SET @yoke_id = (SELECT fell_insert('Yoke', 706, @fe, 38, @ill_bell_id));

SET @pike_o_blisco_id = (SELECT fell_insert("Pike o' Blisco", 709, @s, 177, @scafell_pike_id));

SET @bowscale_fell_id = (SELECT fell_insert('Bowscale Fell', 702, @n, 90, @blencathra_id));

SET @cold_pike_id = (SELECT fell_insert('Cold Pike', 701, @s, 46, @crinkle_crags_id));

SET @pavey_ark_id = (SELECT fell_insert('Pavey Ark', 700, @c, 15, @thunacar_knott_id));

SET @gray_crag_id = (SELECT fell_insert('Gray Crag', 699, @fe, 15, @thornthwaite_crag_id)); -- this is GR(A)Y Crag, there is a different GR(E)Y Crag fell

SET @grey_knotts_id = (SELECT fell_insert('Grey Knotts', 697, @w, 15, @brandreth_id));

SET @caw_fell_id = (SELECT fell_insert('Caw Fell', 697, @w, 22, @haycock_id));

SET @rest_dodd_id = (SELECT fell_insert('Rest Dodd', 696, @fe, 111, @high_street_id));

SET @seatallan_id = (SELECT fell_insert('Seatallan', 692, @w, 193, @pillar_id));

SET @ullock_pike_id = (SELECT fell_insert('Ullock Pike', 690, @n, 14, @long_side_id));

SET @great_calva_id = (SELECT fell_insert('Great Calva', 690, @n, 142, @knott_id));

SET @bannerdale_crags_id = (SELECT fell_insert('Bannerdale Crags', 683, @n, 37, @bowscale_fell_id));

SET @loft_crag_id = (SELECT fell_insert('Loft Crag', 680, @c, 25, @pike_of_stickle_id));

SET @sheffield_pike_id = (SELECT fell_insert(@sheffield_pike, 675, @e, 91, @great_dodd_id));

SET @bakestall_id = (SELECT fell_insert('Bakestall', 673, @n, 8, @skiddaw_id));

SET @scar_crags_id = (SELECT fell_insert('Scar Crags', 672, @nw, 55, @eel_crag_crag_hill_id));

SET @loadpot_hill_id = (SELECT fell_insert('Loadpot Hill', 671, @fe, 50, @high_raise_haweswater_id));

SET @wether_hill_id = (SELECT fell_insert('Wether Hill', 670, @fe, 20, @high_raise_haweswater_id));

SET @tarn_crag_longsleddale_id = (SELECT fell_insert('Tarn Crag (Longsleddale)', 664, @fe, 160, @high_street_id));

SET @carrock_fell_id = (SELECT fell_insert('Carrock Fell', 663, @n, 91, @knott_id));

SET @whiteless_pike_id = (SELECT fell_insert('Whiteless Pike', 660, @nw, 35, @eel_crag_crag_hill_id));

SET @high_pike_caldbeck_id = (SELECT fell_insert('High Pike (Caldbeck)', 658, @n, 69, @knott_id));

SET @place_fell_id = (SELECT fell_insert('Place Fell', 657, @fe, 262, @high_street_id));

SET @high_pike_scandale_id = (SELECT fell_insert(@high_pike_scandale, 656, @e, 5, @dove_crag_id));

SET @selside_pike_id = (SELECT fell_insert('Selside Pike', 655, @fe, 40, @branstree_id));

SET @middle_dodd_id = (SELECT fell_insert(@middle_dodd, 654, @e, 10, @red_screes_id));

SET @harter_fell_eskdale_id = (SELECT fell_insert('Harter Fell (Eskdale)', 654, @s, 276, @scafell_pike_id));

SET @high_spy_id = (SELECT fell_insert('High Spy', 653, @nw, 148, @dale_head_id));

SET @great_sca_fell_id = (SELECT fell_insert('Great Sca Fell', 651, @n, 13, @knott_id));

SET @rossett_pike_id = (SELECT fell_insert('Rossett Pike', 651, @s, 35, @bowfell_id));

SET @fleetwith_pike_id = (SELECT fell_insert('Fleetwith Pike', 648, @w, 117, @great_gable_id));

SET @base_brown_id = (SELECT fell_insert('Base Brown', 646, @w, 38, @green_gable_id));

SET @grey_crag_id = (SELECT fell_insert('Grey Crag', 638, @fe, 45, @tarn_crag_longsleddale_id)); -- this is GR(E)Y Crag, there is a different GR(A)Y Crag fell

SET @causey_pike_id = (SELECT fell_insert('Causey Pike', 637, @nw, 40, @scar_crags_id));

SET @little_hart_crag_id = (SELECT fell_insert(@little_hart_crag, 637, @e, 34, @dove_crag_id));

SET @starling_dodd_id = (SELECT fell_insert('Starling Dodd', 633, @w, 60, @high_stile_id));

SET @mungrisdale_common_id = (SELECT fell_insert('Mungrisdale Common', 633, @n, 2, @blencathra_id));

SET @yewbarrow_id = (SELECT fell_insert('Yewbarrow', 628, @w, 142, @pillar_id));

SET @birks_id = (SELECT fell_insert(@birks, 622, @e, 19, @st_sunday_crag_id));

SET @hartsop_dodd_id = (SELECT fell_insert('Hartsopp Dodd', 618, @fe, 20, @caudale_moor_id));

SET @great_borne_id = (SELECT fell_insert('Great Borne', 616, @w, 113, @high_stile_id));

SET @heron_pike_id = (SELECT fell_insert(@heron_pike, 612, @e, 21, @great_rigg_id));

SET @illgill_head_id = (SELECT fell_insert('Illgill Head', 609, @s, 314, @scafell_pike_id));

SET @high_seat_id = (SELECT fell_insert('High Seat', 608, @c, 124, @high_raise_langdale_id));

SET @seathwaite_fell_id = (SELECT fell_insert('Seathwaite Fell', 601, @s, 31, @great_end_id));

SET @haystacks_id = (SELECT fell_insert('Haystacks', 597, @w, 92, @great_gable_id));

SET @bleaberry_fell_id = (SELECT fell_insert('Bleaberry Fell', 590, @c, 40, @high_seat_id));

SET @shipman_knotts_id = (SELECT fell_insert('Shipman Knotts', 587, @fe, 10, @kentmere_pike_id));

SET @brae_fell_id = (SELECT fell_insert('Brae Fell', 586, @n, 16, @knott_id));

SET @middle_fell_id = (SELECT fell_insert('Middle Fell', 582, @w, 117, @seatallan_id));

SET @ard_crags_id = (SELECT fell_insert('Ard Crags', 581, @nw, 120, @grasmoor_id));

SET @hartsop_above_how_id = (SELECT fell_insert(@hartsop_above_how, 570, @e, 30, @hart_crag_id));

SET @the_nab_id = (SELECT fell_insert('The Nab', 576, @fe, 61, @rest_dodd_id));

SET @maiden_moor_id = (SELECT fell_insert('Maiden Moor', 575, @nw, 16, @high_spy_id));

SET @blake_fell_id = (SELECT fell_insert('Blake Fell', 573, @w, 164, @high_stile_id));

SET @sergeants_crag_id = (SELECT fell_insert("Sergeant's Crag", 571, @c, 45, @high_raise_langdale_id));

SET @outerside_id = (SELECT fell_insert('Outerside', 568, @nw, 70, @eel_crag_crag_hill_id));

SET @angletarn_pikes_id = (SELECT fell_insert('Angletarn Pikes', 567, @fe, 80, @rest_dodd_id));

SET @brock_crags_id = (SELECT fell_insert('Brock Crags', 561, @fe, 25, @rest_dodd_id));

SET @knott_rigg_id = (SELECT fell_insert('Knott Rigg', 556, @nw, 61, @ard_crags_id));

SET @steel_fell_id = (SELECT fell_insert('Steel Fell', 553, @c, 70, @high_raise_langdale_id));

SET @lords_seat_id = (SELECT fell_insert("Lord's Seat", 552, @nw, 237, @grasmoor_id));

SET @rosthwaite_fell_id = (SELECT fell_insert('Rosthwaite Fell', 551, @s, 15, @scafell_pike_id));

SET @meal_fell_id = (SELECT fell_insert('Meal Fell', 550, @n, 30, @knott_id));

SET @tarn_crag_easedale_id = (SELECT fell_insert('Tarn Crag (Easedale)', 550, @c, 5, @high_raise_langdale_id));

SET @hard_knott_id = (SELECT fell_insert('Hard Knott', 549, @s, 154, @scafell_pike_id));

SET @blea_rigg_id = (SELECT fell_insert('Blea Rigg', 541, @c, 20, @harrison_stickle_id));

SET @lank_rigg_id = (SELECT fell_insert('Lank Rigg', 541, @w, 111, @pillar_id));

SET @calf_crag_id = (SELECT fell_insert('Calf Crag', 537, @c, 40, @high_raise_langdale_id));

SET @whin_rigg_id = (SELECT fell_insert('Whin Rigg', 535, @s, 58, @illgill_head_id));

SET @great_mell_fell_id = (SELECT fell_insert(@great_mell_fell, 537, @e, 198, @helvellyn_id));

SET @arthurs_pike_id = (SELECT fell_insert("Arthur's Pike", 533, @fe, 10, @loadpot_hill_id));

SET @great_cockup_id = (SELECT fell_insert('Great Cockup', 526, @n, 85, @knott_id));

SET @gavel_fell_id = (SELECT fell_insert('Gavel Fell', 526, @w, 75, @blake_fell_id));

SET @eagle_crag_id = (SELECT fell_insert('Eagle Crag', 525, @c, 25, @sergeants_crag_id));

SET @bonscale_pike_id = (SELECT fell_insert('Bonscale Pike', 524, @fe, 10, @loadpot_hill_id));

SET @crag_fell_id = (SELECT fell_insert('Crag Fell', 523, @w, 115, @pillar_id));

SET @souther_fell_id = (SELECT fell_insert('Souther Fell', 522, @n, 87, @blencathra_id));

SET @high_hartsop_dodd_id = (SELECT fell_insert(@high_hartsop_dodd, 519, @e, 5, @little_hart_crag_id));

SET @whinlatter_id = (SELECT fell_insert('Whinlatter', 517, @nw, 60, @lords_seat_id));

SET @sallows_id = (SELECT fell_insert('Sallows', 516, @fe, 69, @ill_bell_id));

SET @high_tove_id = (SELECT fell_insert('High Tove', 515, @c, 16, @high_seat_id));

SET @mellbreak_id = (SELECT fell_insert('Mellbreak', 512, @w, 260, @high_stile_id));

SET @broom_fell_id = (SELECT fell_insert('Broom Fell', 511, @nw, 25, @lords_seat_id));

SET @hen_comb_id = (SELECT fell_insert('Hen Comb', 509, @w, 145, @blake_fell_id));

SET @beda_fell_id = (SELECT fell_insert('Beda Fell', 509, @fe, 60, @angletarn_pikes_id));

SET @low_pike_id = (SELECT fell_insert(@low_pike, 508, @e, 28, @dove_crag_id));

SET @little_mell_fell_id = (SELECT fell_insert(@little_mell_fell, 505, @e, 226, @helvellyn_id));

SET @stone_arthur_id = (SELECT fell_insert(@stone_arthur, 500, @e, 2, @great_rigg_id));

SET @dodd_id = (SELECT fell_insert('Dodd', 502, @n, 120, @skiddaw_id));

SET @green_crag_id = (SELECT fell_insert('Green Crag', 489, @s, 145, @harter_fell_eskdale_id));

SET @grike_id = (SELECT fell_insert('Grike', 488, @w, 37, @eel_crag_crag_hill_id));

SET @wansfell_id = (SELECT fell_insert('Wansfell', 488, @fe, 147, @caudale_moor_id));

SET @longlands_fell_id = (SELECT fell_insert('Longlands Fell', 483, @n, 33, @knott_id));

SET @sour_howes_id = (SELECT fell_insert('Sour Howes', 483, @fe, 34, @sallows_id));

SET @gowbarrow_fell_id = (SELECT fell_insert(@gowbarrow_fell, 481, @e, 100, @little_mell_fell_id));

SET @burnbank_fell_id = (SELECT fell_insert('Burnbank Fell', 475, @w, 20, @blake_fell_id));

SET @armboth_fell_id = (SELECT fell_insert('Armboth Fell', 479, @c, 25, @high_seat_id));

SET @lingmoor_fell_id = (SELECT fell_insert('Lingmoor Fell', 469, @s, 245, @scafell_pike_id));

SET @barf_id = (SELECT fell_insert('Barf', 468, @nw, 20, @lords_seat_id));

SET @raven_crag_id = (SELECT fell_insert('Raven Crag', 461, @c, 45, @high_seat_id));

SET @barrow_id = (SELECT fell_insert('Barrow', 455, @nw, 60, @outerside_id));

SET @graystones_id = (SELECT fell_insert('Graystones', 452, @nw, 80, @lords_seat_id));

SET @catbells_id = (SELECT fell_insert('Catbells', 451, @nw, 86, @dale_head_id));

SET @nab_scar_id = (SELECT fell_insert(@nab_scar, 450, @e, 5, @heron_pike_id));

SET @great_crag_id = (SELECT fell_insert('Great Crag', 450, @c, 27, @ullscarf_id));

SET @binsey_id = (SELECT fell_insert('Binsey', 447, @n, 242, @knott_id));

SET @glenridding_dodd_id = (SELECT fell_insert(@glenridding_dodd, 442, @e, 45, @sheffield_pike_id));

SET @arnison_crag_id = (SELECT fell_insert(@arnison_crag, 433, @e, 10, @birks_id));

SET @steel_knotts_id = (SELECT fell_insert('Steel Knots', 432, @fe, 45, @high_raise_haweswater_id));

SET @low_fell_id = (SELECT fell_insert('Low Fell', 423, @w, 270, @high_stile_id));

SET @buckbarrow_id = (SELECT fell_insert('Buckbarrow', 423, @w, 5, @seatallan_id));

SET @gibson_knott_id = (SELECT fell_insert('Gibson Knott', 420, @c, 10, @calf_crag_id));

SET @fellbarrow_id = (SELECT fell_insert('Fellbarrow', 416, @w, 50, @low_fell_id));

SET @grange_fell_id = (SELECT fell_insert('Grange Fell', 415, @c, 94, @great_crag_id));

SET @helm_crag_id = (SELECT fell_insert('Helm Crag', 405, @c, 60, @high_raise_langdale_id));

SET @silver_how_id = (SELECT fell_insert('Silver How', 395, @c, 30, @harrison_stickle_id));

SET @hallin_fell_id = (SELECT fell_insert('Hallin Fell', 388, @fe, 163, @high_street_id));

SET @walla_crag_id = (SELECT fell_insert('Walla Crag', 376, @c, 24, @bleaberry_fell_id));

SET @ling_fell_id = (SELECT fell_insert('Ling Fell', 373, @nw, 97, @lords_seat_id));

SET @latrigg_id = (SELECT fell_insert('Latrigg', 367, @n, 70, @skiddaw_id));

SET @troutbeck_tongue_id = (SELECT fell_insert('Troutbeck Tongue', 364, @fe, 70, @froswick_id));

SET @sale_fell_id = (SELECT fell_insert('Sale Fell', 359, @nw, 125, @lords_seat_id));

SET @high_rigg_id = (SELECT fell_insert('High Rigg', 357, @c, 189, @high_raise_langdale_id));

SET @rannerdale_knotts_id = (SELECT fell_insert('Rannerdale Knotts', 355, @nw, 70, @eel_crag_crag_hill_id));

SET @loughrigg_fell_id = (SELECT fell_insert('Loughrigg Fell', 335, @c, 172, @high_raise_langdale_id));

SET @top_o_selside_id = (SELECT fell_insert("Top o' Selside", 335, @s, 191, @coniston_old_man_id));

SET @black_fell_id = (SELECT fell_insert('Black Fell', 323, @s, 126, @top_o_selside_id));

SET @holme_fell_id = (SELECT fell_insert('Holme Fell', 317, @s, 165, @coniston_old_man_id));

SET @castle_crag_id = (SELECT fell_insert('Castle Crag', 298, @nw, 75, @high_spy_id));

ALTER TABLE fells MODIFY parent_peak_id INT NOT NULL;

/***************************************************************************************************
* LOCATIONS
***************************************************************************************************/
INSERT INTO locations (fell_id, latitude, longitude, os_map_ref)
VALUES
    -- eastern fells -----------------------------------------
    (@helvellyn_id, 54.527232, -3.016054, 'NY342151'),
    (@nethermost_pike_id, 54.51882, -3.01646, 'NY343142'),
    (@catstye_cam_id, 54.53326, -3.00909, 'NY348158'),
    (@raise_id, 54.547, -3.014, 'NY342174'),
    (@fairfield_id, 54.496883, -2.990594, 'NY358117'),
    (@white_side_id, 54.5403, -3.02626, 'NY337166'),
    (@dollywaggon_pike_id, 54.50807, -3.01156, 'NY346130'),
    (@great_dodd_id, 54.57541, -3.01941, 'NY342205'),
    (@stybarrow_dodd_id, 54.56105, -3.01751, 'NY343189'),
    (@st_sunday_crag_id, 54.51286, -2.97615, 'NY369135'),
    (@hart_crag_id, 54.49308, -2.97722, 'NY368113'),
    (@dove_crag_id, 54.48506, -2.96777, 'NY374104'),
    (@watsons_dodd_id, 54.56725, -3.02849, 'NY336196'),
    (@red_screes_id, 54.47006, -2.93347, 'NY396087'),
    (@great_rigg_id, 54.48483, -2.99709, 'NY355104'),
    (@hart_side_id, 54.56934, -2.99297, 'NY359198'),
    (@seat_sandal_id, 54.49456, -3.01585, 'NY343115'),
    (@clough_head_id, 54.59326, -3.03379, 'NY333225'),
    (@birkhouse_moor_id, 54.53526, -2.98441, 'NY364160'),
    (@sheffield_pike_id, 54.55508, -2.9787, 'NY368182'),
    (@high_pike_scandale_id, 54.47, -2.968, 'NY373088'),
    (@middle_dodd_id, 54.47815, -2.93211, 'NY397096'),
    (@little_hart_crag_id, 54.48163, -2.94762, 'NY387100'),
    (@birks_id, 54.52, -2.956, 'NY380143'),
    (@heron_pike_id, 54.46506, -2.99661, 'NY355082'),
    (@hartsop_above_how_id, 54.49955, -2.95421, 'NY383120'),
    (@great_mell_fell_id, 54.62, -2.933, 'NY397254'),
    (@high_hartsop_dodd_id, 54.48889, -2.93853, 'NY393108'),
    (@low_pike_id, 54.46079, -2.96874, 'NY373077'),
    (@little_mell_fell_id, 54.60785, -2.89482, 'NY423240'),
    (@stone_arthur_id, 54.47485, -3.00765, 'NY348093'),
    (@gowbarrow_fell_id, 54.58881, -2.91761, 'NY408219'),
    (@nab_scar_id, 54.457, -2.996, 'NY356073'),
    (@glenridding_dodd_id, 54.54895, -2.95846, 'NY381175'),
    (@arnison_crag_id, 54.52663, -2.93939, 'NY393150'),
    -- far eastern fells -----------------------------------------
    (@high_street_id, 54.492, -2.865, 'NY440110'),
    (@high_raise_haweswater_id, 54.513, -2.851, 'NY448135'),
    (@rampsgill_head_id, 54.50744, -2.86173, 'NY443128'),
    (@thornthwaite_crag_id, 54.48305, -2.8782, 'NY432101'),
    (@kidsty_pike_id, 54.50568, -2.85552, 'NY447126'),
    (@harter_fell_mardale_id, 54.476, -2.835, 'NY459093'),
    (@caudale_moor_id, 54.48198, -2.90133, 'NY417100'),
    (@mardale_ill_bell_id, 54.48413, -2.85352, 'NY448102'),
    (@ill_bell_id, 54.46243, -2.87158, 'NY436078'),
    (@the_knott_id, 54.50646, -2.87252, 'NY436127'),
    (@kentmere_pike_id, 54.46274, -2.82685, 'NY465078'),
    (@froswick_id, 54.46871, -2.87326, 'NY435085'),
    (@branstree_id, 54.48264, -2.80873, 'NY477100'),
    (@yoke_id, 54.451, -2.869, 'NY437067'),
    (@gray_crag_id, 54.49737, -2.88622, 'NY427117'),
    (@rest_dodd_id, 54.5154, -2.87889, 'NY432137'),
    (@loadpot_hill_id, 54.55521, -2.84109, 'NY457181'),
    (@wether_hill_id, 54.542, -2.839, 'NY456167'),
    (@tarn_crag_longsleddale_id, 54.463, -2.787, 'NY488078'),
    (@place_fell_id, 54.54384, -2.92124, 'NY405169'),
    (@selside_pike_id,54.49294, -2.78849, 'NY490111'),
    (@grey_crag_id, 54.45768, -2.77739, 'NY497072'),
    (@hartsop_dodd_id, 54.4981, -2.9094, 'NY412118'),
    (@shipman_knotts_id, @54.44934, -2.81579, 'NY472063'),
    (@the_nab_id, 54.5289, -2.87609, 'NY434152'),
    (@angletarn_pikes_id, 54.52507, -2.90845, 'NY413148'),
    (@brock_crags_id, 54.51525, -2.89897, 'NY419137'),
    (@arthurs_pike_id, 54.57772, -2.83537, 'NY461206'),
    (@bonscale_pike_id, 54.57314, -2.84765, 'NY453201'),
    (@sallows_id, 54.42829, -2.86932, 'NY437040'),
    (@beda_fell_id, 54.5459, -2.88728, 'NY427171'),
    (@wansfell_id, 54.43779, -2.92194, 'NY403051'),
    (@sour_howes_id, 54.42099, -2.88457, 'NY427032'),
    (@steel_knotts_id, 54.55503, -2.86737, 'NY440181'),
    (@hallin_fell_id, 54.57057, -2.876354, 'NY433198'),
    (@troutbeck_tongue_id, 54.44969, -2.8929, 'NY422064'),
    -- central fells -----------------------------------------
    (@high_raise_langdale_id, 54.476, -3.113, 'NY280095'),
    (@sergeant_man_id, 54.47042, -3.10321, 'NY286089'),
    (@harrison_stickle_id, 54.45687, -3.11056, 'NY281074'),
    (@ullscarf_id, 54.50016, -3.09475, 'NY292122'),
    (@thunacar_knott_id, 54.46134, -3.11376, 'NY279079'),
    (@pike_of_stickle_id, 54.45586, -3.12287, 'NY273073'),
    (@pavey_ark_id, 54.46142, -3.10451, 'NY285079'),
    (@loft_crag_id, 54.45412, -3.11665, 'NY277071'),
    (@high_seat_id, 54.552, -3.104, 'NY287180'),
    (@bleaberry_fell_id, 54.56565, -3.10733, 'NY285195'),
    (@sergeants_crag_id, 54.49271, -3.12234, 'NY274114'),
    (@steel_fell_id, 54.49154, -3.05283, 'NY319112'),
    (@tarn_crag_easedale_id, 54.473, -3.076, 'NY301093'),
    (@blea_rigg_id, 54.46076, -3.07827, 'NY302078'),
    (@calf_crag_id, 54.48502, -3.07891, 'NY302105'),
    (@high_tove_id, 54.53964, -3.10199, 'NY288166'),
    (@eagle_crag_id, 54.49902, -3.12097, 'NY275121'),
    (@armboth_fell_id, 54.53347, -3.08791, 'NY297159'),
    (@raven_crag_id, 54.55963, -3.07778, 'NY304188'),
    (@great_crag_id, 54.52229, -3.13087, 'NY269147'),
    (@gibson_knott_id, 54.47986, -3.05253, 'NY319099'),
    (@grange_fell_id, 54.54437, -3.13253, 'NY268172'),
    (@helm_crag_id, 54.47548, -3.04007, 'NY327094'),
    (@silver_how_id, 54.45029, -3.04252, 'NY325066'),
    (@walla_crag_id, 54.5808, -3.12166, 'NY276212'),
    (@high_rigg_id, 54.58843, -3.07235, 'NY308220'),
    (@loughrigg_fell_id, 54.4371, -3.00826, 'NY347051'),
    -- southern fells -----------------------------------------
    (@scafell_pike_id, 54.454222, -3.211528, 'NY215072'),
    (@scafell_id, 54.448, -3.225, 'NY206064'),
    (@great_end_id, 54.464, -3.194, 'NY226084'),
    (@bowfell_id, 54.44737, -3.16582, 'NY245064'),
    (@esk_pike_id, 54.45622, -3.17995, 'NY236074'),
    (@crinkle_crags_id, 54.433, -3.159, 'NY248048'),
    (@lingmell_id, 54.46209, -3.22178, 'NY209081'),
    (@coniston_old_man_id, 54.37, -3.119, 'SD272978'),
    (@swirl_how_id, 54.39566, -3.12123, 'NY273006'),
    (@brim_fell_id, 54.37766, -3.12381, 'SD271986'),
    (@great_carrs_id, 54.39833, -3.12438, 'NY271009'),
    (@allen_crags_id, 54.4661, -3.18024, 'NY236085'),
    (@glaramara_id, 54.48332, -3.1653, 'NY246104'),
    (@dow_crag_id, 54.36944, -3.13744, 'SD262977'),
    (@grey_friar_id, 54.39276, -3.14271, 'NY259003'),
    (@wetherlam_id, 54.401, -3.098, 'NY288011'),
    (@slight_side_id, 54.43424, -3.22095, 'NY209050'),
    (@pike_o_blisco_id, 54.42798, -3.12519, 'NY271042'),
    (@cold_pike_id, 54.421, -3.134, 'NY262035'),
    (@harter_fell_eskdale_id, 54.388333, -3.204167, 'SD218997'),
    (@rossett_pike_id, 54.45821, -3.15996, 'NY249076'),
    (@illgill_head_id, 54.4327, -3.28257, 'NY169049'),
    (@seathwaite_fell_id, 54.478, -3.192, 'NY227097'),
    (@rosthwaite_fell_id, 54.49603, -3.15176, 'NY255118'),
    (@hard_knott_id, 54.41032, -3.18634, 'NY231023'),
    (@whin_rigg_id, 54.41893, -3.30988, 'NY151034'),
    (@green_crag_id, 54.373889, -3.2325, 'SD200982'),
    (@lingmoor_fell_id, 54.43208, -3.07626, 'NY302046'),
    (@black_fell_id, 54.40557, -3.01673, 'NY341016'),
    (@holme_fell_id, 54.396, -3.056, 'NY315006'),
    -- northern fells -----------------------------------------
    (@skiddaw_id, 54.647, -3.146, 'NY260290'),
    (@blencathra_id, 54.63985, -3.05046, 'NY323277'),
    (@skiddaw_little_man_id, 54.63906, -3.13876, 'NY266277'),
    (@carl_side_id, 54.64159, -3.15588, 'NY255280'),
    (@long_side_id, 54.645, -3.165, 'NY248284'),
    (@lonscale_fell_id, 54.63484, -3.10921, 'NY285272'),
    (@knott_id, 54.68621, -3.09354, 'NY296329'),
    (@bowscale_fell_id, 54.66516, -3.03406, 'NY334305'),
    (@great_calva_id, 54.669, -3.102, 'NY291312'),
    (@ullock_pike_id, 54.648, -3.173, 'NY244287'),
    (@bannerdale_crags_id, 54.65169, -3.03217, 'NY335290'),
    (@bakestall_id, 54.66601, -3.13952, 'NY266307'),
    (@carrock_fell_id, 54.693561, -3.023148, 'NY341336'),
    (@high_pike_caldbeck_id, 54.705, -3.06, 'NY318350'),
    (@great_sca_fell_id, 54.69422, -3.10152, 'NY291338'),
    (@mungrisdale_common_id, 54.65227, -3.06938, 'NY312292'),
    (@brae_fell_id, 54.70586, -3.10649, 'NY288351'),
    (@meal_fell_id, 54.6932, -3.11545, 'NY282337'),
    (@great_cockup_id, 54.68947, -3.12931, 'NY273333'),
    (@souther_fell_id, 54.65375, -3.00122, 'NY355292'),
    (@dodd_id, 54.635, -3.17, 'NY244273'),
    (@longlands_fell_id, 54.70747, -3.12671, 'NY275353'),
    (@binsey_id, 54.70852, -3.20434, 'NY225355'),
    (@latrigg_id, 54.61229, -3.11788, 'NY279247'),
    -- north western fells -----------------------------------------
    (@grasmoor_id, 54.57115, -3.27918, 'NY174203'),
    (@eel_crag_crag_hill_id, 54.572, -3.25, 'NY192203'),
    (@grisedale_pike_id, 54.592, -3.241, 'NY198225'),
    (@sail_id, 54.571, -3.242, 'NY198204'),
    (@wandope_id, 54.56598, -3.25736, 'NY188197'),
    (@hopegill_head_id, 54.5875, -3.26267, 'NY185221'),
    (@dale_head_id, 54.527, -3.20208, 'NY223153'),
    (@robinson_id, 54.54, -3.236, 'NY201168'),
    (@hindscarth_id, 54.53766, -3.21476, 'NY215165'),
    (@whiteside_id, 54.587, -3.279, 'NY175221'),
    (@scar_crags_id, 54.57439, -3.22668, 'NY208206'),
    (@whiteless_pike_id, 54.55867, -3.26951, 'NY180189'),
    (@high_spy_id, 54.534, -3.185, 'NY234162'),
    (@causey_pike_id, 54.57634, -3.21127, 'NY218208'),
    (@maiden_moor_id, 54.55325, -3.18275, 'NY236182'),
    (@ard_crags_id, 54.56627, -3.22953, 'NY206197'),
    (@outerside_id, 54.58162, -3.22226, 'NY211214'),
    (@knott_rigg_id, 54.558, -3.242, 'NY197188'),
    (@lords_seat_id, 54.627, -3.235, 'NY204265'),
    (@whinlatter_id, 54.614, -3.252, 'NY197249'),
    (@broom_fell_id, 54.631, -3.248, 'NY195271'),
    (@barf_id, 54.63, -3.218, 'NY216267'),
    (@barrow_id, 54.585799, -3.197034, 'NY226218'),
    (@graystones_id, 54.627, -3.275, 'NY177266'),
    (@catbells_id, 54.56865, -3.17083, 'NY244199'),
    (@ling_fell_id, 54.645, -3.274, 'NY179286'),
    (@sale_fell_id, 54.656, -3.248, 'NY194297'),
    (@rannerdale_knotts_id, 54.55216, -3.28941, 'NY167182'),
    (@castle_crag_id, 54.53278, -3.16207, 'NY249159'),
    -- western fells -----------------------------------------
    (@great_gable_id, 54.482, -3.219, 'NY211104'),
    (@pillar_id, 54.497, -3.282, 'NY171121'),
    (@scoat_fell_id, 54.49004, -3.2998, 'NY159113'),
    (@red_pike_wasdale_id, 54.483, -3.29, 'NY165105'),
    (@steeple_id, 54.493, -3.302, 'NY157116'),
    (@high_stile_id, 54.52167, -3.28381, 'NY170148'),
    (@kirk_fell_id, 54.483, -3.242, 'NY195104'),
    (@green_gable_id, 54.48553, -3.21476, 'NY214107'),
    (@haycock_id, 54.4844, -3.32278, 'NY144107'),
    (@red_pike_buttermere_id, 54.526, -3.3, 'NY160154'),
    (@high_crag_id, 54.51464, -3.26814, 'NY180140'),
    (@brandreth_id, 54.496, -3.212, 'NY215119'),
    (@caw_fell_id, 54.486, -3.343, 'NY132109'),
    (@grey_knotts_id, 54.503, -3.208, 'NY217125'),
    (@seatallan_id, 54.46365, -3.32982, 'NY139084'),
    (@fleetwith_pike_id, 54.51594, -3.22956, 'NY205141'),
    (@base_brown_id, 54.49199, -3.19797, 'NY225114'),
    (@starling_dodd_id, 54.53018, -3.32735, 'NY142158'),
    (@yewbarrow_id, 54.46421, -3.27738, 'NY173084'),
    (@great_borne_id, 54.53435, -3.35685, 'NY124163'),
    (@haystacks_id, 54.508, -3.248, 'NY193131'),
    (@middle_fell_id, 54.454, -3.311, 'NY151072'),
    (@blake_fell_id, 54.56377, -3.37793, 'NY110196'),
    (@lank_rigg_id, 54.494, -3.403, 'NY092119'),
    (@gavel_fell_id, 54.553, -3.368, 'NY117184'),
    (@crag_fell_id, 54.517, -3.397, 'NY097144'),
    (@mellbreak_id, 54.55544, -3.31889, 'NY148186'),
    (@hen_comb_id, 54.551, -3.342, 'NY133181'),
    (@grike_id, 54.513, -3.415, 'NY086141'),
    (@burnbank_fell_id, 54.575, -3.375, 'NY110209'),
    (@low_fell_id, 54.59119, -3.33707, 'NY137226'),
    (@buckbarrow_id, 54.442, -3.33514, 'NY135061'),
    (@fellbarrow_id, 54.605, -3.342, 'NY132243');

/***************************************************************************************************
* Classifications
***************************************************************************************************/
INSERT INTO classifications (name) VALUES ('Wainwright');
SET @wainwright_id = (SELECT last_insert_id());

INSERT INTO classifications (name) VALUES ('Hewitt');
SET @hewitt_id = (SELECT last_insert_id());

INSERT INTO classifications (name) VALUES ('Marilyn');
SET @marilyn_id = (SELECT last_insert_id());

INSERT INTO classifications (name) VALUES ('Nuttall');
SET @nuttall_id = (SELECT last_insert_id());

INSERT INTO classifications (name) VALUES ('Country high point');
SET @country_high_point_id = (SELECT last_insert_id());

INSERT INTO classifications (name) VALUES ('Hardy');
SET @hardy_id = (SELECT last_insert_id());

INSERT INTO classifications (name) VALUES ('Current county top');
SET @current_county_top_id = (SELECT last_insert_id());

INSERT INTO classifications (name) VALUES ('Furth');
SET @furth_id = (SELECT last_insert_id());

INSERT INTO classifications (name) VALUES ('Historic county top');
SET @historic_county_top_id = (SELECT last_insert_id());

INSERT INTO classifications (name) VALUES ('Administrative county top');
SET @administrative_county_top_id = (SELECT last_insert_id());

INSERT INTO classifications (name) VALUES ('Birkett');
SET @birkett_id = (SELECT last_insert_id());

INSERT INTO classifications (name) VALUES ('HuMP');
SET @hump_id = (SELECT last_insert_id());

INSERT INTO classifications (name) VALUES ('Nuttal');
SET @nuttal_id = (SELECT last_insert_id());

INSERT INTO classifications (name) VALUES ('Simm');
SET @simm_id = (SELECT last_insert_id());

INSERT INTO classifications (name) VALUES ('Synge');
SET @synge_id = (SELECT last_insert_id());

INSERT INTO classifications (name) VALUES ('Fellranger');
SET @fellranger_id = (SELECT last_insert_id());

INSERT INTO classifications (name) VALUES ('Tump');
SET @tump_id = (SELECT last_insert_id());

INSERT INTO classifications (name) VALUES ('Dewey');
SET @dewey_id = (SELECT last_insert_id());

INSERT INTO classifications (name) VALUES ('Birkett');
SET @birkett_id = (SELECT last_insert_id());

/***************************************************************************************************
* Fells X Classifications
***************************************************************************************************/
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hartsop_dodd_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hartsop_dodd_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hartsop_dodd_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hartsop_dodd_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hartsop_dodd_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@steeple_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@steeple_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@steeple_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@steeple_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@steeple_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@seatallan_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@seatallan_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@seatallan_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@seatallan_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@seatallan_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@seatallan_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@seatallan_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@seatallan_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@seatallan_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@seatallan_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@angletarn_pikes_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@angletarn_pikes_id, @dewey_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@angletarn_pikes_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@angletarn_pikes_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@angletarn_pikes_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@angletarn_pikes_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@thunacar_knott_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@thunacar_knott_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@thunacar_knott_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@thunacar_knott_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@thunacar_knott_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@red_pike_buttermere_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@red_pike_buttermere_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@red_pike_buttermere_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@red_pike_buttermere_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@red_pike_buttermere_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@red_pike_buttermere_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@red_pike_buttermere_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@red_pike_buttermere_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@haystacks_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@haystacks_id, @dewey_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@haystacks_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@haystacks_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@haystacks_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@haystacks_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@allen_crags_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@allen_crags_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@allen_crags_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@allen_crags_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@allen_crags_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@allen_crags_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@allen_crags_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@allen_crags_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@clough_head_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@clough_head_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@clough_head_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@clough_head_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@clough_head_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@clough_head_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@clough_head_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@clough_head_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@clough_head_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rampsgill_head_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rampsgill_head_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rampsgill_head_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rampsgill_head_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rampsgill_head_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rampsgill_head_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rampsgill_head_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rampsgill_head_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hopegill_head_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hopegill_head_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hopegill_head_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hopegill_head_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hopegill_head_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hopegill_head_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hopegill_head_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hopegill_head_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@castle_crag_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@castle_crag_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@castle_crag_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@castle_crag_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@little_mell_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@little_mell_fell_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@little_mell_fell_id, @dewey_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@little_mell_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@little_mell_fell_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@little_mell_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@little_mell_fell_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@little_mell_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@raise_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@raise_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@raise_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@raise_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@raise_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@raise_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@raise_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@raise_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@selside_pike_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@selside_pike_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@selside_pike_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@selside_pike_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@selside_pike_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@selside_pike_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@selside_pike_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@selside_pike_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@causey_pike_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@causey_pike_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@causey_pike_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@causey_pike_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@causey_pike_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@causey_pike_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@causey_pike_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@causey_pike_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@fairfield_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@fairfield_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@fairfield_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@fairfield_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@fairfield_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@fairfield_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@fairfield_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@fairfield_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@fairfield_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@fairfield_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@starling_dodd_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@starling_dodd_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@starling_dodd_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@starling_dodd_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@starling_dodd_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@starling_dodd_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@starling_dodd_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@starling_dodd_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@brae_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@brae_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@brae_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@brae_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@seathwaite_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@seathwaite_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@seathwaite_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@seathwaite_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lonscale_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lonscale_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lonscale_fell_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lonscale_fell_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lonscale_fell_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lonscale_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lonscale_fell_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lonscale_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@mardale_ill_bell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@mardale_ill_bell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@mardale_ill_bell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@mardale_ill_bell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@calf_crag_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@calf_crag_id, @dewey_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@calf_crag_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@calf_crag_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@calf_crag_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@calf_crag_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dale_head_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dale_head_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dale_head_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dale_head_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dale_head_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dale_head_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dale_head_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dale_head_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dale_head_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dale_head_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@mungrisdale_common_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@mungrisdale_common_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sergeants_crag_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sergeants_crag_id, @dewey_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sergeants_crag_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sergeants_crag_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sergeants_crag_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sergeants_crag_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@catstye_cam_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@catstye_cam_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@catstye_cam_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@catstye_cam_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@catstye_cam_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@catstye_cam_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@catstye_cam_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@catstye_cam_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@helvellyn_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@helvellyn_id, @historic_county_top_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@helvellyn_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@helvellyn_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@helvellyn_id, @furth_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@helvellyn_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@helvellyn_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@helvellyn_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@helvellyn_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@helvellyn_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@helvellyn_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@helvellyn_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@little_hart_crag_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@little_hart_crag_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@little_hart_crag_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@little_hart_crag_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@little_hart_crag_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@little_hart_crag_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@little_hart_crag_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@little_hart_crag_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@buckbarrow_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@buckbarrow_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@buckbarrow_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@buckbarrow_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@low_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@low_fell_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@low_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@low_fell_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@low_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@low_fell_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@low_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_pike_scandale_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_pike_scandale_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_pike_scandale_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_pike_scandale_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@kirk_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@kirk_fell_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@kirk_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@kirk_fell_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@kirk_fell_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@kirk_fell_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@kirk_fell_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@kirk_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@kirk_fell_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@kirk_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_cockup_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_cockup_id, @dewey_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_cockup_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_cockup_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_cockup_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_cockup_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@meal_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@meal_fell_id, @dewey_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@meal_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@meal_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@meal_fell_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@meal_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@silver_how_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@silver_how_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@silver_how_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@silver_how_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@silver_how_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@st_sunday_crag_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@st_sunday_crag_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@st_sunday_crag_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@st_sunday_crag_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@st_sunday_crag_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@st_sunday_crag_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@st_sunday_crag_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@st_sunday_crag_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@st_sunday_crag_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@st_sunday_crag_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grange_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grange_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grange_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grange_fell_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grange_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@brandreth_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@brandreth_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@brandreth_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@brandreth_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@brandreth_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@brandreth_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@brandreth_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@brandreth_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@barrow_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@barrow_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@barrow_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@barrow_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@barrow_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@gavel_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@gavel_fell_id, @dewey_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@gavel_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@gavel_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@gavel_fell_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@gavel_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hen_comb_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hen_comb_id, @dewey_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hen_comb_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hen_comb_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hen_comb_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hen_comb_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hen_comb_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@green_crag_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@green_crag_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@green_crag_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@green_crag_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@green_crag_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@green_crag_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scafell_pike_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scafell_pike_id, @administrative_county_top_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scafell_pike_id, @historic_county_top_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scafell_pike_id, @current_county_top_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scafell_pike_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scafell_pike_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scafell_pike_id, @furth_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scafell_pike_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scafell_pike_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scafell_pike_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scafell_pike_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scafell_pike_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scafell_pike_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scafell_pike_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rossett_pike_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rossett_pike_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rossett_pike_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rossett_pike_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rossett_pike_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rossett_pike_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rossett_pike_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rossett_pike_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@birks_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@birks_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@birks_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@birks_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@birks_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_calva_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_calva_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_calva_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_calva_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_calva_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_calva_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_calva_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_calva_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_calva_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bowfell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bowfell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bowfell_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bowfell_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bowfell_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bowfell_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bowfell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bowfell_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bowfell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lords_seat_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lords_seat_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lords_seat_id, @dewey_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lords_seat_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lords_seat_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lords_seat_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lords_seat_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lords_seat_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lingmell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lingmell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lingmell_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lingmell_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lingmell_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lingmell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lingmell_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lingmell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rosthwaite_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rosthwaite_fell_id, @dewey_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rosthwaite_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rosthwaite_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rosthwaite_fell_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rosthwaite_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@low_pike_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@low_pike_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@low_pike_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@low_pike_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@coniston_old_man_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@coniston_old_man_id, @historic_county_top_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@coniston_old_man_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@coniston_old_man_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@coniston_old_man_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@coniston_old_man_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@coniston_old_man_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@coniston_old_man_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@coniston_old_man_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@coniston_old_man_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@coniston_old_man_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sergeant_man_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sergeant_man_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sergeant_man_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sergeant_man_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bakestall_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bakestall_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bakestall_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bakestall_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@glaramara_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@glaramara_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@glaramara_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@glaramara_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@glaramara_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@glaramara_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@glaramara_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@glaramara_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@glaramara_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@knott_rigg_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@knott_rigg_id, @dewey_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@knott_rigg_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@knott_rigg_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@knott_rigg_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@knott_rigg_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@whinlatter_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@whinlatter_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@whinlatter_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@whinlatter_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@loft_crag_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@loft_crag_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@loft_crag_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@loft_crag_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@loft_crag_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sallows_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sallows_id, @dewey_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sallows_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sallows_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sallows_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sallows_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@haycock_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@haycock_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@haycock_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@haycock_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@haycock_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@haycock_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@haycock_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@haycock_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_spy_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_spy_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_spy_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_spy_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_spy_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_spy_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_spy_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_spy_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_spy_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@long_side_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@long_side_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@long_side_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@long_side_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@long_side_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@long_side_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@long_side_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@long_side_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@caw_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@caw_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@caw_fell_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@caw_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@caw_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@wetherlam_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@wetherlam_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@wetherlam_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@wetherlam_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@wetherlam_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@wetherlam_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@wetherlam_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@wetherlam_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@wetherlam_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@fellbarrow_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@fellbarrow_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@fellbarrow_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@fellbarrow_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@fellbarrow_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dollywaggon_pike_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dollywaggon_pike_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dollywaggon_pike_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dollywaggon_pike_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dollywaggon_pike_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dollywaggon_pike_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dollywaggon_pike_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dollywaggon_pike_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@harter_fell_mardale_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@harter_fell_mardale_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@harter_fell_mardale_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@harter_fell_mardale_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@harter_fell_mardale_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@harter_fell_mardale_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@harter_fell_mardale_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@harter_fell_mardale_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@harter_fell_mardale_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@gray_crag_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@gray_crag_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@gray_crag_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@gray_crag_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@gray_crag_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@caudale_moor_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@caudale_moor_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@caudale_moor_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@caudale_moor_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@caudale_moor_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@caudale_moor_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@caudale_moor_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@caudale_moor_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@caudale_moor_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@caudale_moor_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bannerdale_crags_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bannerdale_crags_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bannerdale_crags_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bannerdale_crags_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bannerdale_crags_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bannerdale_crags_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bannerdale_crags_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bannerdale_crags_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@ullscarf_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@ullscarf_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@ullscarf_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@ullscarf_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@ullscarf_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@ullscarf_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@ullscarf_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@ullscarf_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@ullscarf_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lingmoor_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lingmoor_fell_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lingmoor_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lingmoor_fell_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lingmoor_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lingmoor_fell_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lingmoor_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@crag_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@crag_fell_id, @dewey_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@crag_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@crag_fell_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@crag_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@crag_fell_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@crag_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@kentmere_pike_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@kentmere_pike_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@kentmere_pike_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@kentmere_pike_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@kentmere_pike_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@kentmere_pike_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@kentmere_pike_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@kentmere_pike_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@nab_scar_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@nab_scar_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@nab_scar_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@nab_scar_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sour_howes_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sour_howes_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sour_howes_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sour_howes_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@gibson_knott_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@gibson_knott_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@gibson_knott_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@gibson_knott_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@ard_crags_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@ard_crags_id, @dewey_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@ard_crags_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@ard_crags_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@ard_crags_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@ard_crags_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@ard_crags_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_street_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_street_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_street_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_street_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_street_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_street_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_street_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_street_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_street_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_street_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@middle_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@middle_fell_id, @dewey_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@middle_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@middle_fell_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@middle_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@middle_fell_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@middle_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@crinkle_crags_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@crinkle_crags_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@crinkle_crags_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@crinkle_crags_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@crinkle_crags_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@crinkle_crags_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@crinkle_crags_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@crinkle_crags_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@crinkle_crags_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@mellbreak_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@mellbreak_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@mellbreak_id, @dewey_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@mellbreak_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@mellbreak_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@mellbreak_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@mellbreak_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@mellbreak_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@watsons_dodd_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@watsons_dodd_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@watsons_dodd_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@watsons_dodd_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hart_crag_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hart_crag_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hart_crag_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hart_crag_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hart_crag_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hart_crag_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hart_crag_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hart_crag_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@helm_crag_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@helm_crag_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@helm_crag_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@helm_crag_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@helm_crag_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@longlands_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@longlands_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@longlands_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@longlands_fell_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@longlands_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@blencathra_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@blencathra_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@blencathra_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@blencathra_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@blencathra_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@blencathra_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@blencathra_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@blencathra_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@blencathra_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@blencathra_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hindscarth_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hindscarth_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hindscarth_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hindscarth_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hindscarth_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hindscarth_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hindscarth_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hindscarth_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@esk_pike_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@esk_pike_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@esk_pike_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@esk_pike_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@esk_pike_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@esk_pike_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@esk_pike_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@esk_pike_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@esk_pike_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@eel_crag_crag_hill_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@eel_crag_crag_hill_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@eel_crag_crag_hill_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@eel_crag_crag_hill_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@eel_crag_crag_hill_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@eel_crag_crag_hill_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@eel_crag_crag_hill_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@eel_crag_crag_hill_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@eel_crag_crag_hill_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@nethermost_pike_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@nethermost_pike_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@nethermost_pike_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@nethermost_pike_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@nethermost_pike_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@red_screes_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@red_screes_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@red_screes_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@red_screes_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@red_screes_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@red_screes_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@red_screes_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@red_screes_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@red_screes_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@red_screes_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_rigg_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_rigg_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_rigg_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_rigg_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_rigg_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_rigg_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_rigg_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_crag_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_crag_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_crag_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_crag_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_crag_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@steel_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@steel_fell_id, @dewey_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@steel_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@steel_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@steel_fell_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@steel_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grey_friar_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grey_friar_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grey_friar_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grey_friar_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grey_friar_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grey_friar_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grey_friar_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grey_friar_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@raven_crag_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@raven_crag_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@raven_crag_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@raven_crag_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@raven_crag_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@whiteside_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@whiteside_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@whiteside_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@whiteside_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@whiteside_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_crag_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_crag_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_crag_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_crag_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_crag_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_crag_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_crag_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_crag_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scoat_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scoat_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scoat_fell_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scoat_fell_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scoat_fell_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scoat_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scoat_fell_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scoat_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@maiden_moor_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@maiden_moor_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@maiden_moor_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@maiden_moor_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hartsop_above_how_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hartsop_above_how_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hartsop_above_how_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hartsop_above_how_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sail_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sail_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sail_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sail_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sail_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sail_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sail_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sail_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@yewbarrow_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@yewbarrow_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@yewbarrow_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@yewbarrow_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@yewbarrow_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@yewbarrow_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@yewbarrow_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@yewbarrow_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@yewbarrow_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@blea_rigg_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@blea_rigg_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@blea_rigg_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@blea_rigg_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hard_knott_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hard_knott_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hard_knott_id, @dewey_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hard_knott_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hard_knott_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hard_knott_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hard_knott_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hard_knott_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scafell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scafell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scafell_id, @furth_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scafell_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scafell_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scafell_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scafell_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scafell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scafell_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scafell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@graystones_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bonscale_pike_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bonscale_pike_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bonscale_pike_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bonscale_pike_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@pavey_ark_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@pavey_ark_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@pavey_ark_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@pavey_ark_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@pavey_ark_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@knott_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@knott_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@knott_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@knott_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@knott_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@knott_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@knott_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@knott_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@knott_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@knott_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@souther_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@souther_fell_id, @dewey_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@souther_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@souther_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@souther_fell_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@souther_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@glenridding_dodd_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@glenridding_dodd_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@glenridding_dodd_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@glenridding_dodd_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@glenridding_dodd_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@pike_of_stickle_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@pike_of_stickle_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@pike_of_stickle_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@pike_of_stickle_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@pike_of_stickle_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@pike_of_stickle_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@pike_of_stickle_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@pike_of_stickle_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@harter_fell_eskdale_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@harter_fell_eskdale_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@harter_fell_eskdale_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@harter_fell_eskdale_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@harter_fell_eskdale_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@harter_fell_eskdale_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@harter_fell_eskdale_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@harter_fell_eskdale_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@harter_fell_eskdale_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@harter_fell_eskdale_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@pillar_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@pillar_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@pillar_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@pillar_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@pillar_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@pillar_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@pillar_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@pillar_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@pillar_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@pillar_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@barf_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@barf_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@barf_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@barf_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@barf_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@troutbeck_tongue_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@troutbeck_tongue_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@troutbeck_tongue_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@troutbeck_tongue_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@troutbeck_tongue_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hallin_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hallin_fell_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hallin_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hallin_fell_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hallin_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hallin_fell_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hallin_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@ling_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@ling_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@ling_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@ling_fell_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@ling_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@whin_rigg_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@whin_rigg_id, @dewey_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@whin_rigg_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@whin_rigg_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@whin_rigg_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@whin_rigg_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@thornthwaite_crag_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@thornthwaite_crag_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@thornthwaite_crag_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@thornthwaite_crag_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@thornthwaite_crag_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@thornthwaite_crag_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@thornthwaite_crag_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@thornthwaite_crag_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@ill_bell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@ill_bell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@ill_bell_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@ill_bell_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@ill_bell_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@ill_bell_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@ill_bell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@ill_bell_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@ill_bell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lank_rigg_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lank_rigg_id, @dewey_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lank_rigg_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lank_rigg_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lank_rigg_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lank_rigg_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@lank_rigg_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@heron_pike_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@heron_pike_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@heron_pike_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@heron_pike_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_sca_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_sca_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_sca_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_sca_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@base_brown_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@base_brown_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@base_brown_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@base_brown_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@base_brown_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@base_brown_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@base_brown_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@base_brown_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grisedale_pike_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grisedale_pike_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grisedale_pike_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grisedale_pike_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grisedale_pike_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grisedale_pike_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grisedale_pike_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grisedale_pike_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grisedale_pike_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grisedale_pike_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_hartsop_dodd_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_hartsop_dodd_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_hartsop_dodd_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_hartsop_dodd_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@tarn_crag_easedale_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@tarn_crag_easedale_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@tarn_crag_easedale_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@tarn_crag_easedale_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@arthurs_pike_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@arthurs_pike_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@arthurs_pike_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@arthurs_pike_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dow_crag_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dow_crag_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dow_crag_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dow_crag_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dow_crag_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dow_crag_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dow_crag_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dow_crag_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dow_crag_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@white_side_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@white_side_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@white_side_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@white_side_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@white_side_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@white_side_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@white_side_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@white_side_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@the_nab_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@the_nab_id, @dewey_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@the_nab_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@the_nab_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@the_nab_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rest_dodd_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rest_dodd_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rest_dodd_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rest_dodd_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rest_dodd_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rest_dodd_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rest_dodd_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rest_dodd_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rest_dodd_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_mell_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_mell_fell_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_mell_fell_id, @dewey_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_mell_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_mell_fell_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_mell_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_mell_fell_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_mell_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@red_pike_wasdale_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@red_pike_wasdale_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@red_pike_wasdale_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@red_pike_wasdale_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@red_pike_wasdale_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@red_pike_wasdale_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@red_pike_wasdale_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@red_pike_wasdale_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dove_crag_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dove_crag_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dove_crag_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dove_crag_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dove_crag_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dove_crag_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dove_crag_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dove_crag_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grey_crag_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grey_crag_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grey_crag_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grey_crag_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grey_crag_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grey_crag_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grey_crag_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grey_crag_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@carl_side_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@carl_side_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@carl_side_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@carl_side_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@carl_side_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@carl_side_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@carl_side_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@carl_side_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@harrison_stickle_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@harrison_stickle_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@harrison_stickle_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@harrison_stickle_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@harrison_stickle_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@harrison_stickle_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@harrison_stickle_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@harrison_stickle_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_borne_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_borne_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_borne_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_borne_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_borne_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_borne_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_borne_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_borne_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_borne_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_dodd_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_dodd_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_dodd_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_dodd_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_dodd_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_dodd_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_dodd_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_dodd_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_dodd_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@green_gable_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@green_gable_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@green_gable_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@green_gable_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@green_gable_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@green_gable_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@green_gable_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@green_gable_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grasmoor_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grasmoor_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grasmoor_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grasmoor_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grasmoor_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grasmoor_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grasmoor_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grasmoor_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grasmoor_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grasmoor_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@skiddaw_little_man_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@skiddaw_little_man_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@skiddaw_little_man_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@skiddaw_little_man_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@skiddaw_little_man_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@skiddaw_little_man_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@skiddaw_little_man_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@skiddaw_little_man_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@fleetwith_pike_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@fleetwith_pike_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@fleetwith_pike_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@fleetwith_pike_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@fleetwith_pike_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@fleetwith_pike_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@fleetwith_pike_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@fleetwith_pike_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@fleetwith_pike_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@loughrigg_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@loughrigg_fell_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@loughrigg_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@loughrigg_fell_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@loughrigg_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@loughrigg_fell_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@loughrigg_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@steel_knotts_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@steel_knotts_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@steel_knotts_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@steel_knotts_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@steel_knotts_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@whiteless_pike_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@whiteless_pike_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@whiteless_pike_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@whiteless_pike_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@whiteless_pike_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@whiteless_pike_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@whiteless_pike_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@whiteless_pike_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@branstree_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@branstree_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@branstree_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@branstree_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@branstree_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@branstree_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@branstree_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@branstree_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@branstree_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_gable_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_gable_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_gable_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_gable_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_gable_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_gable_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_gable_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_gable_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_gable_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_gable_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@middle_dodd_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@middle_dodd_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@middle_dodd_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@middle_dodd_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@arnison_crag_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@arnison_crag_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@arnison_crag_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@arnison_crag_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@arnison_crag_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@gowbarrow_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@gowbarrow_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@gowbarrow_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@gowbarrow_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scar_crags_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scar_crags_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scar_crags_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scar_crags_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scar_crags_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scar_crags_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scar_crags_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@scar_crags_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@ullock_pike_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@ullock_pike_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@ullock_pike_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@ullock_pike_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@burnbank_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@burnbank_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@burnbank_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@robinson_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@robinson_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@robinson_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@robinson_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@robinson_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@robinson_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@robinson_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@robinson_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@robinson_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@robinson_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@wether_hill_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@wether_hill_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@wether_hill_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@wether_hill_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@froswick_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@froswick_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@froswick_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@froswick_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@froswick_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@froswick_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@froswick_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@froswick_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@skiddaw_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@skiddaw_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@skiddaw_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@skiddaw_id, @furth_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@skiddaw_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@skiddaw_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@skiddaw_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@skiddaw_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@skiddaw_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@skiddaw_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@skiddaw_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@illgill_head_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@illgill_head_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@illgill_head_id, @dewey_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@illgill_head_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@illgill_head_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@illgill_head_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@illgill_head_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@illgill_head_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@illgill_head_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@carrock_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@carrock_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@carrock_fell_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@carrock_fell_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@carrock_fell_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@carrock_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@carrock_fell_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@carrock_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@place_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@place_fell_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@place_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@place_fell_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@place_fell_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@place_fell_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@place_fell_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@place_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@place_fell_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@place_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@blake_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@blake_fell_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@blake_fell_id, @dewey_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@blake_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@blake_fell_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@blake_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@blake_fell_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@blake_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@loadpot_hill_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@loadpot_hill_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@loadpot_hill_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@loadpot_hill_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@loadpot_hill_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@loadpot_hill_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@loadpot_hill_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@loadpot_hill_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@latrigg_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@latrigg_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@latrigg_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@latrigg_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@latrigg_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@birkhouse_moor_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@birkhouse_moor_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@birkhouse_moor_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@birkhouse_moor_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@birkhouse_moor_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_tove_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_tove_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_tove_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_tove_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_raise_langdale_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_raise_langdale_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_raise_langdale_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_raise_langdale_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_raise_langdale_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_raise_langdale_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_raise_langdale_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_raise_langdale_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_raise_langdale_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_raise_langdale_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grey_knotts_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grey_knotts_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grey_knotts_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grey_knotts_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grey_knotts_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@outerside_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@outerside_id, @dewey_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@outerside_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@outerside_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@outerside_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@outerside_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@brim_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@brim_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@brim_fell_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@brim_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@brim_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_carrs_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_carrs_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_carrs_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_carrs_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_carrs_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@wandope_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@wandope_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@wandope_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@wandope_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@wandope_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@wandope_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@wandope_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@wandope_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@black_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@black_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@black_fell_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@black_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@black_fell_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@black_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@walla_crag_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@walla_crag_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@walla_crag_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@walla_crag_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bleaberry_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bleaberry_fell_id, @dewey_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bleaberry_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bleaberry_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bleaberry_fell_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bleaberry_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@broom_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@broom_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@broom_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@broom_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sheffield_pike_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sheffield_pike_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sheffield_pike_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sheffield_pike_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sheffield_pike_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sheffield_pike_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sheffield_pike_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sheffield_pike_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@stybarrow_dodd_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@stybarrow_dodd_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@stybarrow_dodd_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@stybarrow_dodd_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@stybarrow_dodd_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@stybarrow_dodd_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@stybarrow_dodd_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@stybarrow_dodd_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@holme_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@holme_fell_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@holme_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@holme_fell_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@holme_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@holme_fell_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@holme_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@eagle_crag_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@eagle_crag_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@eagle_crag_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@eagle_crag_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@seat_sandal_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@seat_sandal_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@seat_sandal_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@seat_sandal_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@seat_sandal_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@seat_sandal_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@seat_sandal_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@seat_sandal_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@seat_sandal_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@seat_sandal_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_rigg_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_rigg_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_rigg_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_rigg_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_rigg_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_rigg_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_rigg_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_rigg_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_seat_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_seat_id, @dewey_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_seat_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_seat_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_seat_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_seat_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_seat_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_seat_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@yoke_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@yoke_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@yoke_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@yoke_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@yoke_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@yoke_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@yoke_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@yoke_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@armboth_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rannerdale_knotts_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rannerdale_knotts_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rannerdale_knotts_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rannerdale_knotts_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@rannerdale_knotts_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_raise_haweswater_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_raise_haweswater_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_raise_haweswater_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_raise_haweswater_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_raise_haweswater_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_raise_haweswater_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_raise_haweswater_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_raise_haweswater_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@kidsty_pike_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@kidsty_pike_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@kidsty_pike_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@kidsty_pike_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@kidsty_pike_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grike_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grike_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grike_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grike_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@grike_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@shipman_knotts_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@shipman_knotts_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@shipman_knotts_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@shipman_knotts_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@beda_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@beda_fell_id, @dewey_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@beda_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@beda_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@beda_fell_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@beda_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@tarn_crag_longsleddale_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@tarn_crag_longsleddale_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@tarn_crag_longsleddale_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@tarn_crag_longsleddale_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@tarn_crag_longsleddale_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@tarn_crag_longsleddale_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@tarn_crag_longsleddale_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@tarn_crag_longsleddale_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@tarn_crag_longsleddale_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@tarn_crag_longsleddale_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@stone_arthur_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@stone_arthur_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@stone_arthur_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@stone_arthur_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@cold_pike_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@cold_pike_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@cold_pike_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@cold_pike_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@cold_pike_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@cold_pike_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@cold_pike_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@cold_pike_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@wansfell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@wansfell_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@wansfell_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@wansfell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@catbells_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@catbells_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@catbells_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@catbells_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@catbells_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_stile_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_stile_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@binsey_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@binsey_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@binsey_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@binsey_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@binsey_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@binsey_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@binsey_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sale_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sale_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sale_fell_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sale_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sale_fell_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@sale_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bowscale_fell_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bowscale_fell_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bowscale_fell_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bowscale_fell_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bowscale_fell_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bowscale_fell_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bowscale_fell_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@bowscale_fell_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dodd_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dodd_id, @dewey_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dodd_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dodd_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dodd_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dodd_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@dodd_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@swirl_how_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@swirl_how_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@swirl_how_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@swirl_how_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@swirl_how_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@swirl_how_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@swirl_how_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@swirl_how_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@swirl_how_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_end_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_end_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_end_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_end_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_end_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_end_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_end_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@great_end_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_pike_caldbeck_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_pike_caldbeck_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_pike_caldbeck_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_pike_caldbeck_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_pike_caldbeck_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_pike_caldbeck_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_pike_caldbeck_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@high_pike_caldbeck_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@pike_o_blisco_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@pike_o_blisco_id, @marilyn_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@pike_o_blisco_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@pike_o_blisco_id, @hewitt_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@pike_o_blisco_id, @hump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@pike_o_blisco_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@pike_o_blisco_id, @simm_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@pike_o_blisco_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@pike_o_blisco_id, @tump_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@pike_o_blisco_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@slight_side_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@slight_side_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@slight_side_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@slight_side_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@brock_crags_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@brock_crags_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@brock_crags_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@brock_crags_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@the_knott_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@the_knott_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@the_knott_id, @wainwright_id);

INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hart_side_id, @birkett_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hart_side_id, @fellranger_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hart_side_id, @nuttall_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hart_side_id, @synge_id);
INSERT INTO fells_classifications (fell_id, classification_id) VALUES (@hart_side_id, @wainwright_id);

/***************************************************************************************************
* Fells X OS MAPS
***************************************************************************************************/
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@hartsop_dodd_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@hartsop_dodd_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@steeple_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@steeple_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@seatallan_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@seatallan_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@angletarn_pikes_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@angletarn_pikes_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@thunacar_knott_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@thunacar_knott_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@thunacar_knott_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@red_pike_buttermere_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@red_pike_buttermere_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@haystacks_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@haystacks_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@haystacks_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@allen_crags_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@allen_crags_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@allen_crags_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@clough_head_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@clough_head_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@rampsgill_head_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@rampsgill_head_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@hopegill_head_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@hopegill_head_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@hopegill_head_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@castle_crag_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@castle_crag_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@castle_crag_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@little_mell_fell_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@little_mell_fell_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@raise_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@raise_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@selside_pike_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@selside_pike_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@causey_pike_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@causey_pike_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@causey_pike_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@fairfield_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@fairfield_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@starling_dodd_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@starling_dodd_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@brae_fell_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@brae_fell_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@brae_fell_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@seathwaite_fell_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@seathwaite_fell_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@seathwaite_fell_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@lonscale_fell_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@lonscale_fell_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@lonscale_fell_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@mardale_ill_bell_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@mardale_ill_bell_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@calf_crag_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@calf_crag_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@dale_head_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@dale_head_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@dale_head_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@mungrisdale_common_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@mungrisdale_common_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@sergeants_crag_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@sergeants_crag_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@sergeants_crag_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@catstye_cam_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@catstye_cam_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@helvellyn_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@helvellyn_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@little_hart_crag_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@little_hart_crag_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@buckbarrow_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@buckbarrow_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@low_fell_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@low_fell_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@high_pike_scandale_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@high_pike_scandale_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@kirk_fell_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@kirk_fell_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@kirk_fell_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@great_cockup_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@great_cockup_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@great_cockup_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@meal_fell_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@meal_fell_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@meal_fell_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@silver_how_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@silver_how_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@st_sunday_crag_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@st_sunday_crag_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@grange_fell_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@grange_fell_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@grange_fell_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@brandreth_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@brandreth_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@brandreth_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@barrow_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@barrow_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@barrow_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@gavel_fell_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@gavel_fell_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@hen_comb_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@hen_comb_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@green_crag_id, @os_map_lr_96_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@green_crag_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@scafell_pike_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@scafell_pike_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@scafell_pike_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@rossett_pike_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@rossett_pike_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@rossett_pike_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@birks_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@birks_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@great_calva_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@great_calva_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@great_calva_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@bowfell_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@bowfell_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@bowfell_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@lords_seat_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@lords_seat_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@lords_seat_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@lingmell_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@lingmell_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@lingmell_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@rosthwaite_fell_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@rosthwaite_fell_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@rosthwaite_fell_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@low_pike_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@low_pike_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@coniston_old_man_id, @os_map_lr_96_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@coniston_old_man_id, @os_map_lr_97_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@coniston_old_man_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@sergeant_man_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@sergeant_man_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@sergeant_man_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@bakestall_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@bakestall_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@bakestall_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@glaramara_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@glaramara_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@glaramara_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@knott_rigg_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@knott_rigg_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@knott_rigg_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@whinlatter_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@whinlatter_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@whinlatter_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@loft_crag_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@loft_crag_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@loft_crag_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@sallows_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@sallows_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@haycock_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@haycock_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@high_spy_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@high_spy_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@high_spy_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@long_side_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@long_side_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@long_side_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@caw_fell_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@caw_fell_id, @os_map_ex_4_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@caw_fell_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@wetherlam_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@wetherlam_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@wetherlam_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@fellbarrow_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@fellbarrow_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@dollywaggon_pike_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@dollywaggon_pike_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@harter_fell_mardale_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@harter_fell_mardale_id, @os_map_ex_5_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@harter_fell_mardale_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@gray_crag_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@gray_crag_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@caudale_moor_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@caudale_moor_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@bannerdale_crags_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@bannerdale_crags_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@ullscarf_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@ullscarf_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@ullscarf_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@lingmoor_fell_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@lingmoor_fell_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@crag_fell_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@crag_fell_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@kentmere_pike_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@kentmere_pike_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@nab_scar_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@nab_scar_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@sour_howes_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@sour_howes_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@gibson_knott_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@gibson_knott_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@ard_crags_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@ard_crags_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@ard_crags_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@high_street_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@high_street_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@middle_fell_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@middle_fell_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@crinkle_crags_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@crinkle_crags_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@crinkle_crags_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@mellbreak_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@mellbreak_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@watsons_dodd_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@watsons_dodd_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@hart_crag_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@hart_crag_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@helm_crag_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@helm_crag_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@longlands_fell_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@longlands_fell_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@longlands_fell_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@blencathra_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@blencathra_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@hindscarth_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@hindscarth_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@hindscarth_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@esk_pike_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@esk_pike_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@esk_pike_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@eel_crag_crag_hill_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@eel_crag_crag_hill_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@eel_crag_crag_hill_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@nethermost_pike_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@nethermost_pike_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@red_screes_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@red_screes_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@high_rigg_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@high_rigg_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@great_crag_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@great_crag_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@great_crag_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@steel_fell_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@steel_fell_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@grey_friar_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@grey_friar_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@grey_friar_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@raven_crag_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@raven_crag_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@whiteside_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@whiteside_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@whiteside_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@high_crag_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@high_crag_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@high_crag_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@scoat_fell_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@scoat_fell_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@maiden_moor_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@maiden_moor_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@maiden_moor_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@hartsop_above_how_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@hartsop_above_how_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@sail_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@sail_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@sail_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@yewbarrow_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@yewbarrow_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@yewbarrow_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@blea_rigg_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@blea_rigg_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@hard_knott_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@hard_knott_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@hard_knott_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@scafell_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@scafell_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@scafell_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@graystones_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@graystones_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@graystones_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@bonscale_pike_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@bonscale_pike_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@pavey_ark_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@pavey_ark_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@pavey_ark_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@knott_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@knott_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@knott_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@souther_fell_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@souther_fell_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@glenridding_dodd_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@glenridding_dodd_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@pike_of_stickle_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@pike_of_stickle_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@pike_of_stickle_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@harter_fell_eskdale_id, @os_map_lr_96_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@harter_fell_eskdale_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@pillar_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@pillar_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@pillar_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@barf_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@barf_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@barf_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@troutbeck_tongue_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@troutbeck_tongue_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@hallin_fell_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@hallin_fell_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@ling_fell_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@ling_fell_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@ling_fell_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@whin_rigg_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@whin_rigg_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@thornthwaite_crag_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@thornthwaite_crag_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@ill_bell_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@ill_bell_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@lank_rigg_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@lank_rigg_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@heron_pike_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@heron_pike_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@great_sca_fell_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@great_sca_fell_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@great_sca_fell_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@base_brown_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@base_brown_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@base_brown_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@grisedale_pike_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@grisedale_pike_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@grisedale_pike_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@high_hartsop_dodd_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@high_hartsop_dodd_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@tarn_crag_easedale_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@tarn_crag_easedale_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@arthurs_pike_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@arthurs_pike_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@dow_crag_id, @os_map_lr_96_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@dow_crag_id, @os_map_lr_97_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@dow_crag_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@white_side_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@white_side_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@the_nab_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@the_nab_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@rest_dodd_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@rest_dodd_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@great_mell_fell_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@great_mell_fell_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@red_pike_wasdale_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@red_pike_wasdale_id, @os_map_ex_4_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@red_pike_wasdale_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@dove_crag_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@dove_crag_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@grey_crag_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@grey_crag_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@carl_side_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@carl_side_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@carl_side_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@harrison_stickle_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@harrison_stickle_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@harrison_stickle_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@great_borne_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@great_borne_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@great_dodd_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@great_dodd_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@green_gable_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@green_gable_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@green_gable_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@grasmoor_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@grasmoor_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@grasmoor_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@skiddaw_little_man_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@skiddaw_little_man_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@skiddaw_little_man_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@fleetwith_pike_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@fleetwith_pike_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@fleetwith_pike_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@loughrigg_fell_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@loughrigg_fell_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@steel_knotts_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@steel_knotts_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@whiteless_pike_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@whiteless_pike_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@whiteless_pike_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@branstree_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@branstree_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@great_gable_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@great_gable_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@great_gable_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@middle_dodd_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@middle_dodd_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@arnison_crag_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@arnison_crag_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@gowbarrow_fell_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@gowbarrow_fell_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@scar_crags_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@scar_crags_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@scar_crags_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@ullock_pike_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@ullock_pike_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@ullock_pike_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@burnbank_fell_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@burnbank_fell_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@robinson_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@robinson_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@robinson_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@wether_hill_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@wether_hill_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@froswick_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@froswick_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@skiddaw_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@skiddaw_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@skiddaw_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@illgill_head_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@illgill_head_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@carrock_fell_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@carrock_fell_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@place_fell_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@place_fell_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@blake_fell_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@blake_fell_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@loadpot_hill_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@loadpot_hill_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@latrigg_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@latrigg_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@latrigg_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@birkhouse_moor_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@birkhouse_moor_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@high_tove_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@high_tove_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@high_tove_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@high_raise_langdale_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@high_raise_langdale_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@high_raise_langdale_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@grey_knotts_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@grey_knotts_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@grey_knotts_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@outerside_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@outerside_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@outerside_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@brim_fell_id, @os_map_lr_96_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@brim_fell_id, @os_map_lr_97_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@brim_fell_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@great_carrs_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@great_carrs_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@great_carrs_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@wandope_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@wandope_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@wandope_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@black_fell_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@black_fell_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@walla_crag_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@walla_crag_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@walla_crag_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@bleaberry_fell_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@bleaberry_fell_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@bleaberry_fell_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@broom_fell_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@broom_fell_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@broom_fell_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@sheffield_pike_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@sheffield_pike_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@stybarrow_dodd_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@stybarrow_dodd_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@holme_fell_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@holme_fell_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@eagle_crag_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@eagle_crag_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@eagle_crag_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@seat_sandal_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@seat_sandal_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@great_rigg_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@great_rigg_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@high_seat_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@high_seat_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@high_seat_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@yoke_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@yoke_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@armboth_fell_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@armboth_fell_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@armboth_fell_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@rannerdale_knotts_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@rannerdale_knotts_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@high_raise_haweswater_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@high_raise_haweswater_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@kidsty_pike_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@kidsty_pike_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@grike_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@grike_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@shipman_knotts_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@shipman_knotts_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@beda_fell_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@beda_fell_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@tarn_crag_longsleddale_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@tarn_crag_longsleddale_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@stone_arthur_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@stone_arthur_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@cold_pike_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@cold_pike_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@cold_pike_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@wansfell_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@wansfell_id, @os_map_ex_7_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@catbells_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@catbells_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@catbells_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@high_stile_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@high_stile_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@binsey_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@binsey_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@binsey_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@sale_fell_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@sale_fell_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@sale_fell_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@bowscale_fell_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@bowscale_fell_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@dodd_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@dodd_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@dodd_id, @os_map_ex_4_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@swirl_how_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@swirl_how_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@swirl_how_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@great_end_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@great_end_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@great_end_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@high_pike_caldbeck_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@high_pike_caldbeck_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@pike_o_blisco_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@pike_o_blisco_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@pike_o_blisco_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@slight_side_id, @os_map_lr_89_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@slight_side_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@slight_side_id, @os_map_ex_6_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@brock_crags_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@brock_crags_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@the_knott_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@the_knott_id, @os_map_ex_5_id);

INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@hart_side_id, @os_map_lr_90_id);
INSERT INTO fells_osmaps (fell_id, os_map_id) VALUES (@hart_side_id, @os_map_ex_5_id);




