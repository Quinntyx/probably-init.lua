-- minuet-ai.nvim: AI tab-completion (virtual text) backed by local llama.cpp.
--
-- Backend: llama-server serving ggml-org/Qwen2.5-Coder-1.5B-Q8_0-GGUF
-- (FIM-capable). The model id is fixed at server launch — minuet only points
-- at the OpenAI-compatible /v1/completions endpoint.
--
-- 1-line generation: we send stop = { "\n" }, so the model stops at the first
-- newline instead of emitting a multi-line block.
--
-- Frontend: virtual text (ghost text). nvim-cmp keeps its <Tab> cycling; the
-- virtual-text keys are M- chords, so there is no keymap conflict.

require("minuet").setup({
    provider = "openai_fim_compatible",
    n_completions = 1, -- single local model: one candidate, less latency
    context_window = 512, -- conservative for local inference; raise if the machine keeps up
    throttle = 0, -- no request limit: every pause fires immediately
    debounce = 50, -- fire almost as soon as typing pauses (ms)
    virtualtext = {
        auto_trigger_ft = { "*" }, -- suggest in every filetype; narrow to e.g. { "rust", "lua" } to limit
        keymap = {
            accept = "<M-A>", -- accept whole completion
            accept_line = "<M-a>", -- accept one line
            accept_n_lines = "<M-z>", -- accept n lines (prompts for count)
            prev = "<M-[>", -- prev candidate / manual invoke
            next = "<M-]>", -- next candidate / manual invoke
            dismiss = "<M-e>",
        },
        -- keep ghost text visible even while nvim-cmp's menu is open
        show_on_completion_menu = true,
    },
    provider_options = {
        openai_fim_compatible = {
            api_key = "TERM", -- non-null env-var placeholder minuet requires; the local server ignores it
            name = "Llama.cpp",
            end_point = "http://localhost:8012/v1/completions",
            -- The model is chosen when llama-server is launched; it cannot be
            -- changed per-request, so this value is only informational.
            model = "qwen2.5-coder-1.5b",
            optional = {
                max_tokens = 256,
                stop = { "\n" }, -- 1-line generation
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