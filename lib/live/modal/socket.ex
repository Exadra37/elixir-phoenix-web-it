defmodule WebIt.Live.Modal.Socket do

  use WebIt, :phoenix_live_component

  require Logger

  def mount(socket) do
    Logger.info("MOUNT #{__MODULE__}")
    {:ok, socket}
  end

end
