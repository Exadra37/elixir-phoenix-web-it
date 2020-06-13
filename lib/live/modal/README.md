# MODAL LIVE COMPONENT

The Modal component was inspired by [pthompson/live_component_examples](https://github.com/pthompson/live_component_examples) repository on Github.

This modal is only a container where we will inject other content, instead of having other functionality, like the confirmation dialog present in the original example.

The click events to open and close the Modal are not handled on the server side, as in the original example, because that approach gives a bad user experience in slow and unstable Internet connections, like when commuting in public transports.


## HOW TO USE

### Require the CSS

Add to your `assets/css/app.scss`:

```css
@import "./../../lib/web_it/lib/css/animate.css";
@import "./../../deps/web_it/lib/live/modal/css/modal.css";
```

### Require the Javascript

Add to your `assets/js/app.js`:

```js
import Modal from "../../deps/web_it/lib/live/modal/js/modal-hooks.js"

let Hooks = {
  // add after your ...OtherHooks,
  ...Modal,
}
```

### In a Live View Template

The button to trigger the modal:

```html
<button class="button button-outline" phx-hook="ModalOpen" data-modal-id="UNIQUE_MODAL_ID">Show Confirmation Dialog</button>
```

Use it from you live view template:

```elixir
<%= live_component(
      @socket,
      WebIt.Live.Modal.Socket,
      id: "UNIQUE_MODAL_ID",
      header: %{
        class: "your optional classes here",
        content: "your optional header here",
      },
      body: %{
        class: "your optional classes here",
        content: live_component(
          @socket,
          WebIt.Live.Calendar.Socket,
          id: "calendar-todo",
          click_date: %{
            redirect_to: "/todos/:date"
          }
        )
      },
      footer: %{
        class: "your optional classes here",
        content: "your optional footer here",
      },
    )
%>
```
