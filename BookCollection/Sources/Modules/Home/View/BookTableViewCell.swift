//
//  BookTableViewCell.swift
//  BookCollection
//
//  Created by zjy on 2025/3/19.
//

import UIKit
import SnapKit

class BookTableViewCell: UITableViewCell {

    var bookImage: UIImageView!
    var title: UILabel!
    var tagLabel: CustomPaddingLabel!//类型
    var author: UILabel!
    var commentNum: UILabel!
    var rateHolderView: UIView!
    var rate: UILabel!
    var holdView: UIView!
    var shadowView: UIView!
    var summary: UILabel!
    var statusImage: UIImageView!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BookTableViewCell {
    
    func configureCell(book: Book) {
        title.text = book.title
        author.text = book.author
        RatingView.showInView(view: rateHolderView, value: book.rating)
        rate.text = String(book.rating)
        summary.text = book.summary
//        bookImage.backgroundColor = UIColor.red
        statusImage.image = book.read ? UIImage(named: "read") : UIImage(named: "unread")
        tagLabel.text = book.type
    }
    
    private func setUp() {
        shadowView = UIView()
            .hs.adhere(toSuperView: contentView)
            .hs.config({ (view) in
                view.backgroundColor = UIColor.clear
                view.layer.shadowColor = UIColor.hs.shadowColor.cgColor
                view.layer.shadowOpacity = 1
                view.layer.shadowRadius = 5
                view.layer.shadowOffset = CGSize.zero
                view.layer.masksToBounds = false
            })
            .hs.layout { (make) in
                make.edges.equalTo(UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15))
        }
        
        holdView = UIView()
            .hs.adhere(toSuperView: shadowView)
            .hs.config({ (view) in
                view.backgroundColor = UIColor.white
                view.layer.cornerRadius = 8
                view.layer.masksToBounds = true
            })
            .hs.layout { (make) in
                make.edges.equalToSuperview()
        }
        
        bookImage = UIImageView()
            .hs.adhere(toSuperView: holdView)
            .hs.layout(snapKitMaker: { (make) in
                make.centerY.equalToSuperview()
                make.right.equalTo(-10)
                make.height.equalTo(90)
                make.width.equalTo(63)
            })
        title = UILabel()
            .hs.adhere(toSuperView: holdView)
            .hs.config({ (label) in
                label.numberOfLines = 1
                label.font = UIFont.systemFont(ofSize: 16)
            })
            .hs.layout(snapKitMaker: { (make) in
                make.top.equalTo(bookImage.snp.top)
                make.left.equalTo(5)
            })
        
        tagLabel = CustomPaddingLabel()
            .hs.adhere(toSuperView: holdView)
            .hs.config({ (label) in
                label.numberOfLines = 1
                label.textColor = UIColor.white
                label.font = UIFont.systemFont(ofSize: 10)
                label.layer.masksToBounds = true
                label.layer.cornerRadius = 3
                label.backgroundColor = UIColor.orange
                label.contentEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
            })
            .hs.layout(snapKitMaker: { (make) in
                make.top.equalTo(title.snp.top)
                make.left.equalTo(title.snp.right).offset(2)
                make.right.lessThanOrEqualTo(bookImage.snp.left).offset(-5)
            })
        
        author = UILabel()
            .hs.adhere(toSuperView: holdView)
            .hs.config({ (label) in
                label.font = UIFont.systemFont(ofSize: 14)
                label.textColor = UIColor.hs.minorBlack
            })
            .hs.layout(snapKitMaker: { (make) in
                make.top.equalTo(title.snp.bottom).offset(5)
                make.left.equalTo(title.snp.left)
            })
        rateHolderView = UIView()
            .hs.adhere(toSuperView: holdView)
            .hs.layout(snapKitMaker: { (make) in
                make.height.equalTo(12)
                make.width.equalTo(68)
                make.top.equalTo(author.snp.bottom).offset(5)
                make.left.equalTo(title.snp.left)
            })
        rate = UILabel()
            .hs.adhere(toSuperView: holdView)
            .hs.config({ (label) in
                label.font = UIFont.systemFont(ofSize: 14)
                label.textColor = UIColor(rgba: "#DF912B")
            })
            .hs.layout(snapKitMaker: { (make) in
                make.centerY.equalTo(rateHolderView)
                make.left.equalTo(rateHolderView.snp.right).offset(4)
            })
        summary = UILabel()
            .hs.adhere(toSuperView: holdView)
            .hs.config({ (label) in
                label.font = UIFont.systemFont(ofSize: 12)
                label.textColor = UIColor.hs.minorFontLightBlack
                label.numberOfLines = 0
            })
            .hs.layout(snapKitMaker: { (make) in
                make.top.equalTo(rateHolderView.snp.bottom).offset(5)
                make.right.equalTo(bookImage.snp.left).offset(-5)
                make.left.equalTo(title.snp.left)
                make.bottom.equalTo(-5)
            })
        
        statusImage = UIImageView()
        holdView.addSubview(statusImage)
        statusImage.snp.makeConstraints({ make in
            make.top.equalTo(0)
            make.right.equalTo(-0)
            make.width.equalTo(35)
            make.height.equalTo(statusImage.snp.width).multipliedBy(0.789)
        })
    }
}



class CustomPaddingLabel: UILabel {
    // 定义内边距属性
    var contentEdgeInsets: UIEdgeInsets = .zero

    override func drawText(in rect: CGRect) {
        // 根据内边距调整绘制区域
        let insets = UIEdgeInsets(top: contentEdgeInsets.top, left: contentEdgeInsets.left, bottom: contentEdgeInsets.bottom, right: contentEdgeInsets.right)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += contentEdgeInsets.top + contentEdgeInsets.bottom
        contentSize.width += contentEdgeInsets.left + contentEdgeInsets.right
        return contentSize
    }
}
