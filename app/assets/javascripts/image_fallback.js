// Any image that fails to load (e.g. a dead external Pokedex URL) shows a neutral placeholder instead of a blank box.
(function () {
  var PLACEHOLDER = "data:image/svg+xml," + encodeURIComponent(
    '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">' +
    '<circle cx="50" cy="50" r="34" fill="#e6e9f5"/>' +
    '<text x="50" y="62" font-family="sans-serif" font-size="36" font-weight="700" text-anchor="middle" fill="#9ca3af">?</text></svg>');

  // Capture phase: image error events don't bubble.
  document.addEventListener("error", function (event) {
    var img = event.target;
    if (img.tagName !== "IMG" || img.src === PLACEHOLDER || img.hasAttribute("data-preview-img")) return;
    img.src = PLACEHOLDER;
  }, true);
})();
