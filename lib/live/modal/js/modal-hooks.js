const utils = require("../../../vanilla_js/utils.js")

let Modal = {}

Modal.ModalOpen = {
  mounted() {
    const id = "modal-" + this.el.attributes["data-modal-id"].value

    this.el.addEventListener("click", e => {
      utils.animatedFadeInById(id, 1000)
    })
  }
}

Modal.ModalClose = {
  mounted() {
    this.el.addEventListener("click", e => {

      const id = this.el.dataset.modalId
      const close_modal = utils.getEventTargetAttribute(e, "data-close-modal")

      if (close_modal !== undefined && close_modal == "true" && id !== undefined) {
        e.preventDefault()
        utils.animatedFadeOutById(id, 1000)
        return false
      } else if (close_modal !== undefined && close_modal == "false") {
        return false
      } else {
        e.preventDefault()
        e.stopPropagation()
        e.stopImmediatePropagation()
        return false
      }
    })
  }
}

Modal.ModalDismiss = {
  mounted() {
    this.el.addEventListener("click", e => {
      if (e.target.classList.contains('modal-background')) {
        const id = this.el.dataset.modalId
        utils.animatedFadeOutById(id, 1000)
      }
    })
  }
}

module.exports = Modal

