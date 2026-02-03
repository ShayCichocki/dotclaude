-- Phthalo Green colorscheme
-- Base color: #123524

local colors = {
  -- Lighter backgrounds (visible phthalo green)
  bg0 = "#0f2c1e",
  bg1 = "#123524",
  bg2 = "#153d2a",
  bg3 = "#184630",
  bg4 = "#1b4e35",
  bg5 = "#1e573b",

  -- Phthalo Green base range
  green0 = "#205f41",
  green1 = "#236847",
  green2 = "#26704c",
  green3 = "#297952",
  green4 = "#2c8158",
  green5 = "#2f8a5e",

  -- Mid greens
  green6 = "#329264",
  green7 = "#359b69",
  green8 = "#38a36f",
  green9 = "#3aac75",
  green10 = "#3db47b",
  green11 = "#40bd80",

  -- Bright greens
  green12 = "#43c586",
  green13 = "#46ce8c",
  green14 = "#49d692",
  green15 = "#4cdf97",
  green16 = "#4fe79d",
  green17 = "#52f0a3",

  -- Brightest greens (accents)
  green18 = "#54f8a9",
  green19 = "#5fff9f",
  green20 = "#6affa5",
  green21 = "#75ffab",
  green22 = "#80ffb1",
  green23 = "#8bffb7",

  -- Additional colors for contrast
  white = "#ffffff",
  brightWhite = "#eeffee",
  gray = "#40bd80",
  red = "#ff6b6b",
  orange = "#ffa07a",
  yellow = "#ffe066",

  -- REAL cyan with blue component
  cyan = "#00d4d4",
  brightCyan = "#00ffff",
  aqua = "#33ffee",
}

local theme = {}

-- Editor colors
theme.editor = {
  Normal = { fg = colors.green15, bg = colors.bg1 },
  NormalFloat = { fg = colors.green15, bg = colors.bg2 },
  NormalNC = { fg = colors.green15, bg = colors.bg0 },

  -- Line numbers and column
  LineNr = { fg = colors.green9, bg = colors.bg1 },
  CursorLineNr = { fg = colors.aqua, bg = colors.bg2, bold = true },
  CursorLine = { bg = colors.bg2 },
  CursorColumn = { bg = colors.bg2 },
  ColorColumn = { bg = colors.bg3 },
  SignColumn = { fg = colors.green9, bg = colors.bg1 },

  -- Empty line markers (~)
  EndOfBuffer = { fg = colors.green7 },
  NonText = { fg = colors.green7 },

  -- Splits and borders
  VertSplit = { fg = colors.green7, bg = colors.bg0 },
  WinSeparator = { fg = colors.green7, bg = colors.bg0 },
  StatusLine = { fg = colors.green17, bg = colors.bg3 },
  StatusLineNC = { fg = colors.green9, bg = colors.bg2 },

  -- Popup menus
  Pmenu = { fg = colors.green15, bg = colors.bg3 },
  PmenuSel = { fg = colors.bg0, bg = colors.aqua, bold = true },
  PmenuSbar = { bg = colors.bg4 },
  PmenuThumb = { bg = colors.green11 },

  -- Search
  Search = { fg = colors.bg0, bg = colors.cyan },
  IncSearch = { fg = colors.bg0, bg = colors.aqua },
  CurSearch = { fg = colors.bg0, bg = colors.brightCyan, bold = true },

  -- Visual mode
  Visual = { bg = colors.green3 },
  VisualNOS = { bg = colors.green3 },

  -- Folds
  Folded = { fg = colors.green11, bg = colors.bg3 },
  FoldColumn = { fg = colors.green7, bg = colors.bg1 },

  -- Diff
  DiffAdd = { fg = colors.green20, bg = colors.bg3 },
  DiffChange = { fg = colors.yellow, bg = colors.bg3 },
  DiffDelete = { fg = colors.red, bg = colors.bg3 },
  DiffText = { fg = colors.aqua, bg = colors.bg4, bold = true },

  -- Errors and warnings
  ErrorMsg = { fg = colors.red, bold = true },
  WarningMsg = { fg = colors.orange, bold = true },
  ModeMsg = { fg = colors.green17, bold = true },
  MoreMsg = { fg = colors.green19 },
  Question = { fg = colors.green19 },

  -- Tab line
  TabLine = { fg = colors.green11, bg = colors.bg2 },
  TabLineFill = { bg = colors.bg1 },
  TabLineSel = { fg = colors.aqua, bg = colors.bg3, bold = true },

  -- Misc
  Directory = { fg = colors.aqua, bold = true },
  Title = { fg = colors.aqua, bold = true },
  MatchParen = { fg = colors.brightCyan, bg = colors.bg4, bold = true },
  Conceal = { fg = colors.green11 },
  SpecialKey = { fg = colors.green9 },
  Whitespace = { fg = colors.green5 },
}

