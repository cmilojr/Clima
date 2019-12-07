//
//  RandomQuote.swift
//  Clima
//
//  Created by Camilo Jiménez on 6/12/19.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import Foundation
struct RandomQuote {
    var delegate: QuoteManagerDelegate?
    let quoteURL: String = "https://quote-garden.herokuapp.com/quotes/random"
    
    func performRequest() {
        let urlString: String = quoteURL
        // 1. Create URL
        
        if let url = URL(string: urlString) {
            
            // 2. Create URL session
            let session = URLSession(configuration: .default)
            
            // 3. Give the session a task
            let task = session.dataTask(with: url) { (data, URLresponse, error) in
                if error != nil {
                    self.delegate?.didFailDeal(error!)
                    return
                }
                if let safeData = data {
                    
                    if let quoteReturn = self.parseJSON(safeData) {
                        self.delegate?.didQuoteUpdate(self, quote: quoteReturn)
                    }
                }
            }
            
            // 4. Start the task
            task.resume()
        }
    }
    func parseJSON(_ quoteData: Data) -> String? {
        let decoder = JSONDecoder()
        do {
            let decoderQuote = try decoder.decode(Quote.self, from: quoteData)
            
            let quote = decoderQuote.quoteText

            return quote
        } catch {
            self.delegate?.didFailDeal(error)
            return nil
        }
    }
}
protocol QuoteManagerDelegate{
    func didQuoteUpdate(_ quoteManager: RandomQuote, quote: String)
    func didFailDeal(_ error: Error)
}
