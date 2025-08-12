defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted(string)
    |> elem(1)
  end
  
  def decode_secret_message_part(ast, acc) do
    case ast do
      {op, _, [{:when, _, [fun_head, _guard]}, _body]} when op in [:def, :defp] ->
        {name, _, args} = fun_head
        n = if is_list(args), do: length(args), else: 0
        Atom.to_string(name)
        |> String.slice(0, n)
        |> then(&{ast, [&1 | acc]})
    
      {op, _, [{name, _, args}, _body]} when op in [:def, :defp] ->
        n = if is_list(args), do: length(args), else: 0
        Atom.to_string(name)
        |> String.slice(0, n)
        |> then(&{ast, [&1 | acc]})
        
      _ -> {ast, acc}
    end
  end

  def decode_secret_message(string) do
    to_ast(string)
    |> Macro.prewalk([], &decode_secret_message_part/2)
    |> elem(1)
    |> Enum.reverse()
    |> Enum.join("")
  end
end
