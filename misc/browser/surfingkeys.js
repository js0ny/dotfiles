// vim:foldmethod=marker:foldmarker=#region,#endregion:foldlevel=0
// Paste this into surfingkeys advanced settings
// or use:
// Load settings from: https://raw.githubusercontent.com/js0ny/dotfiles/refs/heads/master/misc/browser/surfingkeys.js
// Browse to Extension > Surfingkeys > Allow access to file URLs to enable local file access
// Windows: file:///C:/Users/username/.dotfiles/tools/browser/surfingkeys.js
// Linux: file:///home/username/.dotfiles/tools/browser/surfingkeys.js
// macOS: file:///Users/username/.dotfiles/tools/browser/surfingkeys.js

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
    for (const key in mapLists) {
      // `const` better than `let`
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
  // Prev History < H - L > Next History
  H: "S",
  L: "D",
  // J,K -> Up/Down HalfPage
  // J: "d",
  // K: "e",
  // F -> Open Link in New Tab
  F: "af",
  // oH -> Tab History
  oH: "H",
  // gh/gl -> Prev/Next Tab
  gh: "E",
  gl: "R",
  "<Alt-h>": "E",
  "<Alt-l>": "R",
  gi: "i", // Use `gl` to search and focus on input box
  i: "gi",
  // t -> Open Link in New Tab
  t: "gf",
  // 缩放
  zu: "zi",
  zo: "ze",
  zz: "zr",
};

forwardFactory.push(mapLists);
forwardFactory.map(mapLists);

// vForwardFactory.push(vMapLists);
// vForwardFactory.map(vMapLists);

// All other unmapped keys should be defined here
// TODO: Add more mouse click keymap
// api.unmap("gi"); // conflict with `gi` in `mapLists`
api.unmap("C"); // Use `F` instead (Open Link in New Tab)
api.map("g/", "gU"); // Goto Root Domain
// TODO: Add SPC keymap as leader (maybe change `,` to `SPC`)
api.unmap("<space>"); // Leader Key

api.map("'","om"); // Use ' to search vim quickmarks

forwardFactory.pull(mapLists);
// vForwardFactory.pull(vMapLists);

api.map("gH", "g/");
api.map("J", "d");
api.map("K", "e");

map('>', '>>');
map('<', '<<');

// #endregion

// #region Omnibar NOTE: Dosn't work
api.cmap("<Ctrl-a>", "<Ctrl-ArrowUp>");
api.cmap("<Ctrl-e>", "<Ctrl-ArrowDown>");
api.cmap("<Ctrl-f>", "<ArrowRight>");
api.cmap("<Ctrl-b>", "<ArrowLeft>");
api.cmap("<Alt-f>", "<Ctrl-ArrowRight>");
api.cmap("<Alt-b>", "<Ctrl-ArrowLeft>");
api.cmap("<Ctrl-h>", "<Backspace>");
api.cmap("<Ctrl-d>", "<Delete>");
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
  ["nx", "NixPackages", "https://search.nixos.org/packages?query="],
  ["no", "NixOptions", "https://search.nixos.org/options?query="],
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
  [
    "wk",
    "Wikipedia",
    "https://en.wikipedia.org/w/index.php?title=Special:Search&search=",
  ],
  [
    "ww",
    "WantWords",
    "https://www.shenyandayi.com/wantWordsResult?lang=zh&query=",
  ],
  ["yt", "YouTube", "https://www.youtube.com/results?search_query="],
  ["o", "SearXNG", "https://searx.js0ny.net?q="]
];

api.unmap("on");

// Add all search aliases
searchAliases.forEach(([alias, name, url]) => {
  _addSearchAlias(alias, name, url);
});
// #endregion

// #region Site-specific

// This is a global keymap
mapkey("yY", "yank link without parameter", function () {
  const url = new URL(window.location.href);
  Clipboard.write(url.origin + url.pathname);
});

unmap("yma");
unmap("ymc");
unmap("ymv");

mapkey("ym", "yank link as markdown", function () {
  const url = new URL(window.location.href);
  const title = document.title;
  Clipboard.write(`[${title}](${url.origin + url.pathname})`);
});

