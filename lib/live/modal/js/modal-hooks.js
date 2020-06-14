const utils = require("../../../vanilla_js/utils.js")

// It's important for the fade in timeout to be the same as the one defined in
// modal.css for `--animate-duration: 500ms;`, otherwise when we trigger a live
// view update from an action in a modal we will see the modal to pop-up
// momentarily.
const fade_in_timeout = 500
const fade_out_timeout = fade_in_timeout / 2

let Modal = {}

Modal.ModalOpen = {
  mounted() {
    const id = "modal-" + this.el.attributes["data-modal-id"].value

    this.el.addEventListener("click", e => {
      utils.animatedFadeInById(id, "animate__fadeIn", fade_in_timeout)
    })
  }
}

Modal.ModalClose = {
  mounted() {
    this.el.addEventListener("click", e => {

      const id = this.el.dataset.modalId
      const close_modal = utils.getEventTargetAttribute(e, "data-close-modal")

      if (close_modal !== undefined && close_modal == "true" && id !== undefined) {

        // When we click inside the modal content and want to let the phx-click
        // to proceed, and at same time close the modal, like when we pick a
        // date in a calendar, that will take us to another action.
        //
        // Requires the html element to be annotated with `data-close-modal="true"`.
        e.preventDefault()
        utils.animatedFadeOutById(id, "animate__fadeOut", fade_out_timeout)

        return false

      } else if (close_modal !== undefined && close_modal == "false") {

        // When we click inside the modal content and want to let the phx-click
        // to proceed, but we want to keep the modal open, like when navigating
        // through the months of a calendar.
        //
        // Requires the html element to be annotated with `data-close-modal="false"`.
        return false

      // @link https://gomakethings.com/checking-event-target-selectors-with-event-bubbling-in-vanilla-javascript/
      } else if (e.target.classList.contains('modal-background')) {

        // When we click outside the modal(the grey area) to dismiss it.
        utils.animatedFadeOutById(id, "animate__fadeOut", fade_out_timeout)

      } else {

        // Prevents the modal from closing when we click anywhere inside its
        // content.
        e.preventDefault()
        e.stopPropagation()
        e.stopImmediatePropagation()
        return false
      }
    })
  }
}

module.exports = Modal
