//
//  AddBookViewController.swift
//  BookCollection
//
//  Created by zjy on 2025/3/20.
//

import UIKit
import SwiftyJSON

class AddBookViewController: UIViewController {
    var titleTF : TextFieldInput!
    var authorTF : TextFieldInput!
    var typeTF : TextFieldInput!
    var ratingTF : TextFieldInput!
    var switchView : SwitchInput!
    var button : UIButton!
    private var book: Book? = nil
    typealias KButtonBlock = (_ book:Book) ->()
    var btnBlock: KButtonBlock!
    
    static let textFieldHeight: CGFloat = 40
    
    lazy var backButton: UIButton = { [unowned self] in
        let button = UIButton()
        button.addTarget(self, action: #selector(naviBack), for: .touchUpInside)
        button.setImage(Asset.iconBackWhite.image, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.backgroundColor = UIColor.black.withAlphaComponent(0.6).cgColor
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = false
        }
        
        setUpView()
        
        updateData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    @objc private func naviBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    init(book: Book?) {
        super.init(nibName: nil, bundle: nil)
        self.book = book
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



// MARK: - Private Function

extension AddBookViewController {
    private func setUpView() {
        
        let containerView = UIView()
        self.view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
        
        backButton.layer.zPosition = 4
        let buttonY = UIScreen.navigationHeight - 44 + (44-30)/2
        containerView.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
            make.top.equalTo(buttonY)
            make.left.equalTo(15)
        }
        
        
        titleTF = TextFieldInput(title: "书名",placeholder: "请输入书名")
        containerView.addSubview(titleTF)
        titleTF.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(AddBookViewController.textFieldHeight)
        }
        
        authorTF = TextFieldInput(title: "作者",placeholder: "请输入作者姓名")
        containerView.addSubview(authorTF)
        authorTF.snp.makeConstraints { make in
            make.top.equalTo(titleTF.snp.bottom).offset(10)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(AddBookViewController.textFieldHeight)
        }
        
        typeTF = TextFieldInput(title: "类型",placeholder: "请输入类型")
        containerView.addSubview(typeTF)
        typeTF.snp.makeConstraints { make in
            make.top.equalTo(authorTF.snp.bottom).offset(10)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(AddBookViewController.textFieldHeight)
        }
        
        ratingTF = TextFieldInput(title: "评分",placeholder: "请输入评分 0.0 ~ 5.0")
        containerView.addSubview(ratingTF)
        ratingTF.snp.makeConstraints { make in
            make.top.equalTo(typeTF.snp.bottom).offset(10)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(AddBookViewController.textFieldHeight)
        }
        
        switchView = SwitchInput(title: "是否已读", status: false)
        containerView.addSubview(switchView)
        switchView.snp.makeConstraints { make in
            make.top.equalTo(ratingTF.snp.bottom).offset(10)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(AddBookViewController.textFieldHeight)
        }
        
        button = UIButton(type: .custom)
        button .setTitle("保存", for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor(rgba: "#fb863f")
        button .addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        containerView.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(switchView.snp.bottom).offset(30)
            make.centerX.equalTo(containerView)
            make.height.equalTo(40)
            make.width.equalTo(200)
        }
        
    }
    
    private func updateData(){
        
        titleTF.textField.text = book?.title ?? ""
        authorTF.textField.text = book?.author ?? ""
        typeTF.textField.text = book?.type ?? ""
        ratingTF.textField.text = String(book?.rating ?? 0.0)
        switchView.switchView.setOn(book?.read ?? false, animated: true)
    }
    
    @objc private func btnClick(){
        if btnBlock != nil {
            
            let average = Double(ratingTF.textField.text ?? "0.0") ?? 0.0
            
           
            var book = Book()
            book.title = titleTF.textField.text ?? ""
            book.rating = average
            book.author = authorTF.textField.text ?? ""
            book.type = typeTF.textField.text ?? ""
            book.read = switchView.switchView.isOn
            
            
            
//            let jsonData = JSON(dict)
//            let model = Book.getBook(jsonData)
           
            btnBlock(book)
            self.navigationController?.popViewController(animated: true)
        }
    }
}
