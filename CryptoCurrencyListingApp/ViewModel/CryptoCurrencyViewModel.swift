//
//  CryptoCurrencyViewModel.swift
//  CryptoCurrencyListingApp
//
//  Created by Yashavika Singh on 25.05.24.
//

import Foundation

class CryptoCurrencyViewModel: ObservableObject{
    @Published var cryptoCurrencies : [CryptoCurrency] = []
    @Published var isLoading =  false
    @Published var errorMessage: String?
    
    private let urlString = "https://api.coinlore.net/api/tickers/?start=0&limit=10"
    
    func fetchData(){
        guard let url = URL(string: urlString) else
        {
            errorMessage = "Invalid URL"
            return
        }
        isLoading = true
        let task = URLSession.shared.dataTask(with: url){
            [weak self] data, response, error in DispatchQueue.main.async {
                self?.handleResponse(data: data, response: response, error: error)
            }
        }
        task.resume()
    }
    private func handleResponse(data: Data?, response: URLResponse?, error: Error?)
    {
        isLoading = false;
        
        if let error = error{
            errorMessage = "failed to fetch data: \(error.localizedDescription)"
            return
        }
        guard let httpsResponse = response as? HTTPURLResponse, httpsResponse.statusCode == 200 else
        {
            errorMessage = "Error: Invalid Response from Server"
            return
        }
        
        guard let data = data else{
            errorMessage = "Error: No data received"
            return
        }
        
        
        decodeData(data)
    }
    
    private func decodeData(_ data: Data)
    {
        do{
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(ApiResponse.self, from: data)
            cryptoCurrencies = decodedData.data
        }
        catch{
            errorMessage = "Failed to decode data"
        }
    }
}
