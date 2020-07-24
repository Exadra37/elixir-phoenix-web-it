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

### Require the Javascript

Add to your `assets/js/app.js`:

```js
import Modal from "../../deps/web_it/lib/live/modal/js/modal-hooks.js"

let Hooks = {
  // add after your ...OtherHooks,
  ...Modal,
}
```

[Home](/README.md)


### Static Dialog

For when we have a single use of the confirmation dialog for the same type of HTML element. See the [Dynamic Dialog](#dynamic-dialog) for when you have a list of HTML elements you want to apply the same confirmation dialog.

#### The button to trigger the modal

```html
<button
  class="button button-outline"
  phx-hook="ModalOpen"
  data-modal-id="UNIQUE_MODAL_ID"
>Delete</button>
```

#### The Phoenix Live View Component

Use it from your live view template inside a modal:

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


### Dynamic Dialog

For situations where we have a list of rows where we want to apply the dialog for each one, but without rendering the static HTML dialog for each one of them, because that causes bigger Phoenix Live View differences.

So let's image a list of Todo's where we want to have a delete button for each of them with a confirmation dialog.

#### The button to delete the Todo

This button will not open the modal directly, instead it will delegate it to the `TodoDeleteButton` Hook, that you need to write yourself in your `assets/js/apps.js`.


```html
<button
  class="button button-clear destroy"
  phx-hook="TodoDeleteButton"
  data-todo-uid="<%= todo.data.uid %>"
  data-todo-hash="<%= todo.data.hash %>"
>Delete</button>
```

#### The Phoenix Live View Hook

The hook will read the `phx-value-*` from the clicked button and set them in the confirmation dialog button, and then it will trigger the click to open
the modal.

```js
Todos.TodoDeleteButton = {
  mounted() {
    this.el.addEventListener("click", e => {

      const todo_uid = this.el.getAttribute("data-todo-uid")
      const todo_hash = this.el.getAttribute("data-todo-hash")

      const ok_button = document.getElementById('todo-delete-ok')
      ok_button.setAttribute('phx-value-uid', todo_uid)
      ok_button.setAttribute('phx-value-hash', todo_hash)

      const modal = document.getElementById('modal-todo-delete')
      modal.click()
    })
  }
}
```

#### The hidden input

This is used to open the modal by triggering a click on it from the `TodoDeleteButton` Hook.

```html
<input type="hidden" id="modal-todo-delete" phx-hook="ModalOpen" data-modal-id="UNIQUE_MODAL_ID">
```

#### The Phoenix Live View Component

The main difference in this component from the static one, is the we do not use the `phx_values` field and instead we add the `id` field to the right button, so that we can then set dynamically the `phx-value-*` on it from the `TodoDeleteButton` hook.

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
              id: "todo-delete-ok",
              text: "Ok",
              phx_click: "todo_delete",
            }
          }
        )
      }
    )
  %>
```

[Home](/README.md)
