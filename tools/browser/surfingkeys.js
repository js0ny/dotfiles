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
api.mapkey('an', 'New Chat', function () {
  var btn = document.querySelector('div.no-draggable:nth-child(3) > span:nth-child(1) > button:nth-child(1)')
  btn.click();
}, { domain: /chatgpt.com/ });
api.mapkey('as', 'Start/Stop Generating', function () {
  var btn = document.querySelector('button.h-8:nth-child(2)');
  btn.click();
}, { domain: /chatgpt.com/ });
api.mapkey('as', 'Start/Stop Generating', function () {
  var btn = document.querySelector('button.h-8:nth-child(2)');
  btn.click();
}, { domain: /chatgpt.com/ });
//api.mapkey('tm', 'Toggle Model', function () {
//  var btn = document.querySelector('#radix -\: r2i\:');
//  btn.click();
//}, { domain: /chatgpt.com/ });
// perplexity.ai
api.unmap('<Ctrl-i>', /perplexity.ai/);


// #endregion
