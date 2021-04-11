//
//  ViewController.swift
//  StaticTableViewMVVM
//
//  Created by Dugong on 2021/04/11.
//

import UIKit
import SnapKit
import RxDataSources
import RxSwift

class ViewController: UIViewController {
    private var bag: DisposeBag = DisposeBag()
    
    let sections = [
        SectionOfModel(header: "로그인", items: [
            Model(title: "로그인1", accessoryView: .none, accessoryType: .checkmark),
            Model(title: "로그인2", accessoryView: .none, accessoryType: .detailButton)
        ]),
        
        SectionOfModel(header: "로그인3", items: [
            Model(title: "로그인4", accessoryView: .button, accessoryType: .checkmark),
            Model(title: "로그인5", accessoryView: .switch, accessoryType: .none),
            Model(title: "로그인6", accessoryView: .none, accessoryType: .disclosureIndicator),
            Model(title: "로그인7", accessoryView: .none, accessoryType: .detailDisclosureButton)
        ])
    ]
    
    var viewModel: ViewModel!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModel(sections: sections)
        
        tableView.rx.setDelegate(self).disposed(by: bag)
        
        viewModel.dataSource.titleForHeaderInSection = { dataSource, index in
          return dataSource.sectionModels[index].header
        }
        
        viewModel.sections.bind(to: tableView.rx.items(dataSource: viewModel.dataSource)).disposed(by: bag)
        
        tableView.rx.itemSelected.bind { [self] (indexpath) in
            print(indexpath)
            
            tableView.deselectRow(at: indexpath, animated: true)
        }.disposed(by: bag)
        
        tableView.rx.itemAccessoryButtonTapped.bind { (indexpath) in
            print(indexpath)
        }.disposed(by: bag)
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
        }
    }
}

extension ViewController: UITableViewDelegate {
    
}
