Item: 
```lua
['book'] = {
    ['name'] = 'book',
    ['label'] = 'Book',
    ['weight'] = 100,
    ['type'] = 'item',
    ['image'] = 'book.png',
    ['unique'] = true,
    ['useable'] = true,
    ['shouldClose'] = true,
    ['combinable'] = nil,
    ['description'] = 'An empty book that can store images as pages.'
},
```

Metadata.js:
```js
if (itemData.name == "book" && itemData.info.title) {
    const info = itemData.info || {};
    const title = info.title || label || 'Book';
    let pagesArr = [];
    try { pagesArr = JSON.parse(info.pages || '[]'); } catch (_) { pagesArr = Array.isArray(info.pages) ? info.pages : []; }
    const pagesCount = Array.isArray(pagesArr) ? pagesArr.length : 0;
    const author = info.author || 'Unknown';

    $(".item-info-title").html(`<p>${title}</p>`);

    const rows = [
        `<p><strong>Title: </strong><span>${title}</span></p>`,
        `<p><strong>Author: </strong><span>${author}</span></p>`,
        `<p><strong>Pages: </strong><span>${pagesCount}</span></p>`
    ];
    $(".item-info-description").html(rows.join(''));
}
```