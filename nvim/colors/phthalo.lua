-- Phthalo Green colorscheme
-- Base color: #123524

local colors = {
  -- Darkest (backgrounds)
  bg0 = "#010201",
  bg1 = "#040a07",
  bg2 = "#06130d",
  bg3 = "#091b13",
  bg4 = "#0c2418",
  bg5 = "#0f2c1e",

  -- Phthalo Green base range
  green0 = "#123524",
  green1 = "#153d2a",
  green2 = "#184630",
  green3 = "#1b4e35",
  green4 = "#1e573b",
  green5 = "#205f41",

  -- Mid greens
  green6 = "#236847",
  green7 = "#26704c",
  green8 = "#297952",
  green9 = "#2c8158",
  green10 = "#2f8a5e",
  green11 = "#329264",

  -- Bright greens
  green12 = "#359b69",
  green13 = "#38a36f",
  green14 = "#3aac75",
  green15 = "#3db47b",
  green16 = "#40bd80",
  green17 = "#43c586",

  -- Brightest greens (accents)
  green18 = "#46ce8c",
  green19 = "#49d692",
  green20 = "#4cdf97",
  green21 = "#4fe79d",
  green22 = "#52f0a3",
  green23 = "#54f8a9",

  -- Additional colors for contrast
  white = "#ffffff",
  brightWhite = "#eeffee",
  gray = "#40bd80",
  red = "#ff6b6b",
  orange = "#ffa07a",
  yellow = "#ffff99",
  cyan = "#66ffcc",
  brightCyan = "#88ffdd",
}

local theme = {}

-- Editor colors
theme.editor = {
  Normal = { fg = colors.green17, bg = colors.bg1 },
  NormalFloat = { fg = colors.green17, bg = colors.bg2 },
  NormalNC = { fg = colors.green17, bg = colors.bg0 },

  -- Line numbers and column
  LineNr = { fg = colors.green7, bg = colors.bg1 },
  CursorLineNr = { fg = colors.green17, bg = colors.bg2, bold = true },
  CursorLine = { bg = colors.bg2 },
  CursorColumn = { bg = colors.bg2 },
  ColorColumn = { bg = colors.bg3 },
  SignColumn = { fg = colors.green7, bg = colors.bg1 },

  -- Empty line markers (~)
  EndOfBuffer = { fg = colors.green5 },
  NonText = { fg = colors.green5 },

  -- Splits and borders
  VertSplit = { fg = colors.green3, bg = colors.bg0 },
  WinSeparator = { fg = colors.green3, bg = colors.bg0 },
  StatusLine = { fg = colors.green17, bg = colors.bg3 },
  StatusLineNC = { fg = colors.green7, bg = colors.bg2 },

  -- Popup menus
  Pmenu = { fg = colors.green17, bg = colors.bg3 },
  PmenuSel = { fg = colors.bg0, bg = colors.green17, bold = true },
  PmenuSbar = { bg = colors.bg4 },
  PmenuThumb = { bg = colors.green11 },

  -- Search
  Search = { fg = colors.bg0, bg = colors.green19 },
  IncSearch = { fg = colors.bg0, bg = colors.green23 },
  CurSearch = { fg = colors.bg0, bg = colors.green23, bold = true },

  -- Visual mode
  Visual = { bg = colors.green3 },
  VisualNOS = { bg = colors.green3 },

  -- Folds
  Folded = { fg = colors.green11, bg = colors.bg3 },
  FoldColumn = { fg = colors.green7, bg = colors.bg1 },

  -- Diff
  DiffAdd = { fg = colors.green23, bg = colors.bg3 },
  DiffChange = { fg = colors.yellow, bg = colors.bg3 },
  DiffDelete = { fg = colors.red, bg = colors.bg3 },
  DiffText = { fg = colors.cyan, bg = colors.bg4, bold = true },

  -- Errors and warnings
  ErrorMsg = { fg = colors.red, bold = true },
  WarningMsg = { fg = colors.orange, bold = true },
  ModeMsg = { fg = colors.green17, bold = true },
  MoreMsg = { fg = colors.green19 },
  Question = { fg = colors.green19 },

  -- Tab line
  TabLine = { fg = colors.green11, bg = colors.bg2 },
  TabLineFill = { bg = colors.bg1 },
  TabLineSel = { fg = colors.green23, bg = colors.bg3, bold = true },

  -- Misc
  Directory = { fg = colors.green19, bold = true },
  Title = { fg = colors.green23, bold = true },
  MatchParen = { fg = colors.green23, bg = colors.green3, bold = true },
  Conceal = { fg = colors.green11 },
  SpecialKey = { fg = colors.green7 },
  Whitespace = { fg = colors.bg5 },
}

