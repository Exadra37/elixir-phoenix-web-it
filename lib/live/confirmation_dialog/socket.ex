defmodule WebIt.Live.ConfirmationDialog.Socket do

  use WebIt, :phoenix_live_component

  require Logger

  @defaults %{
    left_button: "Cancel",
    left_button_param: nil,
    right_button: "OK",
    right_button_param: nil,
    left_phx_click: nil,
    right_phx_click: nil,
  }

  def mount(socket) do
    Logger.debug("MOUNT #{__MODULE__}")
    {:ok, socket}
  end

  # def update(%{id: _id} = assigns, socket) do
  #   case assigns[:buttons] do
  #     nil ->
  #       {:ok, assign(socket, assigns)}

  #     _ ->
  #       {:ok, assign(socket, Map.merge(@defaults, assigns[:buttons]))}
  #   end
  # end

  # # Fired when user clicks right button on modal
  # def handle_event(
  #       "right-button-click",
  #       _params,
  #       %{
  #         assigns: %{
  #           right_button_action: right_button_action,
  #           right_button_param: right_button_param
  #         }
  #       } = socket
  #     ) do
  #   send(
  #     self(),
  #     {__MODULE__, :button_clicked, %{action: right_button_action, param: right_button_param}}
  #   )

  #   {:noreply, socket}
  # end

  # def handle_event(
  #       "left-button-click",
  #       _params,
  #       %{
  #         assigns: %{
  #           left_button_action: left_button_action,
  #           left_button_param: left_button_param
  #         }
  #       } = socket
  #     ) do
  #   send(
  #     self(),
  #     {__MODULE__, :button_clicked, %{action: left_button_action, param: left_button_param}}
  #   )

  #   {:noreply, socket}
  # end
end
