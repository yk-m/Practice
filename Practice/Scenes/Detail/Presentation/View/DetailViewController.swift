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
    
    @IBOutlet private weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
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

