# CALENDAR LIVE COMPONENT

This Calendar component was inspired by:

* [andreaseriksson/tutorials](https://github.com/andreaseriksson/tutorials) repository on Github for the logic.
* [nicolasblanco/booking_calendar](https://github.com/nicolasblanco/booking_calendar) repository on Github for the CSS.


## HOW TO USE

### Require the CSS

Add to your `assets/css/app.scss`:

```css
@import "./../../deps/web_it/lib/live/calendar/css/calendar.css";
```

### In a Live View Template

Use it  from a live view template:

```elixir
<%= live_component(
      @socket,
      WebIt.Live.Calendar.Socket,
      id: "unique-calendar-id",
      class: "calendar-card more-classes-here",
      click_date: %{
        redirect_to: "/live-endpoint/:date"
      }
    )
%>
```

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
<button class="button button-outline" phx-hook="ModalOpen" data-modal-id="UNIQUE_MODAL_ID">Show Confirmation Dialog</button>
```

Use it from you live view template inside a modal:

```elixir
<%= live_component(
      @socket,
      WebIt.Live.Modal.Socket,
      id: "UNIQUE_MODAL_ID",
      body: %{
        class: "your optional classes here",
        content: live_component(
          @socket,
          WebIt.Live.Calendar.Socket,
          id: "unique-calendar-id",
          class: "your optional classes here",
          click_date: %{
            redirect_to: "/live-endpoint/:date"
          }
        )
      }
    )
%>
```
