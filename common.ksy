meta:
  id: factorio_common
  title: Factorio's common types and structures
  ks-version: 0.11
  endian: le
doc: |
  To-do:
  * [ ] Find data (binary files, network packets) using space optimized bytes, `array` and `dict`.
  * [ ] Implement space optimized bytes (once data available).
  * [ ] Implement `array` (once data available).
  * [ ] Implement `dict` (once data available, maybe mod settings?).

  Kaitai types matching Factorio types:

  |   type   |   kaitai   |  avail. |
  | -------- | ---------- | ------- |
  | `bool`   | `_boolean` | custom  |
  | `float`  |    `f4`    | builtin |
  | `double` |    `f8`    | builtin |
  | `string` | `_string`  | custom  |
  | `array`  |    TODO    | custom  |
  | `dict`   |    TODO    | custom  |

  Types for `bool` and `string` required customization to match Factorio's specification.

  Kaitai types (builtin) matching Factorio integers:

  |  type   | signed | unsigned |
  | ------- | ------ | -------- |
  | `byte`  |  `s1`  |   `u1`   |
  | `short` |  `s2`  |   `u2`   |
  | `int`   |  `s4`  |   `u4`   |
  | `long`  |  `s8`  |   `u8`   |

  Integers are signed by default.
doc-ref: https://wiki.factorio.com/Data_types
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
