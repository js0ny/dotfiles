// Paste this into surfingkeys advanced settings
// or use:
// Load settings from: https://raw.githubusercontent.com/js0ny/dotfiles/refs/heads/master/tools/browser/surfingkeys.js
// TODO: Visual Mode

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
const forward = {
  add: function (key) { // 转发即将被 unmap 的键
    return api.map(`for${key}`, key)
  },
  cancel: function (key) { // 删除转发生成的键
    api.unmap(`for${key}`)
    api.unmap(key)
  },
  use: function (key) {
    return `for${key}`
  }
}

const colemak = {
  forward: function (key) { // 转发即将被 unmap 的键
    api.map(key, `col${key}`)
    api.unmap(`col${key}`)

  },
  use: function (key) {
    return `col${key}`
  },
  map: function (a, b) {
    api.map(colemak.use(a), forward.use(b))
  }
}

const forwardFactory = {
  push: function (mapLists) { // forward original keys
    for (let key in mapLists) {
      forward.add(mapLists[key])
    }
  },
  map: function (mapLists) {
    for (let key in mapLists) {
      colemak.map(key, mapLists[key])
    }
  },
  pull: function (mapLists) {
    for (let key in mapLists) {
      forward.cancel(mapLists[key])
    }
    for (let key in mapLists) {
      colemak.forward(key)
    }
  }
}
// #endregion
// #region Keymap
const mapLists = {
  /// scroll page
  // Arrow
  'n': 'j',
  'e': 'k',
  'i': 'l',
  // l <-> i
  'l': 'i',
  'L': 'I',
  // k <-> n
  'k': 'n',
  'K': 'N',
  // j <-> e
  'j': 'e',
  // PrevTab < H - I > NextTab
  'H': 'E',
  'I': 'R',
  // E,N -> Up/Down HalfPage
  'N': 'd',
  'E': 'e',
  // F -> Open Link in New Tab
  'F': 'af',
  // oH -> Tab History
  'oH': 'H',
  // gh/gi -> Prev/Next History
  'gh': 'S',
  'gi': 'D',
  // t -> Open Link in New Tab
  't': 'gf',
  // 缩放
  'zu': 'zi',
  'zo': 'ze',
  'zz': 'zr',
}

const vmapLists = {
  'n': 'j',
  'N': 'J',
  'e': 'k',
  'E': 'K',
  'i': 'l',
  'I': 'L',
  'j': 'e',
  'J': 'E',
  'k': 'n',
  'K': 'N',
}

forwardFactory.push(mapLists)
forwardFactory.map(mapLists)
// 鼠标点击
api.unmap('gi')
api.unmap('[[')
api.unmap(']]')
api.unmap(';m')
api.unmap(';fs')
api.unmap('O')
api.unmap('C')
api.map('g/', 'gU') // Goto Root Domain
forwardFactory.pull(mapLists)
// #endregion


// #region Search Alias
api.addSearchAlias('f', 'Felo', 'https://felo.ai/search?q=', 's', 'https://duckduckgo.com/ac/?q=', function (response) {
  var res = JSON.parse(response.text);
  return res.map(function (r) {
    return r.phrase;
  });
});
api.addSearchAlias('p', 'Perplexity', 'https://www.perplexity.ai/?q=', 's', 'https://duckduckgo.com/ac/?q=', function (response) {
  var res = JSON.parse(response.text);
  return res.map(function (r) {
    return r.phrase;
  });
});
api.addSearchAlias('r', 'Raindrop', 'https://app.raindrop.io/my/0/', 's', 'https://duckduckgo.com/ac/?q=', function (response) {
  var res = JSON.parse(response.text);
  return res.map(function (r) {
    return r.phrase;
  });
});
api.addSearchAlias('c', 'ChatGPT', 'https://chatgpt.com/?q=', 's', 'https://duckduckgo.com/ac/?q=', function (response) {
  var res = JSON.parse(response.text);
  return res.map(function (r) {
    return r.phrase;
  });
});
// #endregion

// #region Site-specific

// chatgpt.com
api.unmap('t', /chatgpt.com/);
api.mapkey('tn', 'New Chat', function () {
  var btn = document.querySelector('div.no-draggable:nth-child(3) > span:nth-child(1) > button:nth-child(1)')
  btn.click();
}, { domain: /chatgpt.com/ });
api.mapkey('ts', 'Start/Stop Generating', function () {
  var btn = document.querySelector('button.h-8:nth-child(2)');
  btn.click();
}, { domain: /chatgpt.com/ });
api.mapkey('ts', 'Start/Stop Generating', function () {
  var btn = document.querySelector('button.h-8:nth-child(2)');
  btn.click();
}, { domain: /chatgpt.com/ });
api.mapkey('S', 'Start/Stop Generating', function () {
  var btn = document.querySelector('button.h-8:nth-child(2)');
  btn.click();
}, { domain: /chatgpt.com/ });
//api.mapkey('tm', 'Toggle Model', function () {
//  var btn = document.querySelector('#radix -\: r2i\:');
//  btn.click();
//}, { domain: /chatgpt.com/ });

// #endregion

