defmodule WebIt.LiveComponent do

  def live_component do
    quote do
      use Phoenix.LiveComponent

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      # Import LiveView helpers (live_render, live_component, live_patch, etc)
      import Phoenix.LiveView.Helpers

      # Import basic rendering functionality (render, render_layout, etc)
      import Phoenix.View
    end
  end

  defmacro __using__ do
    apply(__MODULE__, :live_component, [])
  end
end
