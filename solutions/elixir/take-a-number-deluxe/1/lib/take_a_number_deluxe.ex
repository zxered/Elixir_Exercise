defmodule TakeANumberDeluxe do
  use GenServer
  # Client API

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(init_arg) do
    GenServer.start_link(__MODULE__, init_arg)
  end

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine) do
    GenServer.call(machine, :report_state)
  end

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine) do
    message = GenServer.call(machine, :queue_new_number)
    if is_number(message) do
      {:ok, message}
    else
      {:error, message}
    end
  end

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil) do
    message = GenServer.call(machine, priority_number)
    if is_number(message) do
      {:ok, message}
    else
      {:error, message}
    end
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine) do
    GenServer.cast(machine, :reset_state)
  end

  @impl GenServer
  def init(init_arg) do
    result =
      TakeANumberDeluxe.State.new(
        Keyword.get(init_arg, :min_number),
        Keyword.get(init_arg, :max_number),
        Keyword.get(init_arg, :auto_shutdown_timeout, :infinity)
      )
      case result do
        {:ok, state} -> {:ok, state, state.auto_shutdown_timeout}
        _ -> result
      end
  end

  @impl GenServer
  def handle_call(:report_state, _from, state) do
    {:reply, state, state, state.auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_call(:queue_new_number, _from, state) do
    case TakeANumberDeluxe.State.queue_new_number(state) do
      {:ok, new_number, new_state} -> {:reply, new_number, new_state, new_state.auto_shutdown_timeout}
      {:error, error} -> {:reply, error, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_call(priority_number, _from, state) do
    case TakeANumberDeluxe.State.serve_next_queued_number(state, priority_number) do
      {:ok, next_number, new_state} -> {:reply, next_number, new_state, new_state.auto_shutdown_timeout}
      {:error, error} -> {:reply, error, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_cast(:reset_state, state) do
    {:ok, new_state} =
      TakeANumberDeluxe.State.new(
        state.min_number,
        state.max_number,
        state.auto_shutdown_timeout
      )
      
    {:noreply, new_state, new_state.auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_info(request, state) do
    case request do
      :timeout -> {:stop, :normal, state}
      _ -> {:noreply, state, state.auto_shutdown_timeout}
    end
  end
end
