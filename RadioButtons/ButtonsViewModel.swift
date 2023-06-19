//
//  ButtonsViewModel.swift
//  RadioButtons
//
//  Created by yeowongu on 2023/06/19.
//

import Foundation
import UIKit
import SnapKit
import Combine

class ButtonsViewModel: UIView {
    
    var nameBox: UILabel?
    var underLine: UIView?
    
    var model: ButtonsModel = ButtonsModel()
    private var cancellables = Set<AnyCancellable>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        isUserInteractionEnabled = true
        
        let nameBox = UILabel()
        nameBox.backgroundColor = .clear
        nameBox.textColor = .black
        nameBox.isUserInteractionEnabled = true
        nameBox.sizeToFit()
        addSubview(nameBox)
        
        nameBox.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(6)
        }
        
        let underLine = UIView()
        underLine.backgroundColor = .black
        addSubview(underLine)

        underLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(2)
            make.bottom.equalToSuperview()
        }
        
        self.nameBox = nameBox
        self.underLine = underLine
        
        setBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBinding() {
        
        // seletion에 대한 combine
        model.dataSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] selected in
                guard let self = self else { return }
                switch selected {
                case .select: // 버튼 선택
                    self.nameBox?.font = .systemFont(ofSize: 16, weight: .bold)
                    
                    UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                        self.underLine?.backgroundColor = .black
                    }, completion: nil)
                    
                case .deselect: // 버튼 해제
                    self.nameBox?.font = .systemFont(ofSize: 14, weight: .medium)
                    self.underLine?.backgroundColor = .clear
                }
            }.store(in: &cancellables)
    }
}
