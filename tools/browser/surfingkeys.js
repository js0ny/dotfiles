// Paste this into surfingkeys advanced settings
// or use:
// Load settings from: https://raw.githubusercontent.com/js0ny/dotfiles/refs/heads/master/tools/browser/surfingkeys.js
// Browse to Extension > Surfingkeys > Allow access to file URLs to enable local file access
// Windows: file:///C:/Users/username/.dotfiles/tools/browser/surfingkeys.js
// *nix: file:///home/username/.dotfiles/tools/browser/surfingkeys.js

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

// #region Settings
settings.language = "zh-CN";
settings.showModeStatus = false;
// #endregion

// #region Helper
// import the API so that no need to use `api` prefix
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
// Keymap, reference https://github.com/texiwustion/colemak_config_for_surfingkeys/tree/main
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
    for (const key in mapLists) { // `const` better than `let`
      forward.add(mapLists[key]);
    }
  },
  map: function (mapLists) {
    for (const key in mapLists) {
      colemak.map(key, mapLists[key]);
    }
  },
  pull: function (mapLists) {
    for (const key in mapLists) {
      forward.cancel(mapLists[key]);
    }
    for (const key in mapLists) {
      colemak.forward(key);
    }
  },
};
const vForwardFactory = {
  push: function (mapLists) {
    // forward original keys
    for (const key in mapLists) {
      vForward.add(mapLists[key]);
    }
  },
  map: function (mapLists) {
    for (const key in mapLists) {
      vColemak.map(key, mapLists[key]);
    }
  },
  pull: function (mapLists) {
    for (const key in mapLists) {
      vForward.cancel(mapLists[key]);
    }
    for (const key in mapLists) {
      vColemak.forward(key);
    }
  },
};
// TODO: Add more search completion source (with json)
const parseSearchResponse = function (response) {
  const res = JSON.parse(response.text);
  return res.map((r) => r.phrase);
};

const _addSearchAlias = function (
  alias,
  name,
  searchUrl,
  acUrl = "https://duckduckgo.com/ac/?q=",
  searchPrefix = "s",
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
// Shortcut for querySelector
const q = (selector) => document.querySelector(selector);
const qs = (selector) => document.querySelectorAll(selector);
// #endregion

// #region Keymap
// Normal Mode Keymap
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
  gl: "gi", // Focus on first input box
  // t -> Open Link in New Tab
  t: "gf",
  // 缩放
  zu: "zi",
  zo: "ze",
  zz: "zr",
};
// Visual Mode Keymap
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

// All other unmapped keys should be defined here
// TODO: Add more mouse click keymap
api.unmap("gi"); // conflict with `gi` in `mapLists`
api.unmap("C"); // Use `F` instead (Open Link in New Tab)
api.map("g/", "gU"); // Goto Root Domain
// TODO: Add SPC keymap as leader (maybe change `,` to `SPC`)
api.unmap("<space>"); // Leader Key

forwardFactory.pull(mapLists);
vForwardFactory.pull(vMapLists);

api.map("gH", "g/");
// #endregion

// #region Omnibar NOTE: Dosn't work
// api.cmap("<Ctrl-a>", "<Ctrl-ArrowUp>");
// api.cmap("<Ctrl-e>", "<Ctrl-ArrowDown>");
// api.cmap("<Ctrl-f>", "<ArrowRight>");
// api.cmap("<Ctrl-b>", "<ArrowLeft>");
// api.cmap("<Alt-f>", "<Ctrl-ArrowRight>");
// api.cmap("<Alt-b>", "<Ctrl-ArrowLeft>");
// api.cmap("<Ctrl-h>", "<Backspace>");
// api.cmap("<Ctrl-d>", "<Delete>");
// #endregion

// #region Search Alias

const removedSearchAlias = [
  "b", // Baidu
  "d", // DuckDuckGo
  "e", // Wikipedia
  "g", // Google
  "s", // StackOverflow
  "w", // Bing
  "y", // YouTube
];

removedSearchAlias.forEach((alias) => removeSearchAlias(alias));

