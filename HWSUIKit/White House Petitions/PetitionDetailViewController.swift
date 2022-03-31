//
//  PetitionDetailViewController.swift
//  HWSUIKit
//
//  Created by Johan Forsell on 2022-03-31.
//

import UIKit
import WebKit

class PetitionDetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let detailItem = detailItem else { return }

        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style>
            p {
                font: sans-serif;
                font-size: 1.2em;
                padding: 4px 14px;
            }
        
            div {
                background-color: rgb(249, 171, 66);
                padding: 0;
                margin: 0;
            }
        
            body {
                padding: 0;
                margin: 0;
            }
            
            h1 {
                color: white;
                font-size: 1.5em;
                padding: 0 14px;
            }
        </style>
        </head>
        <body>
        <div>
        <h1>\(detailItem.title)</h1>
        </div>
        <p>\(detailItem.body)</p>
        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
    }
}
