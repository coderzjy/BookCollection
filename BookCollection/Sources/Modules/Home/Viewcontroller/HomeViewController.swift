//
//  ViewController.swift
//  BookCollection
//
//  Created by zjy on 2025/3/19.
//

import UIKit
import SwiftyJSON
 
class HomeViewController: UIViewController{

    private var tableView: UITableView!
    private var bookList: BookList = BookList()
    private var dbManager : SQLiteManager {
        let dbManager =  SQLiteManager.default
        //        dbManager.enableLog = false;
        return dbManager
    }
    private var leftBarBtnItem : UIBarButtonItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()

    }
   
}

extension HomeViewController {
    //MARK: - 加载数据
    private func loadData() {
        let arr = dbManager.select(Book.tableName)
        bookList = BookList()
        for subJson in arr {
            let jsonData = JSON(subJson)
            let book = Book.getBook(jsonData)
            bookList.books.append(book)
        }
        
        tableView.reloadData()
    }
    
    //MARK: - 添加书籍
    @objc func addBook() {
        // 处理添加书籍的逻辑
        let addBookVc = AddBookViewController(book: nil)
        addBookVc.btnBlock = { [unowned self](book) -> Void  in
            print(book)
            dbManager.insert(book)
            
            let arr = dbManager.select(Book.tableName)
            bookList.books .removeAll();
            for subJson in arr {
                let jsonData = JSON(subJson)
                let book = Book.getBook(jsonData)
                bookList.books.append(book)
            }
            tableView.reloadData()
           
        }
        
        self.navigationController?.pushViewController(addBookVc, animated: true)
    }
    
    //MARK: - 排序
    @objc func sortAction() {

        //是否升序
        var isOrder : Bool = true
        if leftBarBtnItem?.tag == 1 {
            isOrder = false
            leftBarBtnItem?.tag = 0;
            leftBarBtnItem?.title = "升序";
        }else{
            isOrder = true
            leftBarBtnItem?.tag = 1;
            leftBarBtnItem?.title = "降序";
            
        }
        
        bookList.books.sort {
            if isOrder {
                return  $0.rating > $1.rating
            }else{
                return  $0.rating < $1.rating
            }
        }
        self.tableView.reloadData()
    }
    
    private func setupUI() {
        self.view.backgroundColor = UIColor.white
        
        tableView = UITableView(frame: view.bounds)
        tableView.dataSource = self
        tableView.delegate = self;
        tableView.separatorStyle = .none
        tableView.rowHeight = 120
        tableView.register(BookTableViewCell.self)
        view.addSubview(tableView)
        
        let addButton = UIBarButtonItem(title: "添加", style: .plain, target: self, action: #selector(addBook))
        addButton.tintColor = UIColor.gray
        navigationItem.rightBarButtonItem = addButton
        
        
        leftBarBtnItem = UIBarButtonItem(title: "升序", style: .plain, target: self, action: #selector(sortAction))
        leftBarBtnItem?.tintColor = UIColor.gray
        navigationItem.leftBarButtonItem = leftBarBtnItem
    }
    
}

//MARK: - UITableViewDelegate UITableViewDataSource
extension HomeViewController : UITableViewDataSource, UITableViewDelegate{
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = bookList.books[indexPath.row];
        let viewController = AddBookViewController(book: book)
        //MARK: - 处理修改数据
        viewController.btnBlock = { [unowned self](book) -> Void  in
            dbManager.update(book)
            let arr = dbManager.select(Book.tableName)
            bookList.books .removeAll();
            for subJson in arr {
                let jsonData = JSON(subJson)
                let book = Book.getBook(jsonData)
                bookList.books.append(book)
            }
            tableView.reloadData()
           
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.books.count
    }

   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: BookTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configureCell(book: bookList.books[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        bookList.books.count > 0
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    

    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction:UIContextualAction = UIContextualAction(style: .destructive, title: "删除") { (action, sourceView, completionHandler) in
            
            let bookM =  self.bookList.books[indexPath.row]
            self.dbManager.delete(bookM)
            self.bookList.books .remove(at: indexPath.row)
            tableView.reloadData()
            completionHandler(true)
        }
        //delete操作按钮可使用UIContextualActionStyleDestructive类型，当使用该类型时，如果是右滑操作，一直向右滑动某个cell，会直接执行删除操作，不用再点击删除按钮。
        deleteAction.backgroundColor = UIColor.red
        let actions:[UIContextualAction] = [deleteAction]
        let action:UISwipeActionsConfiguration = UISwipeActionsConfiguration(actions: actions)
        // 当一直向右滑是会执行第一个action
        action.performsFirstActionWithFullSwipe = true
        
        return action
    }
    
}

