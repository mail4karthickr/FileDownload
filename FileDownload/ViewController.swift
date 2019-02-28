//
//  ViewController.swift
//  FileDownload
//
//  Created by Karthick Ramasamy on 2/24/19.
//  Copyright © 2019 Karthick Ramasamy. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let networkManager = NetworkManager()
        networkManager.getSearchResults(searchTerm: "Justin")
            .subscribe(onNext: { res in
                print("network result in \(res)")
            })
    }


}

