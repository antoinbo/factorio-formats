meta:
  id: factorio_achievements_dat
  title: Factorio 2.x achievements file
  file-extension: dat
  ks-version: 0.11
  endian: le
  # bit-endian: le
  imports:
    - common
doc: |
  WIP!

  # Notes (brain dump)

  Tasks:
  * [ ] Check all achievements defined in Lua API are handled in this file format description.
  * [ ] Check achivement properties in game, inject values.
  * [ ] Check why achievement_content.size misses two entries at the end of my .dat files (regular and mods).

  Kaitai Struct doc:
  * https://ide.kaitai.io/
  * https://doc.kaitai.io/user_guide.html

  JSON export from Kaitai WebIDE, using web browser console:
  ```js
  kaitaiIde.app.vm.exportToJson()
  ```

  Factorio information from wiki:
  * https://wiki.factorio.com/Achievement_file_format

  Factorio information from Lua API:
  * https://lua-api.factorio.com/2.1.12/prototypes/AchievementPrototype.html
  * https://lua-api.factorio.com/2.1.12/classes/LuaAchievementPrototype.html
  * https://lua-api.factorio.com/2.1.12/defines.html#defines.prototypes.achievement.achievement
doc-ref: https://wiki.factorio.com/Achievement_file_format
seq:
  - id: version
    type: common::factorio_version
  - id: false
    # type: common::factorio_boolean
    contents: [0x00]
  - id: header
    type: achievement_header
  - id: content
    type: achievement_content
  - id: unknown
    type: u1
    repeat: eos
types:
  achievement_header:
    seq:
      - id: size
        type: u2
      - id: values
        type: achievement_header_info
        repeat: expr
        repeat-expr: size
  achievement_header_info:
    seq:
      - id: name
        type: common::factorio_string
      - id: size
        type: u2
      - id: objects
        type: achievement_header_suboject
        repeat: expr
        repeat-expr: size
  achievement_header_suboject:
    seq:
      - id: achievement_string_id
        type: common::factorio_string
      - id: index
        type: u2
  achievement_content:
    seq:
      - id: size
        type: u4
      - id: values
        type: achievement_content_info
        repeat: expr
        repeat-expr: size+2
  achievement_content_info:
    seq:
      - id: type
        type: common::factorio_string
      - id: id
        type: common::factorio_string
      - id: data
        type:
          switch-on: type.value
          cases:
            '"achievement"': type_achievement
            '"build-entity-achievement"': type_build_entity_achievement
            '"change-surface-achievement"': type_change_surface_achievement
            '"combat-robot-count"': type_combat_robot_count
            '"complete-objective-achievement"': type_complete_objective_achievement
            '"construct-with-robots-achievement"': type_construct_with_robots_achievement
            '"create-platform-achievement"': type_create_platform_achievement
            '"deconstruct-with-robots-achievement"': type_deconstruct_with_robots_achievement
            '"deliver-by-robots-achievement"': type_deliver_by_robots_achievement
            '"deplete-resource-achievement"': type_deplete_resource_achievement
            '"destroy-cliff-achievement"': type_destroy_cliff_achievement
            '"dont-build-entity-achievement"': type_dont_build_entity_achievement
            '"dont-craft-manually-achievement"': type_dont_craft_manually_achievement
            '"dont-kill-manually-achievement"': type_dont_kill_manually_achievement
            '"dont-research-before-researching-achievement"': type_dont_research_before_researching_achievement
            '"dont-use-entity-in-energy-production-achievement"': type_dont_use_entity_in_energy_production_achievement
            '"equip-armor-achievement"': type_equip_armor_achievement
            '"group-attack-achievement"': type_group_attack_achievement
            '"kill-achievement"': type_kill_achievement
            '"module-transfer-achievement"': type_module_transfer_achievement
            '"place-equipment-achievement"': type_place_equipment_achievement
            '"player-damaged-achievement"': type_player_damaged_achievement
            '"produce-achievement"': type_produce_achievement
            '"produce-per-hour-achievement"': type_produce_per_hour_achievement
            '"research-achievement"': type_research_achievement
            '"research-with-science-pack-achievement"': type_research_with_science_pack_achievement
            '"shoot-achievement"': type_shoot_achievement
            '"space-connection-distance-traveled-achievement"': type_space_connection_distance_traveled_achievement
            '"train-path-achievement"': type_train_path_achievement
            '"use-entity-in-energy-production-achievement"': type_use_entity_in_energy_production_achievement
            '"use-item-achievement"': type_use_item_achievement
# achievement
#     byte[0]
#     Unknown format, 0 bytes long.
  type_achievement:
    seq:
      - id: data
        size: 0
# build-entity-achievement 	
#     byte[4]
#     Unknown format, 4 bytes long.
  type_build_entity_achievement:
    seq:
      - id: data
        type: u4
# change-surface-achievement 	
#     byte[1]
#     Unknown format, 1 byte long.
  type_change_surface_achievement:
    seq:
      - id: data
        type: u1
# combat-robot-count 	
#     int
#     The greatest number of combat robots you've had following you.
  type_combat_robot_count:
    seq:
      - id: data
        type: s4
# complete-objective-achievement 	
#     byte[0]
#     Unknown format, 0 bytes long.
  type_complete_objective_achievement:
    seq:
      - id: data
        size: 0
