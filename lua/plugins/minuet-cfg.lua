-- harmonize.nvim: AI tab-completion (ghost text) backed by local llama.cpp.
--
-- Backend: llama-server serving ggml-org/Qwen2.5-Coder-1.5B-Q8_0-GGUF
-- (FIM-capable), reached through llama.cpp's native /infill endpoint — the
-- server constructs the FIM prompt from the model's own tokens, so no
-- template is configured here.
--
-- The single-line display shows the completion one line at a time and Tab
-- accepts it chunk by chunk. Requests fire as soon as typing pauses; arrow
-- keys and scrolling only dismiss a stale suggestion.
--
-- Tab accepts the next chunk (the hook lives in plugins/nvim-cmp-cfg.lua, so
-- the default Tab binding is disabled here); the other keys stay on M- chords.

require("harmonize").setup({
    provider = "llama_cpp",
    context_window = 512, -- conservative for local inference; raise if the machine keeps up
    throttle = 0, -- no request limit: every pause fires immediately
    debounce = 50, -- fire almost as soon as typing pauses (ms)
    auto_trigger_ft = { "*" }, -- suggest in every filetype; narrow to e.g. { "rust", "lua" } to limit
    keymap = {
        -- Tab accepts one chunk; nvim-cmp-cfg.lua binds Tab itself,
        -- and its mapping replaces the default acceptance key below.
        accept = "<M-A>", -- accept one chunk
        accept_line = "<M-a>", -- accept one line
        dismiss = "<M-e>",
        trigger = "<M-]>", -- manually request a completion
        toggle = "<M-c>", -- toggle auto-completion on and off
    },
    -- one-line viewport: show only the remainder of the current line
    -- (or the next line when the completion starts with a newline);
    -- the rest stays cached for further acceptance
    display = "line",
    provider_options = {
        llama_cpp = {
            end_point = "http://127.0.0.1:8012/infill",
            optional = {
                -- streamed: the first chunk appears fast even with a large cap
                n_predict = 256,
                top_p = 0.9,
            },
        },
    },
    -- auto_start defaults apply: when nothing answers on 127.0.0.1:8012,
    -- harmonize starts `llama serve` with the Qwen model (reused from PATH
    -- or downloaded) and leaves it running when nvim exits. The server
    -- already running here is detected and left alone.
})
