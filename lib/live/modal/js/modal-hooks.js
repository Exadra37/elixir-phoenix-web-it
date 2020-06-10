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
      const id = utils.getEventTargetAttribute(e, "data-modal-id")

      if (id !== undefined) {
        utils.animatedFadeOutById(id, 1000)
      }
    })
  }
}

module.exports = Modal

