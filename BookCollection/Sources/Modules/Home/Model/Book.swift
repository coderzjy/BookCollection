//
//  Book.swift
//  BookCollection
//
//  Created by zjy on 2025/3/19.
//

import SwiftyJSON

struct BookList {
    var books: [Book] = []
    var count: Int = 0
    var start: Int = 0
    var total: Int = 0
    
    static func getBookList(json: JSON) -> BookList {
        var bookList = BookList()
        bookList.count = json["count"].intValue
        bookList.start = json["start"].intValue
        bookList.total = json["total"].intValue
        for (_, subJson): (String, JSON) in json["books"] {
            let book = Book.getBook(subJson)
            bookList.books.append(book)
        }
        
        return bookList
    }
}

struct Book :SQLiteProtocol{
    static var tableName: String {
        return "Book"
    }
    init(_ dict: [String : Any]) {}
    init() {}
    
    var title = ""
    var type = ""
    var image = ""
    var author = ""//作者姓名
    var rating = 0.0
    var read = false//阅读状态
    var summary = ""//摘要
    
    static func getBook(_ json: JSON) -> Book {
        var book = Book()
        book.title = json["title"].stringValue
        book.read = json["read"].boolValue
        book.type = json["type"].stringValue
        book.image = json["image"].stringValue
        book.author = json["author"].stringValue
        book.summary = json["summary"].stringValue
        book.rating = json["rating"].doubleValue
        
        return book
    }
    
    var uniqueKeys: [String]? {
        return ["title"]
    }
}