// #region bilibili.com
mapkey(
  ",n",
  "[n]ext Video",
  function () {
    window.location.href = q("div.next-play").querySelector("a").href;
  },
  { domain: /bilibili.com/ },
);
// #endregion

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
mapkey(
  ",s",
  "Toggle Sidebar",
  function () {
    var btn = qs("div.ds-icon-button");
    btn[0].click();
  },
  { domain: /chat.deepseek.com/ },
);
mapkey(
  ",e",
  "[e]dit last input",
  function () {
    var btn = qs("div.ds-icon-button");
    btn[btn.length - 5].click();
  },
  { domain: /chat.deepseek.com/ },
);
mapkey(
  ",y",
  "[y]ank last oupput",
  function () {
    var btn = qs("div.ds-icon-button");
    btn[btn.length - 4].click();
  },
  { domain: /chat.deepseek.com/ },
);
mapkey(
  ",r",
  "[r]egenerate last output",
  function () {
    var btn = qs("div.ds-icon-button");
    btn[btn.length - 3].click();
  },
  { domain: /chat.deepseek.com/ },
);
mapkey(
  ",n",
  "[n]ew Chat",
  function () {
    window.location.href = "https://chat.deepseek.com/";
  },
  { domain: /chat.deepseek.com/ },
);
mapkey(
  ",t",
  "Toggle co[t](R1)",
  function () {
    var btns = qs("div.ds-button");
    btns[0].click();
  },
  { domain: /chat.deepseek.com/ },
);
mapkey(
  ",w",
  "Toggle [w]eb Search",
  function () {
    var btns = qs("div.ds-button");
    btns[1].click();
  },
  { domain: /chat.deepseek.com/ },
);
// #endregion

//#region dropbox.com
//https://www.dropbox.com/scl/fi/u58c2qmqbwq672y3hwmfn/setup.sh?rlkey=d3figouv5eqk1xfwdtyzfr7ua&e=1&st=ehttmy2r&dl=0
//https://dl.dropboxusercontent.com/scl/fi/u58c2qmqbwq672y3hwmfn/setup.sh?rlkey=d3figouv5eqk1xfwdtyzfr7ua&e=1&st=ehttmy2r
mapkey(
  ",r",
  "Extract [r]aw link",
  function () {
    const url = new URL(window.location.href);
    if (url.href.endsWith("&dl=0")) {
      url.searchParams.delete("dl");
      url.hostname = "dl.dropboxusercontent.com";
      Clipboard.write(url.href);
    }
  },
  { domain: /dropbox.com/ },
);
mapkey(
  ",d",
  "Extract [d]ownload link",
  function () {
    const url = new URL(window.location.href);
    if (url.href.endsWith("&dl=0")) {
      url.searchParams.set("dl", "1");
      Clipboard.write(url.href);
    }
  },
  { domain: /dropbox.com/ },
);
//#endregion

// #region app.follow.is
mapkey(
  ",t",
  "Toggle ",
  function () {
    var btn = qs("button.no-drag-region");
    btn[btn.length - 4].click();
  },
  { domain: /app.follow.is/ },
);

mapkey(
  ",a",
  "Toggle AI Summary",
  function () {
    var btn = qs("button.no-drag-region");
    btn[btn.length - 3].click();
  },
  { domain: /app.follow.is/ },
);

