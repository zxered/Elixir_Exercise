defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    @impl true
    def exception(value) do
      base_message = "stack underflow occurred"
      
      case value do
        [] -> %StackUnderflowError{}
        _ -> %StackUnderflowError{message: "#{base_message}, context: #{value}"}
      end
    end
  end

  def divide([0, _]), do: raise DivisionByZeroError
  def divide([a, b]), do: b/a
  def divide(_), do: raise StackUnderflowError.exception("when dividing")
end
