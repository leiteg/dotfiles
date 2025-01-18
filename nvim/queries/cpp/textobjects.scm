; extends

[
  (function_definition)
  (class_specifier) 
  (struct_specifier) 
] @toplevel

; TODO: Improve this
(field_declaration
  declarator: [
    (field_identifier)
    (pointer_declarator
      declarator: (field_identifier))
  ]) @field
