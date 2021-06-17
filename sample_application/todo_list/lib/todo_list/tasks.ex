defmodule TodoList.Tasks do
  @moduledoc """
  This GenServer contains the state for the TodoList application. This
  should ideally go into a database of some sort, but for the purposes
  of keeping this demo app simple, an in-memory GenServer is
  sufficient.
  """

  use GenServer

  # ---- Public API ----

  def start_link(_) do
    initial_state = %{tasks: %{}, index_key: 0, num_tasks: 0}

    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  def get_state do
    GenServer.call(__MODULE__, :get_state)
  end

  def complete_task(task_id) do
    GenServer.call(__MODULE__, {:complete_task, task_id})
  end

  def new_task(task_description) do
    GenServer.call(__MODULE__, {:new_task, task_description})
  end

  # ---- Callback Functions ----

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:complete_task, task_id}, _from, state) do
    updated_state =
      state
      |> Map.update!(:num_tasks, fn old_num_tasks -> old_num_tasks - 1 end)
      |> Map.update!(:tasks, fn old_tasks -> Map.delete(old_tasks, task_id) end)

    {:reply, updated_state.tasks, updated_state}
  end

  def handle_call({:new_task, task_description}, _from, %{index_key: index_key} = state) do
    updated_state =
      state
      |> Map.update!(:num_tasks, fn old_num_tasks -> old_num_tasks + 1 end)
      |> Map.update!(:index_key, fn old_index_key -> old_index_key + 1 end)
      |> Map.update!(:tasks, fn old_tasks -> Map.put(old_tasks, index_key, task_description) end)

    {:reply, updated_state.tasks, updated_state}
  end
end
