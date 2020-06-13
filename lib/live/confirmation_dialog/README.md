# CONFIRMATION DIALOG LIVE COMPONENT

This confirmation dialog component was inspired by [pthompson/live_component_examples](https://github.com/pthompson/live_component_examples) repository on Github, from where I borrowed some of the code used inside the modal example.

[Home](/README.md)


## HOW TO USE

### Require the CSS

Add to your `assets/css/app.scss`:

```css
@import "./../../deps/web_it/lib/live/confirmation_dialog/css/confirmation_dialog.css";
```

[Home](/README.md)

### Inside a Modal on a Live View Template

Add to your `assets/js/app.js`:

```js
import Modal from "../../deps/web_it/lib/live/modal/js/modal-hooks.js"

let Hooks = {
  // add after your ...OtherHooks,
  ...Modal,
}
```

The button to trigger the modal:

```html
<button
  class="button button-outline"
  phx-hook="ModalOpen"
  data-modal-id="UNIQUE_MODAL_ID"
>Show Confirmation Dialog</button>
```

Use it from you live view template inside a modal:

```elixir
<%= live_component(
      @socket,
      WebIt.Live.Modal.Socket,
      id: "UNIQUE_MODAL_ID",
      footer: %{
        content: "This action is irreversible",
        class: "alert alert-warning",
      },
      body: %{
        content: live_component(
          @socket,
          WebIt.Live.ConfirmationDialog.Socket,
          question: "Do you really want to delete the Todo?",
          buttons: %{
            left: %{
              text: "Cancel",
              phx_click: nil,
              phx_values: "",
            },
            right: %{
              text: "Ok",
              phx_click: "todo_delete",
              phx_values: "phx-value-todo-uid=ABC"
            }
          }
        )
      }
    )
%>
```

[Home](/README.md)
