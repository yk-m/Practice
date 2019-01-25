//
//  DetailViewController.swift
//  Practice
//
//  Created by sci01725 on 2018/12/20.
//  Copyright © 2018 Yuka Matsuo. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var presenter: DetailViewPresentable!
    
    @IBOutlet private weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    @IBOutlet private weak var indicator: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func showIndicator(show: Bool) {
        indicator.isHidden = !show
    }
}

extension DetailViewController: DetailView {
    
    func set(title: String) {
        navigationItem.title = title
    }
    
    func load(request urlRequest: URLRequest) {
        webView.load(urlRequest)
    }
}

extension DetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        showIndicator(show: false)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showIndicator(show: true)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        showIndicator(show: false)
    }
}
