//
//  TextFieldInput.swift
//  BookCollection
//
//  Created by zjy on 2025/3/20.
//

import UIKit

class TextFieldInput: UIView {
    var title: String!
    var placeholder: String!
    
    var titleLabel: UILabel!
    var textField: UITextField!
    
    // Initial
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        
    }
    
    init(title: String!,placeholder:String!){
        self.title = title
        self.placeholder = placeholder
        super.init(frame: .zero)
        setUpView()
        self.titleLabel.text = title
        self.textField.placeholder = placeholder;
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


// MARK: - Function

extension TextFieldInput {
 
}


// MARK: - Private Function

extension TextFieldInput {
    
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
        
        textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.right).offset(10)
            make.top.equalTo(self)
            make.height.equalTo(titleLabel)
            make.right.equalToSuperview()
        }
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
      
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.hs.shadowColor;
        self.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.right.equalTo(textField)
            make.bottom.equalTo(self)
            make.height.equalTo(0.5)
        }
    }
}
