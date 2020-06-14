defmodule WebIt.Live.Calendar.Day do

  use WebIt, :phoenix_live_component

  def update(assigns, socket) do
    assigns = Map.put(assigns, :day_class, day_class(assigns))
    {:ok, assign(socket, assigns)}
  end

  defp day_class(assigns) do
    class = "cursor-pointer"
    with class <- _today_class(assigns, class),
         class <- _current_date_class(assigns, class),
         class <- _saturday_class(assigns, class),
         class <- _sunday_class(assigns, class),
         class <- _other_month_day(assigns, class)
      do
        class
    end
  end

  defp _today_class(assigns, class) do
    day = Map.take(assigns.day, [:year, :month, :day])
    today = Map.take(Timex.now, [:year, :month, :day])

    case day === today do
      true ->
        "#{class} calendar-today"

      false ->
        class
    end
  end

  defp _current_date_class(assigns, class) do
    day = Map.take(assigns.day, [:year, :month, :day])
    current_date = Map.take(assigns.current_date, [:year, :month, :day])

    case day === current_date do
      true ->
        "#{class} calendar-current-date"

      false ->
        class
    end
  end


  defp _saturday_class(assigns, class) do
    case assigns.day === _saturday(assigns.day, assigns.week_start_at) do
      true ->
        "#{class} calendar-saturday"

      false ->
        class
    end
  end

  defp _sunday_class(assigns, class) do
    case assigns.day === _sunday(assigns.day, assigns.week_start_at) do
      true ->
        "#{class} calendar-sunday"

      false ->
        class
    end
  end

  defp _other_month_day(assigns, class) do
    month = Map.take(assigns.day, [:year, :month])
    other_month = Map.take(assigns.current_date, [:year, :month])

    case month !== other_month do
      true ->
        "#{class} calendar-other-month-day"

      false ->
        class
    end
  end

  defp _saturday(date, week_start_at) do
    date
    |> Timex.end_of_week(week_start_at)
    |> Timex.shift(days: -1)
    |> Timex.beginning_of_day()
  end

  defp _sunday(date, week_start_at) do
    date
    |> Timex.end_of_week(week_start_at)
    |> Timex.beginning_of_day()
  end
end
