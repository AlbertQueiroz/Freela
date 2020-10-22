//
//  JobDetailsViewController.swift
//  Freela
//
//  Created by Albert Rayneer on 11/08/20.
//  Copyright © 2020 Albert Rayneer. All rights reserved.
//

import UIKit
import WebKit

class JobDetailsViewController: UIViewController, WKUIDelegate {

    var webView = WKWebView()
    weak var delegate: JobsListViewController?
    var url: URL?
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        if let url = url {
            loadURL(with: url)
        }
    }
    
    func loadURL(with url: URL) {
        let request = URLRequest(url: url)
        webView.load(request)
        
    }
}
