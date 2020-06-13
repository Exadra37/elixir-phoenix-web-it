defmodule WebIt.Live.Calendar.Socket do

  use WebIt, :phoenix_live_component

  require Logger

  # @TODO make the start of the week configurable from the developer application.
  @week_start_at :mon

  def mount(socket) do
    current_date = Timex.now
    Logger.info("Mount Calendar for date: #{current_date}")
    {:ok, _build_assigns(socket, current_date)}
  end

  defp _build_assigns(socket, current_date) do
    assigns = [
      current_date: current_date,
      day_names: day_names(@week_start_at),
      week_rows: week_rows(current_date),
      week_start_at: @week_start_at,
    ]

    assign(socket, assigns)
  end

  defp day_names(:sun), do:  [7, 1, 2, 3, 4, 5, 6] |> Enum.map(&Timex.day_shortname/1)
  defp day_names(_), do:  [1, 2, 3, 4, 5, 6, 7] |> Enum.map(&Timex.day_shortname/1)

  defp week_rows(current_date) do
    first =
      current_date
      |> Timex.beginning_of_month()
      |> Timex.beginning_of_week(@week_start_at)

    last =
      current_date
      |> Timex.end_of_month()
      |> Timex.end_of_week(@week_start_at)

    Timex.Interval.new(from: first, until: last)
    |> Enum.map(& &1)
    |> Enum.chunk_every(7)
  end

  def handle_event("prev-month", _, socket) do
    current_date = Timex.shift(socket.assigns.current_date, months: -1)
    Logger.info("Shift calendar backwards into: #{current_date}")
    {:noreply, _build_assigns(socket, current_date)}
  end

  def handle_event("next-month", _, socket) do
    current_date = Timex.shift(socket.assigns.current_date, months: 1)
    Logger.info("Shift calendar forwards into: #{current_date}")
    {:noreply, _build_assigns(socket, current_date)}
  end

  def handle_event("pick-date", %{"date" => date, "redirect-to" => redirect_to}, socket) do
    Logger.info("Pick date for: #{date}")

    {:noreply, push_redirect(socket, to: String.replace(redirect_to, ":date", date))}
  end
end
