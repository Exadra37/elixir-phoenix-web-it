const utils = require("../../../../vanilla_js/utils.js")

let Calendar = {}

Calendar.PickDate = {
  mounted() {
    const id = this.el.parentNode.attributes["data-modal-id"].value

    this.el.addEventListener("click", e => {
      const click_type = utils.getEventTargetAttribute(e, "data-click-type")

      if (click_type !== undefined && click_type === "pick-date") {
        utils.animatedFadeOutById(id, 1000)
      }
    })
  }
}

module.exports = Calendar

