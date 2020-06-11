//
//  FiltroViewModel.swift
//  Reusable Filter
//
//  Created by Marcelly Luise on 11/06/20.
//  Copyright © 2020 Celly Inc.,. All rights reserved.
//

import UIKit

enum FiltroDataSource {
    case bancos(bancos: [Banco])
    case operacoes(operacoes: [Ocupacao])
    case empty
    
    func getBancos() -> [Banco] {
        switch self {
        case .bancos(bancos: let bancos):
            return bancos
        default:
            return []
        }
    }
    
    func getOcupacoes() -> [Ocupacao] {
        switch self {
        case .operacoes(operacoes: let operacoes):
            return operacoes
        default:
            return []
        }
    }
    
}

enum FiltroItem {
    case banco(banco: Banco)
    case operacao(operacao: Ocupacao)
    case none
}

class FiltroViewModel {

    private let dataSource: FiltroDataSource
    private var filtrados: FiltroDataSource = .empty
    private(set) var itemSelecionado: FiltroItem = .none
    private(set) var filtroDelegate: FiltroDelegate?
    
    var numberOfRows: Int {
        switch filtrados {
        case .bancos(bancos: let bancos):
            return bancos.count
        case .operacoes(operacoes: let operacoes):
            return operacoes.count
        case .empty:
            return 0
        }
    }
    
    init(dataSource: FiltroDataSource, filtroDelegate: FiltroDelegate?) {
        self.dataSource = dataSource
        self.filtroDelegate = filtroDelegate
        self.filtrados = dataSource
    }
    
    func item(at indexPath: IndexPath) -> FiltroItem {
        switch filtrados {
        case .bancos(bancos: let bancos):
            return .banco(banco: bancos[indexPath.row])
        case .operacoes(operacoes: let ocupacoes):
            return .operacao(operacao: ocupacoes[indexPath.row])
        case .empty:
            return .none
        }
    }
    
    func filtra(com busca: String) {
        switch filtrados {
        case .bancos:
            filtraBancos(with: busca)
        case .operacoes:
            filtraOcupacao(with: busca)
        case .empty:
            return
        }
    }
    
    func filtraBancos(with busca: String) {
        
        var bancosFiltrados = filtrados.getBancos()
        let bancos = dataSource.getBancos()
        
         bancosFiltrados = busca.isEmpty ? bancos : bancos.filter({ (banco: Banco) -> Bool in
            
            let encontrouPeloNome = banco.name.range(of: busca, options: .caseInsensitive, range: nil, locale: nil) != nil
            let encontrouPeloCodigo = banco.codigo.range(of: busca, options: .caseInsensitive, range: nil, locale: nil) != nil
            
            if encontrouPeloNome {
                return true
            } else if encontrouPeloCodigo {
                return true
            } else {
                
                return false
            }
        })
        
        filtrados = .bancos(bancos: bancosFiltrados)
    }
    
    func filtraOcupacao(with busca: String) {
        
        var ocupacoesFiltradas = filtrados.getOcupacoes()
        let ocupacoes = dataSource.getOcupacoes()
        
        ocupacoesFiltradas = busca.isEmpty ? ocupacoes : ocupacoes.filter({ (ocupacao: Ocupacao) -> Bool in
            
            return ocupacao.name.range(of: busca, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        
        filtrados = .operacoes(operacoes: ocupacoesFiltradas)
    }
    
    func seleciona(at indexPath: IndexPath) {
        switch filtrados {
        case .bancos(bancos: let bancosFiltrados):
            itemSelecionado = .banco(banco: bancosFiltrados[indexPath.row])
        case .operacoes(operacoes: let operacoesFiltradas):
            itemSelecionado = .operacao(operacao: operacoesFiltradas[indexPath.row])
        case .empty:
            itemSelecionado = .none
        }
    }
    
}
