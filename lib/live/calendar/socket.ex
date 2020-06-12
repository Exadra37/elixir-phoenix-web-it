defmodule WebIt.Live.Calendar.Socket do

  use Phoenix.LiveComponent

  require Logger

  @week_start_at :mon

  defp _build_assigns(socket, current_date) do
    assigns = [
      current_date: current_date,
      day_names: day_names(@week_start_at),
      week_rows: week_rows(current_date),
      week_start_at: @week_start_at,
    ]

    assign(socket, assigns)
  end


  def mount(socket) do
    current_date = Timex.now
    Logger.info("Mount Calendar for date: #{current_date}")
    {:ok, _build_assigns(socket, current_date)}
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
    Logger.info("Shift calendar back to: #{current_date}")
    {:noreply, _build_assigns(socket, current_date)}
  end

  def handle_event("next-month", _, socket) do
    current_date = Timex.shift(socket.assigns.current_date, months: 1)
    Logger.info("Shift calendar forward to: #{current_date}")
    {:noreply, _build_assigns(socket, current_date)}
  end

  def handle_event("pick-date", %{"date" => date}, socket) do
    Logger.info("Pick date for: #{date}")
    {:noreply, push_redirect(socket, to: "/todos/#{date}")}
  end
end