// #region Theme
//  reference to https://github.com/Foldex/surfingkeys-config
// api.Hints.style('border: solid 2px #4C566A; color:#A3BE8C; background: initial; background-color: #3B4252;');
// api.Hints.style("border: solid 2px #4C566A !important; padding: 1px !important; color: #E5E9F0 !important; background: #3B4252 !important;", "text");
// api.Visual.style('marks', 'background-color: #A3BE8C99;');
// api.Visual.style('cursor', 'background-color: #88C0D0;');
// settings.theme = `
// fg: #E5E9F0;
// bg: #3B4252;
// bg-dark: #2E3440;
// border: #4C566A;
// main-fg: #88C0D0;
// accent-fg: #A3BE8C;
// info-fg: #5E81AC;
// select: #4C566A;
// /* ---------- Generic ---------- */
// .sk_theme {
// background: var(--bg);
// color: var(--fg);
//   background-color: var(--bg);
//   border-color: var(--border);
//   font-family: var(--font);
//   font-size: var(--font-size);
//   font-weight: var(--font-weight);
// }

// input {
//   font-family: var(--font);
//   font-weight: var(--font-weight);
// }

// .sk_theme tbody {
//   color: var(--fg);
// }

// .sk_theme input {
//   color: var(--fg);
// }

// /* Hints */
// #sk_hints .begin {
//   color: var(--accent-fg) !important;
// }

// #sk_tabs .sk_tab {
//   background: var(--bg-dark);
//   border: 1px solid var(--border);
// }

// #sk_tabs .sk_tab_title {
//   color: var(--fg);
// }

// #sk_tabs .sk_tab_url {
//   color: var(--main-fg);
// }

// #sk_tabs .sk_tab_hint {
//   background: var(--bg);
//   border: 1px solid var(--border);
//   color: var(--accent-fg);
// }

// .sk_theme #sk_frame {
//   background: var(--bg);
//   opacity: 0.2;
//   color: var(--accent-fg);
// }

// /* ---------- Omnibar ---------- */
// /* Uncomment this and use settings.omnibarPosition = 'bottom' for Pentadactyl/Tridactyl style bottom bar */
// /* .sk_theme#sk_omnibar {
//   width: 100%;
//   left: 0;
// } */

// .sk_theme .title {
//   color: var(--accent-fg);
// }

// .sk_theme .url {
//   color: var(--main-fg);
// }

// .sk_theme .annotation {
//   color: var(--accent-fg);
// }

// .sk_theme .omnibar_highlight {
//   color: var(--accent-fg);
// }

// .sk_theme .omnibar_timestamp {
//   color: var(--info-fg);
// }

// .sk_theme .omnibar_visitcount {
//   color: var(--accent-fg);
// }

// .sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
//   background: var(--bg-dark);
// }

// .sk_theme #sk_omnibarSearchResult ul li.focused {
//   background: var(--border);
// }

// .sk_theme #sk_omnibarSearchArea {
//   border-top-color: var(--border);
//   border-bottom-color: var(--border);
// }

// .sk_theme #sk_omnibarSearchArea input,
// .sk_theme #sk_omnibarSearchArea span {
//   font-size: var(--font-size);
// }

// .sk_theme .separator {
//   color: var(--accent-fg);
// }

// /* ---------- Popup Notification Banner ---------- */
// #sk_banner {
//   font-family: var(--font);
//   font-size: var(--font-size);
//   font-weight: var(--font-weight);
//   background: var(--bg);
//   border-color: var(--border);
//   color: var(--fg);
//   opacity: 0.9;
// }

// /* ---------- Popup Keys ---------- */
// #sk_keystroke {
//   background-color: var(--bg);
// }

// .sk_theme kbd .candidates {
//   color: var(--info-fg);
// }

// .sk_theme span.annotation {
//   color: var(--accent-fg);
// }

// /* ---------- Popup Translation Bubble ---------- */
// #sk_bubble {
//   background-color: var(--bg) !important;
//   color: var(--fg) !important;
//   border-color: var(--border) !important;
// }

// #sk_bubble * {
//   color: var(--fg) !important;
// }

// #sk_bubble div.sk_arrow div:nth-of-type(1) {
//   border-top-color: var(--border) !important;
//   border-bottom-color: var(--border) !important;
// }

// #sk_bubble div.sk_arrow div:nth-of-type(2) {
//   border-top-color: var(--bg) !important;
//   border-bottom-color: var(--bg) !important;
// }

// /* ---------- Search ---------- */
// #sk_status,
// #sk_find {
//   font-size: var(--font-size);
//   border-color: var(--border);
// }

// .sk_theme kbd {
//   background: var(--bg-dark);
//   border-color: var(--border);
//   box-shadow: none;
//   color: var(--fg);
// }

// .sk_theme .feature_name span {
//   color: var(--main-fg);
// }

// /* ---------- ACE Editor ---------- */
// #sk_editor {
//   background: var(--bg-dark) !important;
//   height: 50% !important;
//   /* Remove this to restore the default editor size */
// }

// .ace_dialog-bottom {
//   border-top: 1px solid var(--bg) !important;
// }

// .ace-chrome .ace_print-margin,
// .ace_gutter,
// .ace_gutter-cell,
// .ace_dialog {
//   background: var(--bg) !important;
// }

// .ace-chrome {
//   color: var(--fg) !important;
// }

// .ace_gutter,
// .ace_dialog {
//   color: var(--fg) !important;
// }

// .ace_cursor {
//   color: var(--fg) !important;
// }

// .normal-mode .ace_cursor {
//   background-color: var(--fg) !important;
//   border: var(--fg) !important;
//   opacity: 0.7 !important;
// }

// .ace_marker-layer .ace_selection {
//   background: var(--select) !important;
// }

// .ace_editor,
// .ace_dialog span,
// .ace_dialog input {
//   font-family: var(--font);
//   font-size: var(--font-size);
//   font-weight: var(--font-weight);
// }`;
// click `Save` button to make above settings to take effect.</ctrl-i></ctrl-y>
// #endregion
