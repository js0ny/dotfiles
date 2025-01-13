// Paste this into surfingkeys advanced settings
// or use:
// Load settings from: https://raw.githubusercontent.com/js0ny/dotfiles/refs/heads/master/tools/browser/surfingkeys.js

// #region Example
/** Examples

// an example to create a new mapping `ctrl-y`
api.mapkey('<ctrl-y>', 'Show me the money', function() {
    Front.showPopup('a well-known phrase uttered by characters in the 1996 film Jerry Maguire (Escape to close).');
});

// an example to replace `T` with `gt`, click `Default mappings` to see how `T` works.
api.map('gt', 'T');


// an example to remove mapkey `Ctrl-i`
api.unmap('<ctrl-i>');

*/
// #endregion
// Settings
settings.language = "zh-CN";
settings.showModeStatus = false;
// Keymap, reference https://github.com/texiwustion/colemak_config_for_surfingkeys/tree/main
// #region Helper
const {
  aceVimMap,
  addVimMapKey,
  mapkey,
  imap,
  imapkey,
  getClickableElements,
  vmapkey,
  map,
  unmap,
  cmap,
  addSearchAlias,
  removeSearchAlias,
  tabOpenLink,
  readText,
  Clipboard,
  Front,
  Hints,
  Visual,
  RUNTIME,
} = api;
const forward = {
  add: function (key) {
    // 转发即将被 unmap 的键
    return api.map(`for${key}`, key);
  },
  cancel: function (key) {
    // 删除转发生成的键
    api.unmap(`for${key}`);
    api.unmap(key);
  },
  use: function (key) {
    return `for${key}`;
  },
};

const colemak = {
  forward: function (key) {
    // 转发即将被 unmap 的键
    api.map(key, `col${key}`);
    api.unmap(`col${key}`);
  },
  use: function (key) {
    return `col${key}`;
  },
  map: function (a, b) {
    api.map(colemak.use(a), forward.use(b));
  },
};

const vForward = {
  add: function (key) {
    // 转发即将被 unmap 的键
    return api.vmap(`vfor${key}`, key);
  },
  cancel: function (key) {
    // 删除转发生成的键
    api.vunmap(`vfor${key}`);
    api.vunmap(key);
  },
  use: function (key) {
    return `vfor${key}`;
  },
};

const vColemak = {
  forward: function (key) {
    // 转发即将被 unmap 的键
    api.vmap(key, `vcol${key}`);
    api.vunmap(`vcol${key}`);
  },
  use: function (key) {
    return `vcol${key}`;
  },
  map: function (a, b) {
    api.vmap(vColemak.use(a), vForward.use(b));
  },
};

const forwardFactory = {
  push: function (mapLists) {
    // forward original keys
    for (let key in mapLists) {
      forward.add(mapLists[key]);
    }
  },
  map: function (mapLists) {
    for (let key in mapLists) {
      colemak.map(key, mapLists[key]);
    }
  },
  pull: function (mapLists) {
    for (let key in mapLists) {
      forward.cancel(mapLists[key]);
    }
    for (let key in mapLists) {
      colemak.forward(key);
    }
  },
};
const vForwardFactory = {
  push: function (mapLists) {
    // forward original keys
    for (let key in mapLists) {
      vForward.add(mapLists[key]);
    }
  },
  map: function (mapLists) {
    for (let key in mapLists) {
      vColemak.map(key, mapLists[key]);
    }
  },
  pull: function (mapLists) {
    for (let key in mapLists) {
      vForward.cancel(mapLists[key]);
    }
    for (let key in mapLists) {
      vColemak.forward(key);
    }
  },
};

const parseSearchResponse = function (response) {
  const res = JSON.parse(response.text);
  return res.map((r) => r.phrase);
};

const _addSearchAlias = function (
  alias,
  name,
  searchUrl,
  searchPrefix = "s",
  acUrl = "https://duckduckgo.com/ac/?q=",
  parseResponse = parseSearchResponse,
) {
  api.addSearchAlias(
    alias,
    name,
    searchUrl,
    searchPrefix,
    acUrl,
    parseResponse,
  );
};
// #endregion

// #region Keymap
const mapLists = {
  /// scroll page
  // Arrow
  n: "j",
  e: "k",
  i: "l",
  // l <-> i
  l: "i",
  L: "I",
  // k <-> n
  k: "n",
  K: "N",
  // j <-> e
  j: "e",
  // PrevTab < H - I > NextTab
  H: "E",
  I: "R",
  // E,N -> Up/Down HalfPage
  N: "d",
  E: "e",
  // F -> Open Link in New Tab
  F: "af",
  // oH -> Tab History
  oH: "H",
  // gh/gi -> Prev/Next History
  gh: "S",
  gi: "D",
  // t -> Open Link in New Tab
  t: "gf",
  // 缩放
  zu: "zi",
  zo: "ze",
  zz: "zr",
};

const vMapLists = {
  n: "j",
  N: "J",
  e: "k",
  E: "K",
  i: "l",
  I: "L",
  j: "e",
  J: "E",
  k: "n",
  K: "N",
};

forwardFactory.push(mapLists);
forwardFactory.map(mapLists);

vForwardFactory.push(vMapLists);
vForwardFactory.map(vMapLists);
// 鼠标点击
api.unmap("gi");
api.unmap("[[");
api.unmap("]]");
api.unmap(";m");
api.unmap(";fs");
api.unmap("O");
api.unmap("C");
api.map("g/", "gU"); // Goto Root Domain
// p to site-specific
api.unmap("p");
api.unmap("<space>"); // Leader Key
forwardFactory.pull(mapLists);
vForwardFactory.pull(vMapLists);
// #endregion

