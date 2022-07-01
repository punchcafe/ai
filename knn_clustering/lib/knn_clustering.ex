defmodule KnnClustering do
  
  @type vector :: list()
  @type centroid :: vector()

  def generate(data_set, number_of_cluster) do
      1..number_of_cluster
      |> Enum.map(fn _ -> Enum.random(data_set) end)
      |> Enum.to_list()
  end

  def recursive(1, test_data, centroids), do: centroids
  def recursive(iteration, test_data, centroids) do 
      recursive(iteration-1, test_data, iterate(test_data, centroids))
  end

  def iterate(test_data, centroids) do
      test_data
      |> distances(centroids)
      |> Enum.map(&find_closest/1)
      |> Enum.group_by(fn {group, _} -> group end, fn {_, val} -> val end)
      |> Enum.map(&derive_centroid/1)
  end

  def derive_centroid({_, vectors = [a_vec | _]}) do
      dimensions = Enum.count(a_vec)
      # Can be moved to reduce operation if necessary
      num_of_vectors = Enum.count(vectors)
      initial_sum_vector = 1..dimensions |> Enum.map(fn _ -> 0 end) |> Enum.to_list()
      Enum.reduce(vectors,initial_sum_vector, &vector_sum/2)
      |> Enum.map(fn element -> element/num_of_vectors end)
  end

  defp vector_sum(vector, sum_vector) do
      vector
      |> Enum.zip(sum_vector)
      |> Enum.map(fn {vec_elem, sum_elem} -> vec_elem + sum_elem end)
  end

  def find_closest({vector, centroid_dists}) do
      {_, category} = centroid_dists
      |> Enum.with_index()
      |> Enum.min_by(fn {val, _} -> val end)
      {category, vector}
  end

  def distances(data_set, centroids) do
      Enum.map(data_set, &distances_from_centroids(&1, centroids))
  end

  defp distances_from_centroids(vector, centroids) do
      distances = Enum.map(centroids, &euclid_distance(&1, vector))
      {vector, distances}
  end

  def euclid_distance(vec_lhs, vec_rhs) do
      vec_difference(vec_lhs, vec_rhs)
      |> Enum.map(&:math.pow(&1, 2))
      |> Enum.reduce(&(&1 + &2))
      |> :math.sqrt()
  end

  defp vec_difference([lhs | rest_lhs], [rhs | rest_rhs]), do: [lhs - rhs | vec_difference(rest_lhs, rest_rhs)]
  defp vec_difference([], []), do: []
end
