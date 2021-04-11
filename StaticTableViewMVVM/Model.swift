//
//  Model.swift
//  StaticTableViewMVVM
//
//  Created by Dugong on 2021/04/11.
//

import UIKit
import RxDataSources

struct SectionOfModel {
    var header: String
    var items: [Model]
}

extension SectionOfModel: SectionModelType {
    init(original: SectionOfModel, items: [Model]) {
        self = original
        self.items = items
    }
    
}

struct Model {
    let title: String
    let accessoryView: AccessoryView
    let accessoryType: UITableViewCell.AccessoryType
}

enum AccessoryView {
    case none
    case button
    case `switch`
}
