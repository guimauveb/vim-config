return {
  on_attach = function(_client, _) end,
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        features = "all",
      },
      check = {
        command = "clippy",
      },
      rustfmt = {
        -- FIXME: Neither overrideCommand nor extraArgs work, find out why (currently using autocmd).
        -- Formatting through rust_analyzer is disabled for now
        extraArgs = {
          "rustfmt",
          "+nightly",
          "--config-path",
          "~/.config/rustfmt/rustfmt.toml",
        },
      },
    },
  },
}