-- Syntax highlighting
theme.syntax = {
  Comment = { fg = colors.green9, italic = true },

  Constant = { fg = colors.cyan },
  String = { fg = colors.green18 },
  Character = { fg = colors.green18 },
  Number = { fg = colors.brightCyan, bold = true },
  Boolean = { fg = colors.brightCyan, bold = true },
  Float = { fg = colors.brightCyan, bold = true },

  Identifier = { fg = colors.green17 },
  Function = { fg = colors.cyan, bold = true },

  Statement = { fg = colors.brightWhite, bold = true },
  Conditional = { fg = colors.brightWhite, bold = true },
  Repeat = { fg = colors.brightWhite, bold = true },
  Label = { fg = colors.green23, bold = true },
  Operator = { fg = colors.green19 },
  Keyword = { fg = colors.brightWhite, bold = true },
  Exception = { fg = colors.orange, bold = true },

  PreProc = { fg = colors.yellow },
  Include = { fg = colors.yellow },
  Define = { fg = colors.yellow },
  Macro = { fg = colors.yellow },
  PreCondit = { fg = colors.yellow },

  Type = { fg = colors.green21, bold = true },
  StorageClass = { fg = colors.green21, bold = true },
  Structure = { fg = colors.green21, bold = true },
  Typedef = { fg = colors.green21, bold = true },

  Special = { fg = colors.brightCyan },
  SpecialChar = { fg = colors.brightCyan },
  Tag = { fg = colors.green23 },
  Delimiter = { fg = colors.green14 },
  SpecialComment = { fg = colors.green16, italic = true },
  Debug = { fg = colors.orange },

  Underlined = { fg = colors.green19, underline = true },
  Ignore = { fg = colors.bg5 },
  Error = { fg = colors.red, bold = true },
  Todo = { fg = colors.yellow, bg = colors.bg3, bold = true },
}

