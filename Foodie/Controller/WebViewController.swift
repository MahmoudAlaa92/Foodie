//
//  WebViewController.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 05/08/2024.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var targetUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: targetUrl){
            let request = URLRequest(url: url)
            webView.load(request)
        }
        
    }
    

}
