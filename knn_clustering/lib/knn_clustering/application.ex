defmodule KnnClustering.Application do

    def start(_, _) do
        test_data = KnnClustering.SampleData.without_classification()
        initial_centroids = KnnClustering.generate(test_data, 3)
        IO.inspect(initial_centroids)
        res = KnnClustering.recursive(10, test_data, initial_centroids)
        IO.inspect(res)
    end
end