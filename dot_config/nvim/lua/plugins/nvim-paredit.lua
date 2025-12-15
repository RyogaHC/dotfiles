return {
  "julienvincent/nvim-paredit",
  lazy = true,
  ft = {"lisp", "clojure", "fennel", "hy"},
  config = function()
    require("nvim-paredit").setup()
  end
}
