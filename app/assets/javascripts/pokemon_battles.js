// New battle form: a Pokemon picked on one side disappears from the other side's select,
// and each side previews the picked Pokemon.
(function () {
  var SELECTOR = "select[data-battle-pick]";

  function syncBattlePicks() {
    var selects = Array.prototype.slice.call(document.querySelectorAll(SELECTOR));
    selects.forEach(function (select) {
      var taken = selects.filter(function (other) { return other !== select && other.value; })
                         .map(function (other) { return other.value; });
      Array.prototype.forEach.call(select.options, function (option) {
        if (!option.value) return; // the placeholder stays as it is
        var isTaken = taken.indexOf(option.value) !== -1;
        option.hidden = isTaken;
        option.disabled = isTaken; // Safari ignores hidden on <option>, disabled still blocks picking it
      });
      updatePreview(select);
    });
  }

  // Swap the card icon for the picked Pokemon's image and element badge.
  function updatePreview(select) {
    var box = document.querySelector('[data-preview-for="' + select.name + '"]');
    var typeBox = document.querySelector('[data-preview-type="' + select.name + '"]');
    if (!box || !typeBox) return;
    var option = select.selectedOptions[0];
    var image = option && option.value ? option.dataset.image : null;
    var img = box.querySelector("[data-preview-img]");
    var icon = box.querySelector("[data-preview-icon]");
    var showImage = function (visible) { img.classList.toggle("d-none", !visible); icon.classList.toggle("d-none", visible); };

    img.onerror = function () { showImage(false); };
    if (image && img.getAttribute("src") !== image) { img.src = image; img.alt = option.text.split(" (")[0]; }
    showImage(!!image);

    typeBox.textContent = "";
    if (image && option.dataset.type) {
      var badge = document.createElement("span");
      badge.className = "type-badge type-" + option.dataset.type.toLowerCase();
      badge.textContent = option.dataset.type.charAt(0).toUpperCase() + option.dataset.type.slice(1);
      typeBox.appendChild(badge);
    }
  }

  document.addEventListener("change", function (event) {
    if (!event.target.matches(SELECTOR)) return;
    // If the other side already had this Pokemon, send it back to its placeholder.
    document.querySelectorAll(SELECTOR).forEach(function (other) {
      if (other !== event.target && other.value === event.target.value) other.value = "";
    });
    syncBattlePicks();
  });

  document.addEventListener("DOMContentLoaded", syncBattlePicks);
})();