const searchAliases = [
  ["a2", "AlternativeTo", "https://alternativeto.net/browse/search/?q="],
  ["ap", "APT", "https://packages.ubuntu.com/search?keywords="],
  ["au", "AUR", "https://aur.archlinux.org/packages?K="],
  ["aw", "ArchWiki", "https://wiki.archlinux.org/index.php?search="],
  ["bd", "Baidu", "https://www.baidu.com/s?wd="],
  ["bi", "Bing", "https://www.bing.com/search?q="],
  ["bl", "Bilibili", "https://search.bilibili.com/all?keyword="],
  ["br", "HomeBrew", "https://duckduckgo.com/?q=!brew "],
  ["cg", "ChatGPT", "https://chat.openai.com/?q="],
  ["cr", "Chrome Web Store", "https://chrome.google.com/webstore/search/"],
  ["dd", "DuckDuckGo", "https://duckduckgo.com/?q="],
  ["de", "Thesaurus", "https://www.onelook.com/?w="],
  ["eb", "ebay", "https://www.ebay.co.uk/sch/i.html?kw="],
  ["fe", "Felo", "https://felo.ai/search?q="],
  ["gh", "GitHub", "https://github.com/search?type=repositories&q="],
  ["gg", "Google", "https://www.google.com/search?q="],
  ["mc", "Metacritic", "https://www.metacritic.com/search/"],
  ["ng", "NuGet", "https://www.nuget.org/packages?q="],
  ["np", "npm", "https://www.npmjs.com/search?q="],
  ["pa", "Pacman", "https://archlinux.org/packages/?q="],
  ["pp", "Perplexity", "https://www.perplexity.ai/?q="],
  ["py", "pypi", "https://pypi.org/search/?q="],
  ["re", "Reddit", "https://www.reddit.com/search?q="],
  ["sc", "Scoop", "https://scoop.sh/#/apps?q="],
  ["se", "StackExchange", "https://stackexchange.com/search?q="],
  ["so", "StackOverflow", "https://stackoverflow.com/search?q="],
  ["st", "Steam", "https://store.steampowered.com/search/?term="],
  ["tw", "X", "https://twitter.com/search?q="],
  ["ud", "UrbanDictionary", "https://www.urbandictionary.com/define.php?term="],
  ["wa", "WolframAlpha", "https://www.wolframalpha.com/input/?i="],
  ["wg", "winget", "https://winget.ragerworks.com/search/all/"],
  ["wk", "Wikipedia", "https://en.wikipedia.org/w/index.php?title=Special:Search&search="],
  ["ww", "WantWords", "https://www.shenyandayi.com/wantWordsResult?lang=zh&query="],
  ["yt", "YouTube", "https://www.youtube.com/results?search_query="],
];

// Add all search aliases
searchAliases.forEach(([alias, name, url]) => {
  _addSearchAlias(alias, name, url);
});
// #endregion

// #region Site-specific

// #region chatgpt.com
const chatgptNewChat = function () {
  var btn = q(
    "div.no-draggable:nth-child(3) > span:nth-child(1) > button:nth-child(1)",
  );
  btn.click();
};
const chatgptStartStop = function () {
  var btn = q("button.h-8:nth-child(2)");
  btn.click();
};
mapkey(",n", "New Chat", chatgptNewChat, { domain: /chatgpt.com/ });
mapkey(",s", "Start/Stop Generating", chatgptStartStop, {
  domain: /chatgpt.com/,
});
// #endregion

// #region chat.deepseek.com
mapkey(",s", "Toggle Sidebar", function () {
  var btn = qs("div.ds-icon-button");
  btn[0].click();
}, { domain: /chat.deepseek.com/ });
mapkey(",e", "Edit last input", function () {
  var btn = qs("div.ds-icon-button");
  btn[btn.length - 5].click();
}, { domain: /chat.deepseek.com/ });
mapkey(",y", "Yank last oupput", function () {
  var btn = qs("div.ds-icon-button");
  btn[btn.length - 4].click();
}, { domain: /chat.deepseek.com/ });
mapkey(",r", "Regenerate last output", function () {
  var btn = qs("div.ds-icon-button");
  btn[btn.length - 3].click();
}, { domain: /chat.deepseek.com/ });
mapkey(",n", "New Chat", function () {
  window.location.href = "https://chat.deepseek.com/";
}, { domain: /chat.deepseek.com/ });
mapkey(",t", "Toggle Thinking (R1)", function () {
  var btns = qs("div.ds-button");
  btns[0].click();
}, { domain: /chat.deepseek.com/ });
mapkey(",w", "Toggle Web Search", function () {
  var btns = qs("div.ds-button");
  btns[1].click();
}, { domain: /chat.deepseek.com/ });
// #endregion

