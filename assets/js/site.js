(function () {
  document.documentElement.classList.add("has-js");

  const toggle = document.querySelector("[data-menu-toggle]");
  const menu = document.querySelector("[data-mobile-menu]");

  if (!toggle || !menu) {
    return;
  }

  const pageRegions = Array.from(document.querySelectorAll("main, .site-footer")).filter(Boolean);

  const getMenuLinks = function () {
    return Array.from(menu.querySelectorAll("a, button, [tabindex]:not([tabindex='-1'])"));
  };

  const isDesktopLayout = function () {
    return window.getComputedStyle(toggle).display === "none";
  };

  const setMenuState = function (open, options) {
    const settings = options || {};
    const focusableLinks = getMenuLinks();

    toggle.setAttribute("aria-expanded", String(open));
    menu.hidden = !open;
    document.body.classList.toggle("menu-open", open);

    pageRegions.forEach(function (region) {
      region.inert = open;
    });

    if (open) {
      (settings.focusTarget || focusableLinks[0] || toggle).focus();
      return;
    }

    if (settings.restoreFocus) {
      toggle.focus();
    }
  };

  const onKeydown = function (event) {
    if (toggle.getAttribute("aria-expanded") !== "true") {
      return;
    }

    if (event.key === "Escape") {
      event.preventDefault();
      setMenuState(false, { restoreFocus: true });
      return;
    }

    if (event.key !== "Tab") {
      return;
    }

    const focusableItems = [toggle].concat(getMenuLinks());
    const firstIndex = 0;
    const lastIndex = focusableItems.length - 1;
    const currentIndex = focusableItems.indexOf(document.activeElement);

    if (event.shiftKey && (currentIndex <= firstIndex || currentIndex === -1)) {
      event.preventDefault();
      focusableItems[lastIndex].focus();
      return;
    }

    if (!event.shiftKey && currentIndex === lastIndex) {
      event.preventDefault();
      focusableItems[firstIndex].focus();
    }
  };

  setMenuState(false);

  toggle.addEventListener("click", function () {
    const isOpen = toggle.getAttribute("aria-expanded") === "true";
    setMenuState(!isOpen, { restoreFocus: isOpen });
  });

  getMenuLinks().forEach(function (link) {
    link.addEventListener("click", function () {
      setMenuState(false);
    });
  });

  document.addEventListener("keydown", onKeydown);

  window.addEventListener("resize", function () {
    if (isDesktopLayout()) {
      setMenuState(false);
    }
  });
})();
