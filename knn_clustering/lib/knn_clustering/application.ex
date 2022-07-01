defmodule KnnClustering.Application do
  def start(_, _) do
    test_data = KnnClustering.SampleData.without_classification()
    initial_centroids = KnnClustering.generate(test_data, 3)
    res = KnnClustering.recursive(10, test_data, initial_centroids)
  end
end
