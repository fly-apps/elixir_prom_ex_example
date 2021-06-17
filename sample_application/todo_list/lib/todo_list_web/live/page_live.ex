defmodule TodoListWeb.PageLive do
  use TodoListWeb, :live_view

  alias TodoList.Tasks
  alias Phoenix.PubSub

  @pubsub_topic "state_updated"

  @impl true
  def mount(_params, _session, socket) do
    PubSub.subscribe(TodoList.PubSub, @pubsub_topic)

    {:ok, assign(socket, Tasks.get_state())}
  end

  @impl true
  def handle_event("complete_task", %{"id" => id}, socket) do
    id
    |> String.to_integer()
    |> Tasks.complete_task()

    broadcast_change()

    {:noreply, assign(socket, Tasks.get_state())}
  end

  def handle_event("create_new_task", %{"new_task" => ""}, socket) do
    {:noreply, socket}
  end

  def handle_event("create_new_task", %{"new_task" => task_description}, socket) do
    Tasks.new_task(task_description)
    broadcast_change()

    updated_socket =
      socket
      |> push_event("clear_input", %{})
      |> assign(Tasks.get_state())

    {:noreply, updated_socket}
  end

  @impl true
  def handle_info(:refresh_list, socket) do
    {:noreply, assign(socket, Tasks.get_state())}
  end

  defp broadcast_change do
    PubSub.broadcast_from(TodoList.PubSub, self(), @pubsub_topic, :refresh_list)
  end
end
