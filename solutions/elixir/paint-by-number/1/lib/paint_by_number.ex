defmodule PaintByNumber do
  def palette_bit_size(color_count), do: compare(0, color_count)
  
  def empty_picture(), do: <<>>

  def test_picture(), do: <<0::2, 1::2, 2::2, 3::2>>

  def prepend_pixel(picture, color_count, pixel_color_index) do
    <<pixel_color_index::size(palette_bit_size(color_count)), picture::bitstring>>
  end
  
  def get_first_pixel(<<>>, _color_count), do: nil
  def get_first_pixel(picture, color_count) do
    bits = palette_bit_size(color_count)
    <<value::size(bits), _rest::bitstring>> = picture
    value
  end

  def drop_first_pixel(<<>>, _color_count), do: <<>>
  def drop_first_pixel(picture, color_count) do
    bits = palette_bit_size(color_count)
    <<_value::size(bits), rest::bitstring>> = picture
    rest
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end

  defp compare(n, count) do
    if 2 ** n >= count do
      n
    else
      compare(n+1, count)
    end
  end
end

  