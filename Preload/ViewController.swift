//
//  ViewController.swift
//  Preload
//
//  Created by MacBook Ayre on 20/11/18.
//  Copyright © 2018 MacBook Ayre. All rights reserved.
//

import UIKit
import WebKit
import SwiftSoup

class ViewController: UIViewController, WKNavigationDelegate {

    var webView = WKWebView()
    var addedBeer = false;
    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url1 = URL(string: "http://www.shop.liquorland.co.nz/Mobile/special.aspx?CategoryId=22&s=IsFeatured+DESC%2c+OrderBy+ASC%2c+Name+ASC&ps=48")!
        let request = URLRequest(url: url1)
        webView.load(request)
        
        


    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    func loadRTD(){
        let url2 = URL(string: "http://www.shop.liquorland.co.nz/Mobile/special.aspx?CategoryId=59&s=IsFeatured+DESC%2c+OrderBy+ASC%2c+Name+ASC&ps=48")!
        print("g0there")
        let request = URLRequest(url: url2)
        webView.load(request)
 
    }
    func webView(_ webView: WKWebView,
                 didFinish navigation: WKNavigation!) {

        /*completes the form on the webpage if there is one*/
        webView.evaluateJavaScript("if ( $('input:button').length === 3){$('input:button')[0].click(); document.getElementById('SelectedBranchId').value='933'; $('input:button')[2].setAttribute('class',''); $('input:button')[2].click()}; document.documentElement.outerHTML.toString();",
                                   completionHandler: { (html: Any?, error: Error?) in
                                        let htmlString = String(describing: html)
                                    //print(htmlString)
                                    
                                    /*checks to see if any html is there and checks that products are being displayed*/
                                    if (html != nil && htmlString.range(of: "w2mItemName") != nil){
                                        do {
                                            let htmlParser = try HtmlParser(html)
                                            //print(htmlParser.products)
                                            //print(htmlParser.products.map({ $0.productName}))
                                            
                                            
                                            
                                            if(htmlParser.products.count > 5){
                                                for i in 0..<htmlParser.products.count {
                                                    self.products.append(htmlParser.products[i])
                                                    //self.loadRTD()
                                                }
                                            }
                                            print(self.products.map({$0.productName+$0.productPrice}))
                                            
                                        } catch {
                                            print("Eek something went wrong trying to parse the html")
                                        }
                                        
                                    }
        })

    }
    



}