// #region Search Alias
api.unmap("os"); // StackOverflow
api.vunmap("ss");
api.unmap("ob"); // Baidu
api.vunmap("sb");
api.unmap("og"); // Google
api.vunmap("sg");
api.unmap("od"); // DuckDuckGo
api.vunmap("sd");
api.unmap("ow"); // Bing
api.vunmap("sw");

/// Common
_addSearchAlias("dd", "DuckDuckGo", "https://duckduckgo.com/?q=");
_addSearchAlias("gg", "Google", "https://www.google.com/search?q=");
_addSearchAlias("bd", "Baidu", "https://www.baidu.com/s?wd=");
_addSearchAlias("bi", "Bing", "https://www.bing.com/search?q=");
/// AI Search
_addSearchAlias("fe", "Felo", "https://felo.ai/search?q=");
_addSearchAlias("pp", "Perplexity", "https://www.perplexity.ai/?q=");
_addSearchAlias("cg", "ChatGPT", "https://chat.openai.com/?q=");
/// EECS Related
_addSearchAlias(
  "gh",
  "GitHub",
  "https://github.com/search?type=repositories&q=",
);
_addSearchAlias("so", "StackOverflow", "https://stackoverflow.com/search?q=");
_addSearchAlias(
  "aw",
  "ArchWiki",
  "https://wiki.archlinux.org/index.php?search=",
);
/// Software
_addSearchAlias("sc", "Scoop", "https://scoop.sh/#/apps?q=");
_addSearchAlias("br", "Brew", "https://duckduckgo.com/?q=!brew ");

// #endregion

// #region Site-specific
// chatgpt.com
const chatgptNewChat = function () {
  var btn = document.querySelector(
    "div.no-draggable:nth-child(3) > span:nth-child(1) > button:nth-child(1)",
  );
  btn.click();
};
const chatgptStartStop = function () {
  var btn = document.querySelector("button.h-8:nth-child(2)");
  btn.click();
};
api.unmap("t", /chatgpt.com/);
api.mapkey("tn", "New Chat", chatgptNewChat, { domain: /chatgpt.com/ });
api.mapkey("ts", "Start/Stop Generating", chatgptStartStop, {
  domain: /chatgpt.com/,
});
api.mapkey("S", "Start/Stop Generating", chatgptStartStop, {
  domain: /chatgpt.com/,
});
api.mapkey("an", "New Chat", chatgptNewChat, { domain: /chatgpt.com/ });
api.mapkey("as", "Start/Stop Generating", chatgptStartStop, {
  domain: /chatgpt.com/,
});

//api.mapkey('tm', 'Toggle Model', function () {
//  var btn = document.querySelector('#radix -\: r2i\:');
//  btn.click();
//}, { domain: /chatgpt.com/ });
// perplexity.ai
api.unmap("<Ctrl-i>", /perplexity.ai/); // allows to use perplexity web keybindings
api.map();

// #endregion

// #region ACE Editor
addVimMapKey(
  // Navigation
  {
    keys: "k",
    type: "motion",
    motion: "findNext",
    motionArgs: { forward: true, toJumplist: true },
  },
  {
    keys: "K",
    type: "motion",
    motion: "findNext",
    motionArgs: { forward: false, toJumplist: true },
  },

  // Word movement
  {
    keys: "j",
    type: "motion",
    motion: "moveByWords",
    motionArgs: { forward: true, wordEnd: true, inclusive: true },
  },
  {
    keys: "J",
    type: "motion",
    motion: "moveByWords",
    motionArgs: {
      forward: true,
      wordEnd: true,
      bigWord: true,
      inclusive: true,
    },
  },

  // Insert mode entries
  {
    keys: "l",
    type: "action",
    action: "enterInsertMode",
    isEdit: true,
    actionArgs: { insertAt: "inplace" },
    context: "normal",
  },
  {
    keys: "gl",
    type: "action",
    action: "enterInsertMode",
    isEdit: true,
    actionArgs: { insertAt: "lastEdit" },
    context: "normal",
  },
  {
    keys: "L",
    type: "action",
    action: "enterInsertMode",
    isEdit: true,
    actionArgs: { insertAt: "firstNonBlank" },
    context: "normal",
  },
  {
    keys: "gL",
    type: "action",
    action: "enterInsertMode",
    isEdit: true,
    actionArgs: { insertAt: "bol" },
    context: "normal",
  },
  {
    keys: "L",
    type: "action",
    action: "enterInsertMode",
    isEdit: true,
    actionArgs: { insertAt: "startOfSelectedArea" },
    context: "visual",
  },
  {
    keys: "n",
    type: "motion",
    motion: "moveByLines",
    motionArgs: { forward: true, linewise: true },
  },
  {
    keys: "e",
    type: "motion",
    motion: "moveByLines",
    motionArgs: { forward: false, linewise: true },
  },
  {
    keys: "i",
    type: "motion",
    motion: "moveByCharacters",
    motionArgs: { forward: true },
  },
  {
    keys: "H",
    type: "keyToKey",
    toKeys: "^",
  },
  {
    keys: "I",
    type: "keyToKey",
    toKeys: "$",
  },
  {
    keys: "Y",
    type: "keyToKey",
    toKeys: "y$",
  },
);

// #endregion
