defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted(string)
    |> elem(1)
  end
  
  def decode_secret_message_part({op, _, args} = ast, acc) when op in [:def, :defp] do
    case args do
      [{:when, _, [fun_head, _guard]}, _body] ->
        {name, _, fun_args} = fun_head
        n = if is_list(fun_args), do: length(fun_args), else: 0
        Atom.to_string(name)
        |> String.slice(0, n)
        |> then(&{ast, [&1 | acc]})
    
      [{name, _, fun_args}, _body] ->
        n = if is_list(fun_args), do: length(fun_args), else: 0
        Atom.to_string(name)
        |> String.slice(0, n)
        |> then(&{ast, [&1 | acc]})
        
      _ -> {ast, acc}
    end
  end

  def decode_secret_message_part(ast, acc), do: {ast, acc}

  def decode_secret_message(string) do
    {ast, acc} =
      to_ast(string)
      |> Macro.prewalk([], &decode_secret_message_part/2)
    acc
    |> Enum.reverse()
    |> Enum.join("")
  end
end