-- Treesitter
theme.treesitter = {
  ["@variable"] = { fg = colors.green17 },
  ["@variable.builtin"] = { fg = colors.brightCyan, italic = true, bold = true },
  ["@variable.parameter"] = { fg = colors.green15 },
  ["@variable.member"] = { fg = colors.green18 },

  ["@constant"] = { fg = colors.cyan },
  ["@constant.builtin"] = { fg = colors.brightCyan },
  ["@constant.macro"] = { fg = colors.yellow },

  ["@string"] = { fg = colors.green18 },
  ["@string.escape"] = { fg = colors.brightCyan },
  ["@string.special"] = { fg = colors.brightCyan },

  ["@character"] = { fg = colors.green18 },
  ["@number"] = { fg = colors.brightCyan, bold = true },
  ["@boolean"] = { fg = colors.brightCyan, bold = true },
  ["@float"] = { fg = colors.brightCyan, bold = true },

  ["@function"] = { fg = colors.cyan, bold = true },
  ["@function.builtin"] = { fg = colors.brightCyan, bold = true },
  ["@function.macro"] = { fg = colors.yellow },
  ["@function.method"] = { fg = colors.cyan, bold = true },

  ["@constructor"] = { fg = colors.green23 },
  ["@operator"] = { fg = colors.green19 },

  ["@keyword"] = { fg = colors.brightWhite, bold = true },
  ["@keyword.function"] = { fg = colors.brightWhite, bold = true },
  ["@keyword.return"] = { fg = colors.brightWhite, bold = true },
  ["@keyword.operator"] = { fg = colors.brightWhite, bold = true },

  ["@conditional"] = { fg = colors.brightWhite, bold = true },
  ["@repeat"] = { fg = colors.brightWhite, bold = true },
  ["@exception"] = { fg = colors.orange, bold = true },

  ["@type"] = { fg = colors.green21, bold = true },
  ["@type.builtin"] = { fg = colors.green21, italic = true },
  ["@type.qualifier"] = { fg = colors.brightWhite, bold = true },

  ["@property"] = { fg = colors.green18 },
  ["@field"] = { fg = colors.green18 },

  ["@punctuation.delimiter"] = { fg = colors.green14 },
  ["@punctuation.bracket"] = { fg = colors.green17 },
  ["@punctuation.special"] = { fg = colors.green19 },

  ["@comment"] = { fg = colors.green9, italic = true },
  ["@tag"] = { fg = colors.green23 },
  ["@tag.attribute"] = { fg = colors.green18 },
  ["@tag.delimiter"] = { fg = colors.green14 },
}

-- LSP
theme.lsp = {
  DiagnosticError = { fg = colors.red },
  DiagnosticWarn = { fg = colors.orange },
  DiagnosticInfo = { fg = colors.green19 },
  DiagnosticHint = { fg = colors.green13 },

  DiagnosticUnderlineError = { undercurl = true, sp = colors.red },
  DiagnosticUnderlineWarn = { undercurl = true, sp = colors.orange },
  DiagnosticUnderlineInfo = { undercurl = true, sp = colors.green19 },
  DiagnosticUnderlineHint = { undercurl = true, sp = colors.green13 },

  LspReferenceText = { bg = colors.bg3 },
  LspReferenceRead = { bg = colors.bg3 },
  LspReferenceWrite = { bg = colors.bg3 },

  LspSignatureActiveParameter = { fg = colors.green23, bold = true },
}

-- Git
theme.git = {
  GitSignsAdd = { fg = colors.green23 },
  GitSignsChange = { fg = colors.yellow },
  GitSignsDelete = { fg = colors.red },

  gitcommitSummary = { fg = colors.green19 },
  gitcommitComment = { fg = colors.green9, italic = true },
  gitcommitBranch = { fg = colors.green23, bold = true },
}

-- Telescope
theme.telescope = {
  TelescopeNormal = { fg = colors.green17, bg = colors.bg2 },
  TelescopeBorder = { fg = colors.green7, bg = colors.bg2 },
  TelescopePromptNormal = { fg = colors.green17, bg = colors.bg3 },
  TelescopePromptBorder = { fg = colors.green11, bg = colors.bg3 },
  TelescopePromptTitle = { fg = colors.green23, bold = true },
  TelescopePreviewTitle = { fg = colors.green23, bold = true },
  TelescopeResultsTitle = { fg = colors.green23, bold = true },
  TelescopeSelection = { fg = colors.green23, bg = colors.bg4, bold = true },
  TelescopeSelectionCaret = { fg = colors.green23, bg = colors.bg4 },
  TelescopeMatching = { fg = colors.green23, bold = true },
}

local function apply_highlights(groups)
  for group, settings in pairs(groups) do
    vim.api.nvim_set_hl(0, group, settings)
  end
end

local function setup()
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  vim.o.termguicolors = true
  vim.g.colors_name = "phthalo"

  apply_highlights(theme.editor)
  apply_highlights(theme.syntax)
  apply_highlights(theme.treesitter)
  apply_highlights(theme.lsp)
  apply_highlights(theme.git)
  apply_highlights(theme.telescope)
end

setup()

return theme