# construct-with-robots-achievement 	
#     int
#     byte[4]
#     Total number of objects constructed using robots.
#     Unknown format, 4 bytes long.
# limited_to_one_game
# more_than_manually
  type_construct_with_robots_achievement:
    seq:
      - id: amount
        type: u4
      - id: unknown
        type: u4
# create-platform-achievement 	
#     byte[4]
#     Unknown format, 4 bytes long.
  type_create_platform_achievement:
    seq:
      - id: amount
        type: u4
# deconstruct-with-robots-achievement 	
#     int
#     Total number of objects deconstructed using robots.
  type_deconstruct_with_robots_achievement:
    seq:
      - id: amount
        type: u4
# deliver-by-robots-achievement 	
#     byte[4]
#     Unknown format, 4 bytes long.
  type_deliver_by_robots_achievement:
    seq:
      - id: amount
        type: u4
# deplete-resource-achievement 	
#     byte[4]
#     Unknown format, 4 bytes long.
# limited_to_one_game
  type_deplete_resource_achievement:
    seq:
      - id: amount
        type: u4
# destroy-cliff-achievement 	
#     byte[4]
#     Unknown format, 4 bytes long.
# limited_to_one_game
  type_destroy_cliff_achievement:
    seq:
      - id: amount
        type: u4
# dont-build-entity-achievement 	
#     byte[5]
#     Unknown format, 5 bytes long.
  type_dont_build_entity_achievement:
    seq:
      - id: data
        type: u1
        repeat: expr
        repeat-expr: 5
# dont-craft-manually-achievement 	
#     byte[4]
#     Unknown format, 4 bytes long.
  type_dont_craft_manually_achievement:
    seq:
      - id: data
        type: u4
# dont-kill-manually-achievement 	
#     ???
#     Unknown format, unknown length.
  type_dont_kill_manually_achievement:
    seq:
      - id: data
        size: 0
# dont-research-before-researching-achievement 	
#     ???
#     Unknown format, unknown length.
  type_dont_research_before_researching_achievement:
    seq:
      - id: data
        size: 0
# dont-use-entity-in-energy-production-achievement 	
#     double
#     Maximum number of Joules produced per hour, only including power produced from entities listed under "included", and excluding those listed under "excluded".
  type_dont_use_entity_in_energy_production_achievement:
    seq:
      - id: data
        type: f8
# equip-armor-achievement 	
#     byte[4]
#     Unknown format, 4 bytes long.
# limited_to_one_game
  type_equip_armor_achievement:
    seq:
      - id: amount
        type: u4
# group-attack-achievement 	
#     byte[4]
#     Unknown format, 4 bytes long.
  type_group_attack_achievement:
    seq:
      - id: amount
        type: u4
# kill-achievement 	
#     double
#     The greatest number of an entity killed (e.g. trees, spawners).
  type_kill_achievement:
    seq:
      - id: data
        type: f8
# module-transfer-achievement 	
#     byte[4]
#     Unknown format, 4 bytes long.
# limited_to_one_game
  type_module_transfer_achievement:
    seq:
      - id: amount
        type: u4
# place-equipment-achievement 	
#     byte[4]
#     Unknown format, 4 bytes long.
# limited_to_one_game
  type_place_equipment_achievement:
    seq:
      - id: amount
        type: u4
# player-damaged-achievement 	
#     float
#     bool
#     The maximum amount of damage you've taken in a single hit.
#     True if the you survived that hit, False if you died.
  type_player_damaged_achievement:
    seq:
      - id: amount
        type: f4
      - id: survived
        type: u1
# produce-achievement 	
#     double
#     The total number of the item you've produced.
# limited_to_one_game
  type_produce_achievement:
    seq:
      - id: amount
        type: f8
# produce-per-hour-achievement 	
#     double
#     The maximum amount of the item produced per hour.
  type_produce_per_hour_achievement:
    seq:
      - id: amount
        type: f8
# research-achievement 	
#     byte[0]
#     Unknown format, 0 bytes long.
  type_research_achievement:
    seq:
      - id: data
        size: 0
# research-with-science-pack-achievement 	
#     byte[4]
#     Unknown format, 4 bytes long.
  type_research_with_science_pack_achievement:
    seq:
      - id: amount
        type: u4
# shoot-achievement 	
#     byte[4]
#     Unknown format, 4 bytes long.
  type_shoot_achievement:
    seq:
      - id: amount
        type: u4
# space-connection-distance-traveled-achievement 	
#     byte[4]
#     Unknown format, 4 bytes long.
  type_space_connection_distance_traveled_achievement:
    seq:
      - id: distance
        type: u4
# train-path-achievement 	
#     double
#     The longest path (in tiles) planned by a train.
  type_train_path_achievement:
    seq:
      - id: distance
        type: f8
# use-entity-in-energy-production-achievement 	
#     byte[5]
#     Unknown format, 5 bytes long.
  type_use_entity_in_energy_production_achievement:
    seq:
      - id: data
        type: u1
        repeat: expr
        repeat-expr: 5
# use-item-achievement 	
#     byte[4]
#     Unknown format, 4 bytes long.
# limited_to_one_game
  type_use_item_achievement:
    seq:
      - id: amount
        type: u4

