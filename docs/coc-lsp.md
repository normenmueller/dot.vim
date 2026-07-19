# CoC and language servers

## Runtime requirements

CoC is installed as a Vim plugin and built through npm. Language servers are
separate executables. Haskell buffers require
`haskell-language-server-wrapper`.

Completion is intentionally manual because `suggest.autoTrigger` is `none` in
`coc-settings.json`. Press `<C-Space>` in Insert mode to request completion.

## Shared mappings

These mappings apply when the active CoC language server supports the
underlying capability:

| Mapping | Action |
| --- | --- |
| `<C-Space>` | Request completion in Insert mode |
| `[g` / `]g` | Go to the previous or next diagnostic |
| `gd` | Go to definition |
| `gi` | Go to implementation |
| `gy` | Go to type definition |
| `gr` | Find references |
| `K` | Show hover information |
| `<Space>rn` | Rename the current symbol |
| `<Space>o` | Toggle the document outline |
| `<Space>a` | List diagnostics |
| `<Space>c` | List CoC commands |
| `<Space>e` | Manage CoC extensions |
| `<Space>s` | Search workspace symbols |
| `<Space>j` / `<Space>k` | Select the next or previous CoC list item |
| `<Space>p` | Resume the last CoC list |

`:CocDiagnostics` opens the current buffer's diagnostics in the location list.
`:Format` requests formatting from the active language server; availability and
results depend on that server.

## Configured language servers

The current configuration defines one external language server directly in
`coc-settings.json`:

| Filetypes | Command |
| --- | --- |
| `haskell`, `lhaskell` | `haskell-language-server-wrapper --lsp` |