// #region app.follow.is
mapkey(",t", "Toggle ", function () {
  var btn = qs("button.no-drag-region");
  btn[btn.length - 4].click();
}, { domain: /app.follow.is/ });

mapkey(",a", "Toggle AI Summary", function () {
  var btn = qs("button.no-drag-region");
  btn[btn.length - 3].click();
}, { domain: /app.follow.is/ });

mapkey(",o", "Toggle Original Website", function () {
  var btn = qs("button.no-drag-region");
  btn[btn.length - 4].click();
}, { domain: /app.follow.is/ });
// #endregion

// #region GitHub
// utils
const gh = {};
gh.repoLink = (owner, repo) => `https://github.com/${owner}/${repo}`;
gh.pageLink = (owner, repo) => `https://${owner}.github.io/${repo}/`;
gh.sourceLink = (owner, repo, path) =>
  `${gh.repoLink(owner, repo)}/tree/${path}`;
gh.rawToSource = (url) => {
  const ps = url.split("/").slice(3);
  return gh.sourceLink(ps[0], ps[1], ps.slice(4).join("/"));
};
// github.com
mapkey(",e", "Use Web Editor", function () {
  const url = new URL(window.location.href);
  url.hostname = "github.dev";
  window.location.href = url.href;
}, { domain: /github.com/ });
mapkey(",E", "Use Web Editor (New Page)", function () {
  const url = new URL(window.location.href);
  url.hostname = "github.dev";
  tabOpenLink(url.href);
}, { domain: /github.com/ });
mapkey(",p", "Switch to GitHub Page", function () {
  href = window.location.href;
  owner = href.split("/")[3];
  repo = href.split("/")[4];
  window.location.href = gh.pageLink(owner, repo);
}, { domain: /github.com/ });
// github.dev
mapkey(",r", "Switch to GitHub Repo", function () {
  const url = new URL(window.location.href);
  url.hostname = "github.com";
  window.location.href = url.href;
}, { domain: /github.dev/ });
// github.io
mapkey(",r", "Switch to GitHub Repo", function () {
  const href = window.location.href;
  owner = href.split("/")[2].split(".")[0];
  repo = href.split("/")[3];
  tabOpenLink(gh.repoLink(owner, repo));
}, { domain: /github.io/ });
mapkey(",R", "Go to GitHub Repo (New tab)", function () {
  const href = window.location.href;
  owner = href.split("/")[2].split(".")[0];
  repo = href.split("/")[3];
  tabOpenLink(gh.repoLink(owner, repo));
}, { domain: /github.io/ });
// raw.githubusercontent.com
mapkey(",r", "Switch to GitHub Repo", function () {
  const url = new URL(window.location.href);
  var owner, repo;
  owner, repo = url.pathname.split("/").slice(1, 3);
  window.location.href = gh.repoLink(owner, repo);
}, { domain: /raw.githubusercontent.com/ });
mapkey(",R", "Switch to GitHub Repo", function () {
  const url = new URL(window.location.href);
  var owner, repo;
  owner, repo = url.pathname.split("/").slice(1, 3);
  tabOpenLink(gh.repoLink(owner, repo));
}, { domain: /raw.githubusercontent.com/ });
mapkey(",s", "Open Source in GitHub", function () {
  window.location.href = gh.rawToSource(window.location.href);
}, { domain: /raw.githubusercontent.com/ });
mapkey(",S", "Open Source in GitHub (New Page)", function () {
  tabOpenLink(gh.rawToSource(window.location.href));
}, { domain: /raw.githubusercontent.com/ });
// #endregion GitHub

