// Paste this into surfingkeys advanced settings

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
// Settings
settings.language = "zh-CN"	;
settings.showModeStatus = true;
// Colemak hjkl (hnei)
//  map('h', 'h')   // left no change
api.map('n', 'j')   // down
api.vmap('n', 'j')  // down
api.map('e', 'k')   // up
api.vmap('e', 'k')  // up
api.map('i', 'l')   // right
api.vmap('i', 'l')  // right
// DELETED map j -> e : use j to scroll up half page
api.vmap('j', 'e')  // end of word
api.map('k', 'n')   // search next word (Original Position of n)
api.vmap('k', 'n')  // search next word (Original Position of n)
api.map('l', 'i')   // insert mode, similar position to original i
api.vmap('l', 'i')  // insert mode, similar position to original i
api.map('L', 'I')   // insert mode with vim popup, similar pos to I

// Prev/Next Page (WASD-like left-hand navigation)
api.map('A', 'E')
api.map('S', 'R')
//  map('d', 'd') for scroll down half page
api.map('j', 'u') //scrool up half page
api.map('T', 'C') // Open in new tab

// Search Alias
api.addSearchAlias('f', 'Felo', 'https://felo.ai/search?q=', 's', 'https://duckduckgo.com/ac/?q=', function(response) {
    var res = JSON.parse(response.text);
    return res.map(function(r){
        return r.phrase;
    });
});
api.addSearchAlias('p', 'Perplexity', 'https://www.perplexity.ai/?q=', 's', 'https://duckduckgo.com/ac/?q=', function(response) {
    var res = JSON.parse(response.text);
    return res.map(function(r){
        return r.phrase;
    });
});
api.addSearchAlias('r', 'Raindrop', 'https://app.raindrop.io/my/0/', 's', 'https://duckduckgo.com/ac/?q=', function(response) {
    var res = JSON.parse(response.text);
    return res.map(function(r){
        return r.phrase;
    });
});


// Theme  
settings.theme = `
.sk_theme {
    font-family: Input Sans Condensed, Charcoal, sans-serif;
    font-size: 10pt;
    background: #24272e;
    color: #abb2bf;
}
.sk_theme tbody {
    color: #fff;
}
.sk_theme input {
    color: #d0d0d0;
}
.sk_theme .url {
    color: #61afef;
}
.sk_theme .annotation {
    color: #56b6c2;
}
.sk_theme .omnibar_highlight {
    color: #528bff;
}
.sk_theme .omnibar_timestamp {
    color: #e5c07b;
}
.sk_theme .omnibar_visitcount {
    color: #98c379;
}
.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
    background: #303030;
}
.sk_theme #sk_omnibarSearchResult ul li.focused {
    background: #3e4452;
}
#sk_status, #sk_find {
    font-size: 20pt;
}`;
// click `Save` button to make above settings to take effect.</ctrl-i></ctrl-y>