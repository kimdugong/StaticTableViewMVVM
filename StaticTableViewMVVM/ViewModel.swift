//
//  ViewModel.swift
//  StaticTableViewMVVM
//
//  Created by Dugong on 2021/04/11.
//

import Foundation
import RxSwift
import RxDataSources

class ViewModel {
    private var bag: DisposeBag = DisposeBag()
    let sections: BehaviorSubject<[SectionOfModel]>
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionOfModel>(
        configureCell: { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
            cell.viewModel = CellViewModel(model: item)
            cell.bind()
            return cell
        })
    
    init(sections: [SectionOfModel]) {
        self.sections = BehaviorSubject<[SectionOfModel]>(value: sections)
        bind()
    }
    
    private func bind() {

    }
}
