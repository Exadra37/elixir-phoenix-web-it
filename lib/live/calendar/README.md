# CALENDAR LIVE COMPONENT

This Calendar component was inspired by:

* [andreaseriksson/tutorials](https://github.com/andreaseriksson/tutorials) repository on Github for the logic.
* [nicolasblanco/booking_calendar](https://github.com/nicolasblanco/booking_calendar) repository on Github for the CSS.

[Home](/README.md)


## HOW TO USE

### Require the CSS

Add to your `assets/css/app.scss`:

```css
@import "./../../deps/web_it/lib/live/calendar/css/calendar.css";
```

[Home](/README.md)

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
>Show Calendar</button>
```

#### The calendar component handles the click event

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
            phx_target_self: true,
            push_redirect_to: "/todos/:date"
          }
        )
      }
    )
%>
```

The use of `phx_target_self` instructs the component to be itself to handle the click in any day of the calendar. This also requires for `push_redirect_to` to be defined in order to do a live redirect for the given live endpoint, thus incurring in mounting and re-render the live view for that endpoint.

[Home](/README.md)

#### The click event is handled by the live view that includes the calendar component

Include the calendar component:

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
            phx_click: "selected_date"
          }
        )
      }
    )
%>
```

Handling the event in the live view that includes it:

```elixir
def handle_event("selected_date", %{"date" => date}, socket) do
  Logger.info("Selected date: #{date}")

  # Do whatever logic you need and do the necessary assigns so that Live View can detect the changes:
  # socket = socket |> assign([date: date, display_date: _display_date_from(date)])

  # Or just do a `push_patch` to the current live view:
  # {:noreply, push_patch(socket, to: "/todos/#{date}")}

  {:noreply, socket}
end
```

If you omit the `phx_click` and just do instead `click_date: %{}` then the event will still go to the live view that includes the calendar component, but this time you need to handle the event `pick_date` instead of the custom one you defined above, the `selected_date`.
