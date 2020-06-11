//
//  MainViewController.swift
//  Reusable Filter
//
//  Created by Marcelly Luise on 11/06/20.
//  Copyright © 2020 Celly Inc.,. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet private weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    private func getOcupacoes() -> [Ocupacao] {
        let engenheiro = Ocupacao(name: "Engenheiro")
        let medico = Ocupacao(name: "Médico")
        let bancario = Ocupacao(name: "Bancário")
        let musico = Ocupacao(name: "Músico")
        
        return [engenheiro, medico, bancario, musico]
    }
    
    private func getBancos() -> [Banco] {
        let inter = Banco(name: "Banco Inter", codigo: "77")
        let caixa = Banco(name: "Caixa", codigo: "003")
        let santander = Banco(name: "Santander", codigo: "033")
        let itau = Banco(name: "Banco Itau", codigo: "043")
        let bancoDoBrasil = Banco(name: "Banco do Brasil", codigo: "001")
        
        return [inter, caixa, santander, itau, bancoDoBrasil]
    }
    
    @IBAction func filtraOcupacoes(_ sender: Any) {
        showFiltroController(with: .operacoes(operacoes: getOcupacoes()))
    }
    
    @IBAction func filtraBancos(_ sender: Any) {
        showFiltroController(with: .bancos(bancos: getBancos()))
    }
    
    private func showFiltroController(with dataSource: FiltroDataSource) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
    
        guard let viewController = storyboard.instantiateViewController(identifier: String(describing: FiltroViewController.self)) as? FiltroViewController else { return }
        
        let filtroViewModel = FiltroViewModel(dataSource: dataSource, filtroDelegate: self)
        
        viewController.viewModel = filtroViewModel
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension MainViewController: FiltroDelegate {
    func didSelect(filtroItem: FiltroItem) {
        switch filtroItem {
        case .banco(banco: let banco):
            label.text = "Banco selecionado: \(banco.name) e código: \(banco.codigo)"
        case .operacao(operacao: let ocupacao):
            label.text = "Ocupacao selecionada: \(ocupacao.name)"
        default:
            break
        }
    }
}


