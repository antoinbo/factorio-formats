meta:
  id: factorio_mod_settings_dat
  title: Factorio mod settings file
  file-extension: dat
  ks-version: 0.11
  endian: le
doc: |
  Reference: https://wiki.factorio.com/Mod_settings_file_format
doc-ref: https://wiki.factorio.com/Mod_settings_file_format
seq:
  - id: version
    type: factorio_version
  - id: false
    # type: factorio_boolean
    contents: [0x00]
  - id: settings
    type: factorio_property_tree
types:
  # Factorio specific types
  factorio_boolean:
    doc: |
      Factorio's boolean:
      - 1 is true
      - * is false
    seq:
      - id: value
        type: u1
    instances:
      is_false:
        value: value != 1
      is_true:
        value: value == 1
  factorio_version:
    seq:
      - id: major
        type: s2
      - id: minor
        type: s2
      - id: patch
        type: s2
      - id: developer
        type: s2
  factorio_string:
    doc: |
      Factorio's string prefixed by length.
    seq:
      - id: length
        type: u1
      - id: value
        type: str
        size: length
        encoding: ascii
  factorio_property_tree:
    seq:
      - id: type
        type: u1
        enum: factorio_property_tree_type
      - id: any
        type: u1
      - id: property
        type:
          switch-on: type
          cases:
            'factorio_property_tree_type::none': factorio_property_none
            'factorio_property_tree_type::bool': factorio_property_bool
            'factorio_property_tree_type::number': factorio_property_number
            'factorio_property_tree_type::string': factorio_property_string
            # 'factorio_property_tree_type::list': factorio_property_list
            'factorio_property_tree_type::list': factorio_property_dictionary
            'factorio_property_tree_type::dictionary': factorio_property_dictionary
            'factorio_property_tree_type::signed_integer': factorio_property_signed_integer
            'factorio_property_tree_type::unsigned_integer': factorio_property_unsigned_integer
  factorio_property_tree_item:
    seq:
      - id: key
        type: factorio_property_string
      - id: value
        type: factorio_property_tree
  factorio_property_none:
    seq:
      - id: none
        size: 0
  factorio_property_bool:
    seq:
      - id: value
        type: factorio_boolean
  factorio_property_number:
    seq:
      - id: value
        type: f8
  factorio_property_string:
    seq:
      - id: empty
        type: factorio_boolean
      - id: value
        type: factorio_string
        if: empty.is_false
  # factorio_property_list:
  #   seq:
  #     - id: none
  #       size: 0
  factorio_property_dictionary:
    seq:
      - id: length
        type: u4
      - id: items
        type: factorio_property_tree_item
        repeat: expr
        repeat-expr: length
  factorio_property_signed_integer:
    seq:
      - id: value
        type: s8
  factorio_property_unsigned_integer:
    seq:
      - id: value
        type: u8
enums:
  factorio_property_tree_type:
    0: none
    1: bool
    2: number
    3: string
    4: list
    5: dictionary
    6: signed_integer
    7: unsigned_integer

