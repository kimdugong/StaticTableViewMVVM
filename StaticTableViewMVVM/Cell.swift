//
//  Cell.swift
//  StaticTableViewMVVM
//
//  Created by Dugong on 2021/04/11.
//

import UIKit
import RxSwift
import RxCocoa

class Cell: UITableViewCell {
    private var lable = UILabel()
    private(set) var bag: DisposeBag = DisposeBag()
    var viewModel: CellViewModel!
    
    private var button: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 35, height: 1)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private var `switch`: UISwitch = {
        let `switch` = UISwitch()
        return `switch`
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func bind() {
        viewModel.model.bind { [self] (model) in
            textLabel?.rx.text.onNext(model.title)
            
            accessoryType = model.accessoryType
            if [.detailDisclosureButton, .disclosureIndicator].contains(model.accessoryType) {
                selectionStyle = .default
            }
            
            switch model.accessoryView {
            case .button:
                accessoryView = button
                button.setTitle(model.title, for: .normal)
                break
            case .switch:
                accessoryView = `switch`
                break
            default:
                break
            }
        }
        .disposed(by: bag)

        button.rx.tap.withLatestFrom(viewModel.model).bind(to: viewModel.event).disposed(by: bag)
        `switch`.rx.isOn.withLatestFrom(viewModel.model) { ($0, $1) }.bind(to: viewModel.isOn).disposed(by: bag)
    }
    
    func setupUI() {
        selectionStyle = .none
    }

}
