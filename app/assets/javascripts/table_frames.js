// Sorting and paging inside a [data-frame] swaps just that block instead of reloading the page,
// so the scroll position stays put. Plain links still work without JS or if the request fails.
(function () {
  var LINKS = "[data-frame] a.sort-link, [data-frame] .pagination a";
  var navigated = false;

  document.addEventListener("click", function (event) {
    var link = event.target.closest(LINKS);
    if (!link || event.button !== 0 || event.metaKey || event.ctrlKey || event.shiftKey || event.altKey) return;
    var frame = link.closest("[data-frame]");
    var isPaging = !!link.closest(".pagination");
    event.preventDefault();
    frame.setAttribute("aria-busy", "true");

    fetch(link.href, { headers: { Accept: "text/html" } })
      .then(function (response) { if (!response.ok) throw new Error(response.status); return response.text(); })
      .then(function (html) {
        var fresh = new DOMParser().parseFromString(html, "text/html").getElementById(frame.id);
        if (!fresh) throw new Error("frame #" + frame.id + " missing");
        frame.replaceWith(fresh);
        history.pushState({ frame: frame.id }, "", link.href.split("#")[0]);
        navigated = true;
        // Only paging jumps: its links sit below the table, so bring the new page's top into view.
        // Sorting keeps the scroll position exactly where it was.
        if (isPaging && fresh.getBoundingClientRect().top < 0) fresh.scrollIntoView({ block: "start" });
      })
      .catch(function () { window.location.href = link.href; });
  });

  // Back/forward after a swap: reload so the page matches the URL.
  window.addEventListener("popstate", function () { if (navigated) window.location.reload(); });
})();
