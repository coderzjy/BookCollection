//
//  SwitchInput.swift
//  BookCollection
//
//  Created by zjy on 2025/3/20.
//

import UIKit

class SwitchInput: UIView {
    var title: String!
    
    var titleLabel: UILabel!
    var switchView: UISwitch!
    
    // Initial
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        
    }
    
    init(title: String!, status :Bool!){
        self.title = title
        super.init(frame: .zero)
        setUpView()
        self.titleLabel.text = title
        self.switchView.setOn(status, animated: true)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}





// MARK: - Private Function

extension SwitchInput {
    
    private func setUpView() {
        
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.text = title
        titleLabel.textColor = UIColor(rgba: "#DF912B")
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalToSuperview()
            make.height.equalToSuperview().offset(-0.5)
        }
        
        switchView = UISwitch(frame: CGRectMake(0, 0, 60, 30))
        self.addSubview(switchView)
        switchView.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.height.equalTo(30)
            make.right.equalToSuperview()
        }
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
      
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.hs.shadowColor;
        self.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.right.equalTo(switchView)
            make.bottom.equalTo(self)
            make.height.equalTo(0.5)
        }
    }
}
