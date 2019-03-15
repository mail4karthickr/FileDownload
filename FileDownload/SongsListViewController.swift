//
//  SongsListViewController.swift
//  FileDownload
//
//  Created by Karthick Ramasamy on 2/27/19.
//  Copyright © 2019 Karthick Ramasamy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SongsListViewController: UIViewController, StoryboardInitializable {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var disposeBag = DisposeBag()
    var viewModel: SongsListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar
            .rx
            .text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(to: viewModel.searchTerm)
            .disposed(by: disposeBag)
        
        viewModel.tracks
            .drive(tableView.rx.items(cellIdentifier: "Cell")) { _, track, cell in
                cell.textLabel?.text = track.trackName
            }
            .disposed(by: disposeBag)
    }
}
