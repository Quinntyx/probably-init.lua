-- harmonize.nvim: AI tab-completion (ghost text) backed by local llama.cpp.
--
-- Backend: llama-server serving ggml-org/Qwen2.5-Coder-1.5B-Q8_0-GGUF
-- (FIM-capable), reached through llama.cpp's native /infill endpoint — the
-- server constructs the FIM prompt from the model's own tokens, so no
-- template is configured here.
--
-- The below-line display overlays same-line completions beneath the cursor.
-- Newline-leading completions show ↵ at the cursor, use their actual next-line
-- position, and shift following screen text down. The next accepted chunk uses
-- the theme's Special color, later text remains readable, and the whole preview
-- uses the completion menu background so it stays separate from code.
--
-- F13 accepts Harmonize independently from the cmp/LSP Tab mapping.

require("harmonize").setup({
    provider = "llama_cpp",
    context_window = 512, -- conservative for local inference; raise if the machine keeps up
    throttle = 0, -- no request limit: every pause fires immediately
    debounce = 50, -- fire almost as soon as typing pauses (ms)
    auto_trigger_ft = { "*" }, -- suggest in every filetype; narrow to e.g. { "rust", "lua" } to limit
    keymap = {
        accept = "<F13>", -- accept one chunk
        accept_line = "<M-a>", -- accept one line
        dismiss = "<M-e>",
        trigger = "<M-]>", -- manually request a completion
        toggle = "<M-c>", -- toggle auto-completion on and off
    },
    -- Overlay same-line text below the cursor; newline-leading text shows ↵ and
    -- uses an in-place virtual line at its actual insertion position.
    display = "below",
    -- Keep the LSP/cmp menu visible above the Harmonize preview.
    show_with_completion_menu = true,
    -- Accent only the text that Tab will accept next, and use the completion
    -- menu background for the floating preview. Either value can be #RRGGBB.
    display_options = {
        below = {
            next_chunk_highlight = "Special",
            background_highlight = "Pmenu",
        },
        line = { next_chunk_highlight = "Special" },
        chunk = {},
    },
    -- Stop chunks after whitespace. Newlines accept indentation only; set this
    -- to "." to include a Rust-style method-chain dot with the newline.
    chunk_options = {
        allow_post_newline_chars = "",
    },
    -- Reuse matching line suffixes and exact predicted next lines.
    match_existing_text = true,
    -- Refill the cache from its predicted endpoint when fewer than two
    -- newline-terminated lines remain.
    extension_options = {
        enabled = true,
        minimum_remaining_lines = 2,
    },
    -- harmonize starts the server when nothing answers on 127.0.0.1:8012
    -- (the running one is detected and left alone) and leaves it running
    -- when nvim exits; nil by default, so this table opts in.
    auto_start = {
        model = "ggml-org/Qwen2.5-Coder-1.5B-Q8_0-GGUF",
        host = "127.0.0.1",
        port = 8012,
    },
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
