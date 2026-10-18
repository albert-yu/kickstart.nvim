;; extends

; WebGPU WGSL in template string: /* wgsl */ `...` or /* WGSL */ `...`
((comment) @_comment . (template_string) @injection.content
  (#lua-match? @_comment "^/[*]%s*[wW][gG][sS][lL]%s*[*]/$")
  (#set! injection.language "wgsl")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.include-children))

; WebGPU WGSL in string literal: /* wgsl */ "..." or /* wgsl */ '...'
((comment) @_comment . (string (string_fragment) @injection.content)
  (#lua-match? @_comment "^/[*]%s*[wW][gG][sS][lL]%s*[*]/$")
  (#set! injection.language "wgsl"))

; WebGPU WGSL inside template string start: `/* wgsl */ ...` or `// wgsl ...`
((template_string) @injection.content
  (#lua-match? @injection.content "^`%s*/%*%s*[wW][gG][sS][lL]%s*%*/")
  (#set! injection.language "wgsl")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.include-children))

((template_string) @injection.content
  (#lua-match? @injection.content "^`%s*//%s*[wW][gG][sS][lL]")
  (#set! injection.language "wgsl")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.include-children))

; Generic /* <lang> */ comment preceding a template string (e.g. /* glsl */ `...`, /* sql */ `...`)
((comment) @injection.language . (template_string) @injection.content
  (#lua-match? @injection.language "^/[*]%s*([a-zA-Z][a-zA-Z0-9_]+)%s*[*]/$")
  (#gsub! @injection.language "^/[*]%s*([a-zA-Z][a-zA-Z0-9_]+)%s*[*]/$" "%1")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.include-children))
