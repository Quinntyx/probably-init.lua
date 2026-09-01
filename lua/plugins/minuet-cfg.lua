-- harmonize.nvim: AI tab-completion (ghost text) backed by local llama.cpp.
--
-- Backend: llama-server serving ggml-org/Qwen2.5-Coder-1.5B-Q8_0-GGUF
-- (FIM-capable). The model id is fixed at server launch — harmonize only points
-- at the OpenAI-compatible /v1/completions endpoint.
--
-- The single-line display shows the completion one line at a time and Tab
-- accepts it chunk by chunk. Requests fire as soon as typing pauses; arrow
-- keys and scrolling only dismiss a stale suggestion.
--
-- Tab accepts the next chunk (the hook lives in plugins/nvim-cmp-cfg.lua, so
-- the default Tab binding is disabled here); the other keys stay on M- chords.

require("harmonize").setup({
    provider = "openai_fim_compatible",
    context_window = 512, -- conservative for local inference; raise if the machine keeps up
    throttle = 0, -- no request limit: every pause fires immediately
    debounce = 50, -- fire almost as soon as typing pauses (ms)
    auto_trigger_ft = { "*" }, -- suggest in every filetype; narrow to e.g. { "rust", "lua" } to limit
    keymap = {
        -- Tab accepts one chunk; nvim-cmp-cfg.lua binds Tab itself,
        -- and its mapping replaces the default acceptance key below.
        accept = "<M-A>", -- accept whole completion
        accept_line = "<M-a>", -- accept one line
        accept_n_lines = "<M-z>", -- accept n lines (prompts for count)
        dismiss = "<M-e>",
        trigger = "<M-]>", -- manually request a completion
    },
    -- keep ghost text visible even while nvim-cmp's menu is open
    show_on_completion_menu = true,
    -- one-line viewport: show only the remainder of the current line
    -- (or the next line when the completion starts with a newline);
    -- the rest stays cached for further acceptance
    display = "line",
    provider_options = {
        openai_fim_compatible = {
            api_key = "TERM", -- non-null env-var placeholder harmonize requires; the local server ignores it
            name = "Llama.cpp",
            end_point = "http://localhost:8012/v1/completions",
            -- The model is chosen when llama-server is launched; it cannot be
            -- changed per-request, so this value is only informational.
            model = "qwen2.5-coder-1.5b",
            optional = {
                -- streamed: the first chunk appears fast even with a large cap
                max_tokens = 256,
                top_p = 0.9,
            },
            -- llama.cpp has no suffix option in FIM, so embed the Qwen2.5-Coder
            -- FIM special tokens directly in the prompt.
            template = {
                prompt = function(context_before_cursor, context_after_cursor, _)
                    return "<|fim_prefix|>"
                        .. context_before_cursor
                        .. "<|fim_suffix|>"
                        .. context_after_cursor
                        .. "<|fim_middle|>"
                end,
                suffix = false,
            },
        },
    },
})
