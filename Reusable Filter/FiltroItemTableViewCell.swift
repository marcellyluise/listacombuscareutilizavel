//
//  FiltroItemTableViewCell.swift
//  Reusable Filter
//
//  Created by Marcelly Luise on 11/06/20.
//  Copyright © 2020 Celly Inc.,. All rights reserved.
//

import UIKit

class FiltroCellViewModel {
    
    private var item: FiltroItem
    
    init(filtroItem: FiltroItem) {
        self.item = filtroItem
    }
    
    var title: String? {
        switch item {
        case .banco(banco: let banco):
            return banco.name
        case .operacao(operacao: let operacao):
            return operacao.name
        case .none:
            return nil
        }
    }
    
    var subTitle: String? {
        switch item {
        case .banco(banco: let banco):
            return banco.codigo
        case .operacao, .none:
            return nil
        }
    }
}

class FiltroItemTableViewCell: UITableViewCell {

    @IBOutlet private weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    var viewModel: FiltroCellViewModel = .init(filtroItem: .none) {
        didSet {
            loadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    private func loadData() {
        title.text = viewModel.title
        subTitle.text = viewModel.subTitle
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
