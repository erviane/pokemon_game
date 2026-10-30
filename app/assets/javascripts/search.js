// Search filters apply as soon as a value is picked.
document.addEventListener("change", function (event) {
  if (event.target.matches("select[data-auto-submit]")) event.target.form.requestSubmit();
});

// Leave empty fields out of the URL (?q=&type= becomes ?type=Fire).
document.addEventListener("submit", function (event) {
  if (!event.target.matches("form[role=search]")) return;
  Array.prototype.forEach.call(event.target.elements, function (field) {
    if (field.name && !field.value) field.disabled = true;
  });
});

// Re-enable them when the page comes back from the back/forward cache.
window.addEventListener("pageshow", function () {
  document.querySelectorAll("form[role=search] [disabled]").forEach(function (field) { field.disabled = false; });
});
