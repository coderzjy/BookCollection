//
//  Author.swift
//  BookCollection
//
//  Created by zjy on 2025/3/19.
//

import Foundation
import SwiftyJSON

struct Author {
    var name = ""
    var isBanned = false
    var isSuicide = false
    var url = ""
    var avatar = ""
    var uid = ""
    var alt = ""
    var type = "" // user
    var id = ""
    var largeAvatar = ""
    
    static func getAuthor(json: JSON) -> Author {
        var author = Author()
        author.name = json["name"].stringValue
        author.isBanned = json["is_banned"].boolValue
        author.isSuicide = json["is_suicide"].boolValue
        author.url = json["url"].stringValue
        author.avatar = json["avatar"].stringValue
        author.uid = json["uid"].stringValue
        author.alt = json["alt"].stringValue
        author.type = json["type"].stringValue
        author.id = json["id"].stringValue
        author.largeAvatar = json["large_avatar"].stringValue
        return author
    }
}