mapkey(
  ",o",
  "Toggle Original Website",
  function () {
    var btn = qs("button.no-drag-region");
    btn[btn.length - 4].click();
  },
  { domain: /app.follow.is/ },
);
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
mapkey(
  ",e",
  "Use Web Editor",
  function () {
    const url = new URL(window.location.href);
    url.hostname = "github.dev";
    window.location.href = url.href;
  },
  { domain: /github.com/ },
);
mapkey(
  ",E",
  "Use Web Editor (New Page)",
  function () {
    const url = new URL(window.location.href);
    url.hostname = "github.dev";
    tabOpenLink(url.href);
  },
  { domain: /github.com/ },
);
mapkey(
  ",p",
  "Switch to GitHub Page",
  function () {
    href = window.location.href;
    owner = href.split("/")[3];
    repo = href.split("/")[4];
    window.location.href = gh.pageLink(owner, repo);
  },
  { domain: /github.com/ },
);
/// This might be useful for Vim plugins
mapkey(
  ",y",
  "[y]ank short refeference owner/repo",
  function () {
    const href = window.location.href;
    owner = href.split("/")[3];
    repo = href.split("/")[4];
    Clipboard.write(`${owner}/${repo}`);
  },
  { domain: /github.com/ },
);
// github.dev
mapkey(
  ",r",
  "Switch to GitHub Repo",
  function () {
    const url = new URL(window.location.href);
    url.hostname = "github.com";
    window.location.href = url.href;
  },
  { domain: /github.dev/ },
);
// github.io
mapkey(
  ",r",
  "Switch to GitHub Repo",
  function () {
    const href = window.location.href;
    owner = href.split("/")[2].split(".")[0];
    repo = href.split("/")[3];
    tabOpenLink(gh.repoLink(owner, repo));
  },
  { domain: /github.io/ },
);
mapkey(
  ",R",
  "Go to GitHub Repo (New tab)",
  function () {
    const href = window.location.href;
    owner = href.split("/")[2].split(".")[0];
    repo = href.split("/")[3];
    tabOpenLink(gh.repoLink(owner, repo));
  },
  { domain: /github.io/ },
);
// raw.githubusercontent.com
mapkey(
  ",r",
  "Switch to GitHub Repo",
  function () {
    const url = new URL(window.location.href);
    var owner, repo;
    (owner, (repo = url.pathname.split("/").slice(1, 3)));
    window.location.href = gh.repoLink(owner, repo);
  },
  { domain: /raw.githubusercontent.com/ },
);
mapkey(
  ",R",
  "Switch to GitHub Repo",
  function () {
    const url = new URL(window.location.href);
    var owner, repo;
    (owner, (repo = url.pathname.split("/").slice(1, 3)));
    tabOpenLink(gh.repoLink(owner, repo));
  },
  { domain: /raw.githubusercontent.com/ },
);
mapkey(
  ",s",
  "Open Source in GitHub",
  function () {
    window.location.href = gh.rawToSource(window.location.href);
  },
  { domain: /raw.githubusercontent.com/ },
);
mapkey(
  ",S",
  "Open Source in GitHub (New Page)",
  function () {
    tabOpenLink(gh.rawToSource(window.location.href));
  },
  { domain: /raw.githubusercontent.com/ },
);
// #endregion GitHub

//#region app.microsoft.com
// https://apps.microsoft.com/detail/9nl6kd1h33v3?hl=en-GB&gl=GB
// This is useful in `winget` (Windows Package Manager)
mapkey(
  ",y",
  "[y]ank app id",
  function () {
    const url = new URL(window.location.href);
    const id = url.pathname.split("/")[2];
    Clipboard.write(id);
  },
  { domain: /apps.microsoft.com/ },
);
//#endregion

// #region perplexity.ai
/**
 * 0 - 网络
 * 1 - 学术
 * 2 - 社交
 */
