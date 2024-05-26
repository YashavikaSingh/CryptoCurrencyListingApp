//
//  ContentView.swift
//  CryptoCurrencyListingApp
//
//  Created by Yashavika Singh on 25.05.24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var viewModel = CryptoCurrencyViewModel()
    
    
    var body: some View {
        ZStack{
            
//
            if(viewModel.isLoading)
            {
                Text("Loading...")
                    .foregroundColor(.black)
                    .font(.largeTitle)
            }
            else
            {
                content
            }
            
        }.onAppear{
            viewModel.fetchData()
        }
    }
    
    private var content: some View {
        
        VStack{
          
            header
            columnTitles
            
            cryptoList
            
        }
    }
    
    private var header: some View{
        Text("Top 10 cryptocurrencies").font(.title)
    }
    
    
    private var columnTitles:  some View{
        HStack{
            ColumnTitle("Name", alignment: .leading)
            ColumnTitle("Symbol", alignment: .center)
            ColumnTitle("Price", alignment: .trailing)
        }
        .padding()
    }
    
    private func ColumnTitle(_ text: String, alignment: Alignment) -> some View{
        Text(text)
            .font(.callout)
            .fontWeight(.light)
            .foregroundColor(.black)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    
    private var cryptoList: some View{
        ScrollView{
            ForEach(viewModel.cryptoCurrencies,id: \.id){currency in
                CryptoRow(currency: currency)
            }
        }
    }
    
    
    struct  CryptoRow: View{
        let currency : CryptoCurrency
        var body: some View{
            HStack{
                icon
                name
                symbol
                price
            }.padding(8)
                .frame(height: 50)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(.secondary.opacity(0.8), lineWidth: 0.5))
        }
        
        
        private var name: some View{
            Text(currency.name)
                .font(.callout)
                .fontWeight(.medium)
            //                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        private var symbol: some View{
            Text(currency.symbol)
                .font(.callout)
                .fontWeight(.medium)
            //                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        
        private var price: some View{
            Text(currency.price_usd)
                .font(.callout)
                .fontWeight(.medium)
            //                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        
        private var icon:  some View{
            AsyncImage(url: URL(string: "https://assets.coincap.io/assets/icons/\(currency.symbol.lowercased())@2x.png")){
                image in image.resizable()
            } placeholder: {
                Text(currency.symbol)
            }
            
            .frame(width: 24, height: 24)
            
            
        }
        
    }
    
   
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
    
    
    
}
