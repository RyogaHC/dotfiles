return {
    "Kurama622/llm.nvim",
    lazy = true,
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim"},
    cmd = { "LLMSessionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
    config = function()
      require("llm").setup({
        url = "http://localhost:11434/api/chat",
        model = "qwen3-vl:4b-instruct",
        api_type = "ollama",
	fetch_key = "None",
      })
    end,
    keys = {
      { "<leader>ac", mode = "n", "<cmd>LLMSessionToggle<cr>" },
    },
}
