# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []), do: Agent.start_link(fn -> %{counter: 1, plots: []} end, opts)

  def list_registrations(pid), do: Agent.get(pid, & &1.plots)

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn %{counter: n, plots: plots} = state ->
      new_plot = %Plot{plot_id: n, registered_to: register_to}
      updated_state = %{counter: n+1, plots: [new_plot | plots]}
      {new_plot, updated_state}
    end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn %{counter: n, plots: plots} = state ->
      filtered_plots = Enum.reject(plots, fn plot -> plot.plot_id == plot_id end)
      %{counter: n, plots: filtered_plots}
    end)
    :ok
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn %{counter: _, plots: plots} ->
      case Enum.find(plots, fn plot -> plot.plot_id == plot_id end) do
        nil -> {:not_found, "plot is unregistered"}
        plot -> plot
      end
    end)
  end
end