-- Syntax highlighting
theme.syntax = {
  Comment = { fg = colors.green9, italic = true },

  Constant = { fg = colors.aqua },
  String = { fg = colors.green17 },
  Character = { fg = colors.green17 },
  Number = { fg = colors.brightCyan, bold = true },
  Boolean = { fg = colors.brightCyan, bold = true },
  Float = { fg = colors.brightCyan, bold = true },

  Identifier = { fg = colors.green15 },
  Function = { fg = colors.aqua, bold = true },

  Statement = { fg = colors.brightWhite, bold = true },
  Conditional = { fg = colors.brightWhite, bold = true },
  Repeat = { fg = colors.brightWhite, bold = true },
  Label = { fg = colors.green20, bold = true },
  Operator = { fg = colors.green17 },
  Keyword = { fg = colors.brightWhite, bold = true },
  Exception = { fg = colors.orange, bold = true },

  PreProc = { fg = colors.yellow },
  Include = { fg = colors.yellow },
  Define = { fg = colors.yellow },
  Macro = { fg = colors.yellow },
  PreCondit = { fg = colors.yellow },

  Type = { fg = colors.green19, bold = true },
  StorageClass = { fg = colors.green19, bold = true },
  Structure = { fg = colors.green19, bold = true },
  Typedef = { fg = colors.green19, bold = true },

  Special = { fg = colors.aqua },
  SpecialChar = { fg = colors.brightCyan },
  Tag = { fg = colors.green20 },
  Delimiter = { fg = colors.green11 },
  SpecialComment = { fg = colors.green13, italic = true },
  Debug = { fg = colors.orange },

  Underlined = { fg = colors.green17, underline = true },
  Ignore = { fg = colors.bg5 },
  Error = { fg = colors.red, bold = true },
  Todo = { fg = colors.yellow, bg = colors.bg3, bold = true },
}

-- Treesitter
theme.treesitter = {
  ["@variable"] = { fg = colors.green15 },
  ["@variable.builtin"] = { fg = colors.brightCyan, italic = true, bold = true },
  ["@variable.parameter"] = { fg = colors.green13 },
  ["@variable.member"] = { fg = colors.green16 },

  ["@constant"] = { fg = colors.aqua },
  ["@constant.builtin"] = { fg = colors.brightCyan },
  ["@constant.macro"] = { fg = colors.yellow },

  ["@string"] = { fg = colors.green17 },
  ["@string.escape"] = { fg = colors.aqua },
  ["@string.special"] = { fg = colors.aqua },

  ["@character"] = { fg = colors.green17 },
  ["@number"] = { fg = colors.brightCyan, bold = true },
  ["@boolean"] = { fg = colors.brightCyan, bold = true },
  ["@float"] = { fg = colors.brightCyan, bold = true },

  ["@function"] = { fg = colors.aqua, bold = true },
  ["@function.builtin"] = { fg = colors.brightCyan, bold = true },
  ["@function.macro"] = { fg = colors.yellow },
  ["@function.method"] = { fg = colors.aqua, bold = true },

  ["@constructor"] = { fg = colors.cyan },
  ["@operator"] = { fg = colors.green17 },

  ["@keyword"] = { fg = colors.brightWhite, bold = true },
  ["@keyword.function"] = { fg = colors.brightWhite, bold = true },
  ["@keyword.return"] = { fg = colors.brightWhite, bold = true },
  ["@keyword.operator"] = { fg = colors.brightWhite, bold = true },

  ["@conditional"] = { fg = colors.brightWhite, bold = true },
  ["@repeat"] = { fg = colors.brightWhite, bold = true },
  ["@exception"] = { fg = colors.orange, bold = true },

  ["@type"] = { fg = colors.green19, bold = true },
  ["@type.builtin"] = { fg = colors.green19, italic = true },
  ["@type.qualifier"] = { fg = colors.brightWhite, bold = true },

  ["@property"] = { fg = colors.green16 },
  ["@field"] = { fg = colors.green16 },

  ["@punctuation.delimiter"] = { fg = colors.green11 },
  ["@punctuation.bracket"] = { fg = colors.green13 },
  ["@punctuation.special"] = { fg = colors.green15 },

  ["@comment"] = { fg = colors.green9, italic = true },
  ["@tag"] = { fg = colors.green20 },
  ["@tag.attribute"] = { fg = colors.green16 },
  ["@tag.delimiter"] = { fg = colors.green11 },
}

-- LSP
theme.lsp = {
  DiagnosticError = { fg = colors.red },
  DiagnosticWarn = { fg = colors.orange },
  DiagnosticInfo = { fg = colors.cyan },
  DiagnosticHint = { fg = colors.green13 },

  DiagnosticUnderlineError = { undercurl = true, sp = colors.red },
  DiagnosticUnderlineWarn = { undercurl = true, sp = colors.orange },
  DiagnosticUnderlineInfo = { undercurl = true, sp = colors.cyan },
  DiagnosticUnderlineHint = { undercurl = true, sp = colors.green13 },

  LspReferenceText = { bg = colors.bg3 },
  LspReferenceRead = { bg = colors.bg3 },
  LspReferenceWrite = { bg = colors.bg3 },

  LspSignatureActiveParameter = { fg = colors.aqua, bold = true },
}

-- Git
theme.git = {
  GitSignsAdd = { fg = colors.green20 },
  GitSignsChange = { fg = colors.yellow },
  GitSignsDelete = { fg = colors.red },

  gitcommitSummary = { fg = colors.aqua },
  gitcommitComment = { fg = colors.green9, italic = true },
  gitcommitBranch = { fg = colors.brightCyan, bold = true },
}

-- Telescope
theme.telescope = {
  TelescopeNormal = { fg = colors.green15, bg = colors.bg2 },
  TelescopeBorder = { fg = colors.green9, bg = colors.bg2 },
  TelescopePromptNormal = { fg = colors.green15, bg = colors.bg3 },
  TelescopePromptBorder = { fg = colors.green11, bg = colors.bg3 },
  TelescopePromptTitle = { fg = colors.aqua, bold = true },
  TelescopePreviewTitle = { fg = colors.aqua, bold = true },
  TelescopeResultsTitle = { fg = colors.aqua, bold = true },
  TelescopeSelection = { fg = colors.brightCyan, bg = colors.bg4, bold = true },
  TelescopeSelectionCaret = { fg = colors.aqua, bg = colors.bg4 },
  TelescopeMatching = { fg = colors.brightCyan, bold = true },
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
