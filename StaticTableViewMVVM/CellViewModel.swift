//
//  CellViewModel.swift
//  StaticTableViewMVVM
//
//  Created by Dugong on 2021/04/11.
//

import UIKit
import RxSwift

class CellViewModel {
    private let bag = DisposeBag()
    var model: BehaviorSubject<Model>
    var event: PublishSubject<Model>
    var isOn: PublishSubject<(Bool, Model)>
    
    init(model: Model) {
        self.model = BehaviorSubject<Model>(value: model)
        self.event = PublishSubject<Model>()
        self.isOn = PublishSubject<(Bool, Model)>()
        bind()
    }
    
    private func bind() {
        event.throttle(.seconds(1), latest: true, scheduler: MainScheduler.instance).debug().subscribe().disposed(by: bag)
        isOn.debug().subscribe().disposed(by: bag)
    }
}
