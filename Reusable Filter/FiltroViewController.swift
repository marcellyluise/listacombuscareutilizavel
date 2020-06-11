//
//  FiltroViewController.swift
//  Reusable Filter
//
//  Created by Marcelly Luise on 11/06/20.
//  Copyright © 2020 Celly Inc.,. All rights reserved.
//

import UIKit

protocol FiltroDelegate: class {
    func didSelect(filtroItem: FiltroItem)
}

class FiltroViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet private weak var tableView: UITableView!
    
    private var searchBar = UISearchBar()
    private weak var filtroDelegate: FiltroDelegate?
    
    var viewModel: FiltroViewModel = FiltroViewModel(dataSource: .empty, filtroDelegate: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearch()
        setupDelegate()
        registerCell()
    }
    
    private func registerCell() {
        tableView.register(UINib(nibName: "FiltroItemTableViewCell", bundle: .main), forCellReuseIdentifier: "FiltroItemTableViewCell")
    }
    
    private func setupDelegate() {
        filtroDelegate = viewModel.filtroDelegate
    }

    private func setupSearch() {
        searchBar.sizeToFit()
        searchBar.delegate = self
        
        addSearchBar()
        
    }
    
    private func addSearchBar() {
        navigationItem.titleView = searchBar
    }
    
    private func removeSearchBar() {
        navigationItem.titleView = nil
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filtra(com: searchText)
        
        tableView.reloadData()
    }
}

extension FiltroViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FiltroItemTableViewCell", for: indexPath) as? FiltroItemTableViewCell else { return UITableViewCell() }
        
        cell.viewModel = FiltroCellViewModel(filtroItem: viewModel.item(at: indexPath))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        viewModel.seleciona(at: indexPath)
        filtroDelegate?.didSelect(filtroItem: viewModel.itemSelecionado)
        navigationController?.popViewController(animated: true)
    }
    
}
