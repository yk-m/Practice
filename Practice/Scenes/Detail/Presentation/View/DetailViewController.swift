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
    private var defaultNavigationBarBackgroundColor: UIColor? = nil
    
    @IBOutlet private weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        defaultNavigationBarBackgroundColor = UINavigationBar.appearance().tintColor
        UINavigationBar.appearance().tintColor = .dark
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UINavigationBar.appearance().tintColor = defaultNavigationBarBackgroundColor
        navigationController?.navigationBar.prefersLargeTitles = true
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
