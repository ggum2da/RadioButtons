//
//  ViewController.swift
//  RadioButtons
//
//  Created by yeowongu on 2023/06/19.
//

import UIKit
import SnapKit


class ViewController: UIViewController {
    
    private lazy var myScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .never
        
        return scrollView
    }()
    
    private lazy var myStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.axis = .horizontal
        stackView.spacing = 28
        stackView.isUserInteractionEnabled = true
        stackView.layoutMargins = UIEdgeInsets(top: .zero, left: 16, bottom: .zero, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    
    private var selectedView: ButtonsViewModel?
    
    private let list: [String] = ["월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(myScrollView)
        myScrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(50)
        }
        
        myScrollView.addSubview(myStackView)
        myStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview().offset(-2)
        }
        
        createButtons()
    }
}

extension ViewController {
    
    func createButtons() {
        
        for i in 0..<list.count {
            
            let buttonsView = ButtonsViewModel()
            buttonsView.nameBox?.text = list[i]
            myStackView.addArrangedSubview(buttonsView)
            
            buttonsView.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.height.equalTo(24)
            }
            
            let isSelected: ButtonsModel.selection = i == 0 ? .select : .deselect
            buttonsView.model.dataSubject.send(isSelected)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(tappedView))
            tap.numberOfTapsRequired = 1
            tap.numberOfTouchesRequired = 1
            buttonsView.addGestureRecognizer(tap)
            
            if i == 0 {
                selectedView = buttonsView
            }
        }
    }
    
    @objc private func tappedView(recognizer: UITapGestureRecognizer) {
        if let view = recognizer.view as? ButtonsViewModel, view != selectedView {
            print(#function, #line)
            
            view.model.dataSubject.send(.select) // 선택된 buttonView
            selectedView?.model.dataSubject.send(.deselect) // 이전 선택되어 있었던 selectedView
            selectedView = view // 선택된 view를 selectedView에 넣어줌
        }
    }
}

