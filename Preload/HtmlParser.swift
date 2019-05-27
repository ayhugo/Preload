//
//  HtmlParser.swift
//  Preload
//
//  Created by MacBook Ayre on 11/12/18.
//  Copyright © 2018 MacBook Ayre. All rights reserved.
//

import Foundation

import SwiftSoup

enum HTMLError: Error {
    case badInnerHTML
}

struct HtmlParser {
    
    let products: [Product]
    
    init(_ innerHTML: Any?) throws {
        guard let htmlString = innerHTML as? String else { throw HTMLError.badInnerHTML }
        
        let doc = try SwiftSoup.parse(htmlString)
        
        let productNames = try doc.getElementsByClass("w2mItemName").array()
        let productPrices = try doc.getElementsByClass("SpecialPriceFormat2").array()
        
        var products = [Product]()
        for i in 0..<productPrices.count {
            let productName = try productNames[i].text()
            let productPrice = try productPrices[i].text()
            
            
            let product = Product(productName: productName, productPrice: productPrice)
            products.append(product)
            
            
        }
        
        self.products = products
    }
}