unmap("<Ctrl-i>", /perplexity.ai/); // allows to use perplexity web keybindings
mapkey(
  ",b",
  "Add Perplexity [b]ookmark",
  function () {
    //  button.border:nth-child(2)
    q("div.sticky.left-0").querySelectorAll("button")[2].click();
  },
  { domain: /perplexity.ai/ },
);
mapkey(
  ",M",
  "Toggle [M]odel switching",
  function () {
    q("div.rounded-md").querySelectorAll("span")[2].click();
    //setTimeout(() => {
    //  // Wait for the DOM to update
    //  qs("div.shadow-subtle div.group\\/item")[0].click();
    //}, 100);
  },
  { domain: /perplexity.ai/ },
);
mapkey(
  ",m",
  "Toggle default [m]odel (Claude 3.7 Sonnet)",
  function () {
    q("div.rounded-md").querySelectorAll("span")[1].click();
    setTimeout(() => {
      // Wait for the DOM to update
      qs("div.shadow-subtle div.group\\/item")[3].click();
    }, 100);
  },
  { domain: /perplexity.ai/ },
);
mapkey(
  ",w",
  "Toggle [w]riting/[w]eb Search",
  function () {
    q("div.rounded-md").querySelectorAll("span")[2].click();
    setTimeout(() => {
      // Wait for the DOM to update
      qs("div.shadow-subtle div.group\\/item")[0].click();
    }, 100);
  },
  { domain: /perplexity.ai/ },
);
mapkey(
  ",s",
  "[s]tart Generating",
  function () {
    var btns = qs("span.grow button");
    btns[btns.length - 1].click();
  },
  { domain: /perplexity.ai/ },
);
mapkey(
  ",y",
  "[y]ank Last Output",
  function () {
    var toolbars = qs("div.mt-sm");
    var last = toolbars[toolbars.length - 1];
    var btns = last.querySelectorAll("button");
    btns[5].click();
  },
  { domain: /perplexity.ai/ },
);
mapkey(
  ",R",
  "Change model to [R]egenerate last output",
  function () {
    var toolbars = qs("div.mt-sm");
    var last = toolbars[toolbars.length - 1];
    var btns = last.querySelectorAll("button");
    btns[1].click();
  },
  { domain: /perplexity.ai/ },
);
mapkey(
  ",r",
  "Toggle [r]easoning",
  function () {
    q("div.rounded-md").querySelectorAll("span")[0].click();
    setTimeout(() => {
      // Wait for the DOM to update
      qs("div.shadow-subtle div.group\\/item")[2].click();
    }, 100);
  },
  { domain: /perplexity.ai/ },
);
// #endregion

// #region sspai.com
unmap("[[", /sspai.com/);
unmap("]]", /sspai.com/);
unmap(",", /sspai.com/);
mapkey(
  "[[",
  "Previous Page",
  function () {
    q("button.btn-prev").click();
  },
  { domain: /sspai.com/ },
);
mapkey(
  "]]",
  "Next Page",
  function () {
    q("button.btn-next").click();
  },
  { domain: /sspai.com/ },
);

// #endregion

// #region pixiv.net
// Use site-specific paging method
unmap("[[", /pixiv.net/);
unmap("]]", /pixiv.net/);
unmap(",", /pixiv.net/);
const isArtwork = (url) => /pixiv.net\/artworks/.test(url.href);

mapkey(
  "[[",
  "Previous Page",
  function () {
    const url = new URL(window.location.href);
    if (url.href === url.origin) {
      return;
    }
    const page = url.searchParams.get("p");
    const newPage = page ? parseInt(page) - 1 : 1;
    url.searchParams.set("p", newPage);
    window.location.href = url.href;
  },
  { domain: /pixiv.net/ },
);

mapkey(
  "]]",
  "Next Page",
  function () {
    const url = new URL(window.location.href);
    if (url.href === url.origin) {
      return;
    }
    const page = url.searchParams.get("p");
    const newPage = page ? parseInt(page) + 1 : 2;
    url.searchParams.set("p", newPage);
    window.location.href = url.href;
  },
  { domain: /pixiv.net/ },
);
mapkey(
  ",b",
  "Add to [b]ookmark",
  function () {
    const url = new URL(window.location.href);
    if (!isArtwork(url)) {
      return;
    }
    const toolbar = q('section [class$="Toolbar"]');
    toolbar.querySelectorAll("div")[2].querySelector("button").click();
  },
  { domain: /pixiv.net/ },
);
mapkey(
  ",B",
  "Add to private [B]ookmark",
  function () {
    const url = new URL(window.location.href);
    if (!isArtwork(url)) {
      return;
    }
    const toolbar = q('section [class$="Toolbar"]');
    toolbar.querySelectorAll("div")[0].querySelector("button").click();
    setTimeout(() => {
      // Wait for the DOM to update
      q("div[role=menu]").querySelector("li").click();
    }, 100);
  },
  { domain: /pixiv.net/ },
);
mapkey(
  ",v",
  "Up[v]ote Artwork",
  function () {
    const url = new URL(window.location.href);
    if (!isArtwork(url)) {
      return;
    }
    const toolbar = q('section [class$="Toolbar"]');
    toolbar.querySelectorAll("div")[3].querySelector("button").click();
  },
  { domain: /pixiv.net/ },
);
mapkey(
  ",f",
  "Toggle [f]ollow the author",
  function () {
    const url = new URL(window.location.href);
    if (!isArtwork(url)) {
      return;
    }
    q("aside").querySelector("section").querySelector("button").click();
  },
  { domain: /pixiv.net/ },
);
// #endregion

