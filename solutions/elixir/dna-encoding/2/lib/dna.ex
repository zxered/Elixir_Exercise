defmodule DNA do
  def encode_nucleotide(?\s), do: 0b0000
  def encode_nucleotide(?A), do: 0b0001
  def encode_nucleotide(?C), do: 0b0010
  def encode_nucleotide(?G), do: 0b0100
  def encode_nucleotide(?T), do: 0b1000

  def decode_nucleotide(0b0000), do: ?\s
  def decode_nucleotide(0b0001), do: ?A
  def decode_nucleotide(0b0010), do: ?C
  def decode_nucleotide(0b0100), do: ?G
  def decode_nucleotide(0b1000), do: ?T

  def encode(dna), do: do_encode(dna, <<>>)

  def decode(dna), do: do_decode(dna, [])

  defp do_encode([], data), do: data
  defp do_encode([head | tail], data), do: do_encode(tail, <<data::bitstring, encode_nucleotide(head)::4>>)

  defp do_decode(<<>>, data), do: reverse(data, [])
  defp do_decode(<<value::4, rest::bitstring>>, data), do: do_decode(rest, [decode_nucleotide(value) | data])

  defp reverse([], list), do: list
  defp reverse([head | tail], list), do: reverse(tail, [head | list])
end