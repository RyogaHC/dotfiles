-- return {
--     "Kurama622/llm.nvim",
--     lazy = true,
--     dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim"},
--     cmd = { "LLMSessionToggle", "LLMSelectedTextHandler", "LLMAppHandler"},
--     config = function()
--       require("llm").setup({
--         url = "http://localhost:11434/api/chat",
--         model = "qwen3.5",
--         api_type = "ollama",
-- 	fetch_key = "None",
--       })
--     end,
--     keys = {
--       { "<leader>ac", mode = "n", "<cmd>LLMSessionToggle<cr>" },
--     },
-- }

-- Minimal configuration


-- Custom Parameters (with defaults)
return {
    "David-Kunz/gen.nvim",
    opts = {
        model = "qwen3.5:4b", -- The default model to use.
        quit_map = "q", -- set keymap to close the response window
        retry_map = "<c-r>", -- set keymap to re-send the current prompt
        accept_map = "<c-cr>", -- set keymap to replace the previous selection with the last result
        host = "localhost", -- The host running the Ollama service.
        port = "11434", -- The port on which the Ollama service is listening.
        display_mode = "float", -- The display mode. Can be "float" or "split" or "horizontal-split" or "vertical-split".
        show_prompt = false, -- Shows the prompt submitted to Ollama. Can be true (3 lines) or "full".
        show_model = false, -- Displays which model you are using at the beginning of your chat session.
        no_auto_close = false, -- Never closes the window automatically.
        file = false, -- Write the payload to a temporary file to keep the command short.
        hidden = false, -- Hide the generation window (if true, will implicitly set `prompt.replace = true`), requires Neovim >= 0.10
        -- init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
        -- Function to initialize Ollama
        command = function(options)
            local body = {model = options.model, stream = true}
            return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
        end,
        -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
        -- This can also be a command string.
        -- The executed command must return a JSON object with { response, context }
        -- (context property is optional).
        -- list_models = '<omitted lua function>', -- Retrieves a list of model names
        result_filetype = "markdown", -- Configure filetype of the result buffer
        debug = false -- Prints errors and the command which is run.
    }
}