// #region youtube.com
mapkey(
  ",n",
  "[n]ext Video",
  function () {
    window.location.href = q("ytd-compact-video-renderer").querySelector(
      "a",
    ).href;
  },
  { domain: /youtube.com/ },
);

mapkey(
  ",v",
  "Up[v]ote Video",
  function () {
    qs("like-button-view-model")[0].querySelector("button").click();
  },
  { domain: /youtube.com/ },
);

mapkey(
  ",V",
  "Down[v]ote Video",
  function () {
    qs("dislike-button-view-model")[0].querySelector("button").click();
  },
  { domain: /youtube.com/ },
);
// class="ytp-subtitles-button ytp-button"
mapkey(
  ",c",
  "toggle [c]aptions",
  function () {
    q("button.ytp-subtitles-button").click();
  },
  { domain: /youtube.com/ },
);
// #endregion

//#region zhihu.com
mapkey(
  ",d",
  "Toggle [d]ark mode",
  function () {
    const url = new URL(window.location.href);
    if (url.searchParams.get("theme") === "dark") {
      url.searchParams.set("theme", "light");
    } else {
      url.searchParams.set("theme", "dark");
    }
    window.location.href = url.href;
  },
  { domain: /zhihu.com/ },
);
//#endregion
// #endregion

// #region ACE Editor
addVimMapKey(
  {
    keys: "H",
    type: "keyToKey",
    toKeys: "^",
  },
  {
    keys: "L",
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
api.Hints.setCharacters("qwertasdfgzx"); // Left-hand keys
// #endregion

// #region Theming
// Reference: https://github.com/Foldex/surfingkeys-config
Hints.style('border: solid 2px #373B41; color:#52C196; background: initial; background-color: #1D1F21;');
Hints.style("border: solid 2px #373B41 !important; padding: 1px !important; color: #C5C8C6 !important; background: #1D1F21 !important;", "text");
Visual.style('marks', 'background-color: #52C19699;');
Visual.style('cursor', 'background-color: #81A2BE;');

settings.theme = `
/* Edit these variables for easy theme making */
:root {
  /* Font */
  --font: 'Maple Mono NF CN', 'Source Code Pro', Ubuntu, sans;
  --font-size: 12;
  --font-weight: bold;

  /* -------------- */
  /* --- THEMES --- */
  /* -------------- */

  /* -------------------- */
  /* -- Tomorrow Night -- */
  /* -------------------- */
  --fg: #C5C8C6;
  --bg: #282A2E;
  --bg-dark: #1D1F21;
  --border: #373b41;
  --main-fg: #81A2BE;
  --accent-fg: #52C196;
  --info-fg: #AC7BBA;
  --select: #585858;
  /* ---------- Generic ---------- */
.sk_theme {
background: var(--bg);
color: var(--fg);
  background-color: var(--bg);
  border-color: var(--border);
  font-family: var(--font);
  font-size: var(--font-size);
  font-weight: var(--font-weight);
}

input {
  font-family: var(--font);
  font-weight: var(--font-weight);
}

.sk_theme tbody {
  color: var(--fg);
}

.sk_theme input {
  color: var(--fg);
}

/* Hints */
#sk_hints .begin {
  color: var(--accent-fg) !important;
}

#sk_tabs .sk_tab {
  background: var(--bg-dark);
  border: 1px solid var(--border);
}

#sk_tabs .sk_tab_title {
  color: var(--fg);
}

#sk_tabs .sk_tab_url {
  color: var(--main-fg);
}

#sk_tabs .sk_tab_hint {
  background: var(--bg);
  border: 1px solid var(--border);
  color: var(--accent-fg);
}

.sk_theme #sk_frame {
  background: var(--bg);
  opacity: 0.2;
  color: var(--accent-fg);
}

/* ---------- Omnibar ---------- */
/* Uncomment this and use settings.omnibarPosition = 'bottom' for Pentadactyl/Tridactyl style bottom bar */
/* .sk_theme#sk_omnibar {
  width: 100%;
  left: 0;
} */

.sk_theme .title {
  color: var(--accent-fg);
}

.sk_theme .url {
  color: var(--main-fg);
}

.sk_theme .annotation {
  color: var(--accent-fg);
}

.sk_theme .omnibar_highlight {
  color: var(--accent-fg);
}

.sk_theme .omnibar_timestamp {
  color: var(--info-fg);
}

.sk_theme .omnibar_visitcount {
  color: var(--accent-fg);
}

.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
  background: var(--bg-dark);
}

.sk_theme #sk_omnibarSearchResult ul li.focused {
  background: var(--border);
}

.sk_theme #sk_omnibarSearchArea {
  border-top-color: var(--border);
  border-bottom-color: var(--border);
}

.sk_theme #sk_omnibarSearchArea input,
.sk_theme #sk_omnibarSearchArea span {
  font-size: var(--font-size);
}

.sk_theme .separator {
  color: var(--accent-fg);
}

/* ---------- Popup Notification Banner ---------- */
#sk_banner {
  font-family: var(--font);
  font-size: var(--font-size);
  font-weight: var(--font-weight);
  background: var(--bg);
  border-color: var(--border);
  color: var(--fg);
  opacity: 0.9;
}

/* ---------- Popup Keys ---------- */
#sk_keystroke {
  background-color: var(--bg);
}

.sk_theme kbd .candidates {
  color: var(--info-fg);
}

.sk_theme span.annotation {
  color: var(--accent-fg);
}

/* ---------- Popup Translation Bubble ---------- */
#sk_bubble {
  background-color: var(--bg) !important;
  color: var(--fg) !important;
  border-color: var(--border) !important;
}

#sk_bubble * {
  color: var(--fg) !important;
}

#sk_bubble div.sk_arrow div:nth-of-type(1) {
  border-top-color: var(--border) !important;
  border-bottom-color: var(--border) !important;
}

#sk_bubble div.sk_arrow div:nth-of-type(2) {
  border-top-color: var(--bg) !important;
  border-bottom-color: var(--bg) !important;
}

/* ---------- Search ---------- */
#sk_status,
#sk_find {
  font-size: var(--font-size);
  border-color: var(--border);
}

.sk_theme kbd {
  background: var(--bg-dark);
  border-color: var(--border);
  box-shadow: none;
  color: var(--fg);
}

.sk_theme .feature_name span {
  color: var(--main-fg);
}

/* ---------- ACE Editor ---------- */
#sk_editor {
  background: var(--bg-dark) !important;
  height: 50% !important;
  /* Remove this to restore the default editor size */
}

.ace_dialog-bottom {
  border-top: 1px solid var(--bg) !important;
}

.ace-chrome .ace_print-margin,
.ace_gutter,
.ace_gutter-cell,
.ace_dialog {
  background: var(--bg) !important;
}

.ace-chrome {
  color: var(--fg) !important;
}

.ace_gutter,
.ace_dialog {
  color: var(--fg) !important;
}

.ace_cursor {
  color: var(--fg) !important;
}

.normal-mode .ace_cursor {
  background-color: var(--fg) !important;
  border: var(--fg) !important;
  opacity: 0.7 !important;
}

.ace_marker-layer .ace_selection {
  background: var(--select) !important;
}

.ace_editor,
.ace_dialog span,
.ace_dialog input {
  font-family: var(--font);
  font-size: var(--font-size);
  font-weight: var(--font-weight);
}
`;
//#endregion