// #region perplexity.ai
/**
 * 0 - 网络
 * 1 - 学术
 * 2 - 数学
 * 3 - 写作
 * 4 - 视频
 * 5 - 社交
 */
const perplexityFocusOn = function (n) {
  qs("span.grow button")[0].click();
  setTimeout(() => { // Wait for the DOM to update
    qs("div.shadow-subtle div.group\\/item")[n].click();
  }, 100);
};
unmap("<Ctrl-i>", /perplexity.ai/); // allows to use perplexity web keybindings
mapkey(",b", "Add Perplexity Bookmark", function () {
  //  button.border:nth-child(2)
  var btn = q("button.border:nth-child(2)");
  btn.click();
}, { domain: /perplexity.ai/ });
mapkey(",w", "Toggle Writing/Web Search", function () {
  perplexityFocusOn(3);
}, { domain: /perplexity.ai/ });
mapkey(",s", "Start Generating", function () {
  var btns = qs("span.grow button");
  btns[btns.length - 1].click();
}, { domain: /perplexity.ai/ });
mapkey(",y", "Yank Last Output", function () {
  var toolbars = qs("div.mt-sm");
  var last = toolbars[toolbars.length - 1];
  var btns = last.querySelectorAll("button");
  btns[4].click();
}, { domain: /perplexity.ai/ });
mapkey(",r", "Change model to regenerate last output", function () {
  var toolbars = qs("div.mt-sm");
  var last = toolbars[toolbars.length - 1];
  var btns = last.querySelectorAll("button");
  btns[1].click();
}, { domain: /perplexity.ai/ });
// #endregion

// #region pixiv.net
// Use site-specific paging method
unmap("[[", /pixiv.net/);
unmap("]]", /pixiv.net/);
unmap(",", /pixiv.net/);
const isArtwork = (url) => /pixiv.net\/artworks/.test(url.href)

mapkey("[[", "Previous Page", function () {
  const url = new URL(window.location.href);
  if (url.href === url.origin) {
    return;
  }
  const page = url.searchParams.get("p");
  const newPage = page ? parseInt(page) - 1 : 1;
  url.searchParams.set("p", newPage);
  window.location.href = url.href;
}, { domain: /pixiv.net/ });

mapkey("]]", "Next Page", function () {
  const url = new URL(window.location.href);
  if (url.href === url.origin) {
    return;
  }
  const page = url.searchParams.get("p");
  const newPage = page ? parseInt(page) + 1 : 2;
  url.searchParams.set("p", newPage);
  window.location.href = url.href;
}, { domain: /pixiv.net/ });
mapkey(",b", "Add to [b]ookmark", function () {
  const url = new URL(window.location.href);
  if (!isArtwork(url)) { return; }
  const toolbar = q('section [class$="Toolbar"]')
  toolbar.querySelectorAll("div")[2].querySelector("button").click()
}, { domain: /pixiv.net/ });
mapkey(",B", "Add to private [B]ookmark", function () {
  const url = new URL(window.location.href);
  if (!isArtwork(url)) { return; }
  const toolbar = q('section [class$="Toolbar"]')
  toolbar.querySelectorAll("div")[0].querySelector("button").click()
  setTimeout(() => { // Wait for the DOM to update
    q("div[role=menu]").querySelector("li").click()
  }, 100);
}, { domain: /pixiv.net/ });
mapkey(",v", "Up[v]ote Artwork", function () {
  const url = new URL(window.location.href);
  if (!isArtwork(url)) { return; }
  const toolbar = q('section [class$="Toolbar"]')
  toolbar.querySelectorAll("div")[3].querySelector("button").click()
}, { domain: /pixiv.net/ });
mapkey(",f", "Toggle [f]ollow the author", function () {
  const url = new URL(window.location.href)
  if (!isArtwork(url)) { return; }
  q("aside").querySelector("section").querySelector("button").click()
}, { domain: /pixiv.net/ });
// #endregion


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

// #region Hints
api.Hints.setCharacters("qwfpgarstdcv"); // Left-hand keys
// #endregion
