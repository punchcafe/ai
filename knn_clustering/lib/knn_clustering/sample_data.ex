defmodule KnnClustering.SampleData do
    
  def sample_vector() do
    [_header | data ] = "../../priv/wine.data.csv"
    |> Path.expand(__DIR__)
    |> File.stream!
    |> CSV.decode
    |> Enum.to_list()
    data
  end

  def without_classification do
    sample_vector()
    |> Enum.map(fn {:ok, [_ | vector]} -> vector end)
    |> Enum.map(fn vector -> Enum.map(vector, fn str -> 
      {num, ""} = Float.parse(str)
      num
    end)
  end)
end
end