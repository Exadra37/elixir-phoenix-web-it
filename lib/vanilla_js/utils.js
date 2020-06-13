const copyToClipBoard = function(selector) {
  // @link https://css-tricks.com/copy-paste-the-web/
  // Select the email link anchor text
  let html = document.querySelector(selector);

  let range = document.createRange();
  range.selectNode(html);
  window.getSelection().addRange(range);

  try {

    // Now that we've selected the anchor text, execute the copy command
    let successful = document.execCommand('copy');

    if (! successful) {
      alert('Copy to clipboard failed. Please select the area to copy and use ctrl + c shortcut keys.')
    }

  } catch(err) {
    alert('Copy to clipboard error. Please select the area to copy and use ctrl + c shortcut keys.')
  }

  // Remove the selections - NOTE: Should use
  // removeRange(range) when it is supported
  window.getSelection().removeRange(range);
}

const displayElement = function(id) {
  document.getElementById(id).style.display = 'block'
}

const hideElement = function(id) {
  document.getElementById(id).style.display = 'none'
}

// Display all occurrences it fins of the given CSS selector.
const displayAll = function(selector) {
  document.querySelectorAll(selector).forEach(function(el) {
    el.style.display = 'block'
  });
}

// Hide all occurrences it fins of the given CSS selector.
const hideAll = function(selector) {
  document.querySelectorAll(selector).forEach(function(el) {
    el.style.display = 'none'
  });
}

// Remove all occurrences of the given class name.
const removeClass = function(className) {
  document.querySelectorAll('.' + className).forEach(function(el) {
    el.className = el.className.replace(className, '').trim()
  });
}

const removeClassFrom = function(id, cssClass) {
  let el = document.getElementById(id)
  el.className = el.className.replace(cssClass, '').trim()
}

const addClassTo = function(id, cssClass) {
  let el = document.getElementById(id)
  el.className = el.className + ' ' + cssClass
}

// Set the cursor at the end of the given selector
const setCursorAtTheEnd = function(selector, el) {
  const set = el.querySelector(selector)
  set.focus()
  set.setSelectionRange(set.value.length, set.value.length)
}

const getEventTargetAttribute = function(e, attribute) {
  if (e.target.attributes[attribute]) {
    return e.target.attributes[attribute].value
  }

  return undefined
}

const animatedFadeInById = function(id, fade_in_class) {
  addClassTo(id, fade_in_class)
  displayElement(id)

  // Give time for the fade in animation to run.
  setTimeout(function () {
    removeClassFrom(id, fade_in_class)
  }, 1000);
}

const animatedFadeOutById = function(id, fade_out_class) {
  addClassTo(id, fade_out_class)

  // Give time for the fade out animation to run.
  setTimeout(function () {
    removeClassFrom(id, fade_out_class)
    hideElement(id)
  }, 1000);
}

module.exports = {
  copyToClipBoard,
  displayElement,
  hideElement,
  displayAll,
  hideAll,
  removeClass,
  removeClassFrom,
  addClassTo,
  setCursorAtTheEnd,
  getEventTargetAttribute,
  animatedFadeInById,
  animatedFadeOutById,
}
