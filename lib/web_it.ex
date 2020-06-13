defmodule WebIt do

  def phoenix_live_view do
    quote do
      use Phoenix.LiveView

      unquote(view_helpers())
    end
  end

  def phoenix_live_component do
    quote do
      use Phoenix.LiveComponent

      unquote(view_helpers())
    end
  end

  defp view_helpers do
    quote do
      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      # Import LiveView helpers (live_render, live_component, live_patch, etc)
      import Phoenix.LiveView.Helpers

      # Import basic rendering functionality (render, render_layout, etc)
      import Phoenix.View
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
