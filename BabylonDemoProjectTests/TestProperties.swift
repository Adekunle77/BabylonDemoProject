//
//  TestProperties.swift
//  BabylonDemoProjectTests
//
//  Created by Ade Adegoke on 30/06/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation
import CoreData
@testable import BabylonDemoProject

class TestProperties {
    func authorItem() -> User {
        let geo = Geo(latitude: "-37.3159", longitude: "81.1496")
        let address = Address(street: "Kulas Light", suite: "Apt. 556", city: "Gwenborough",
                              zipcode: "92998-3874",
                              geocode: geo)
        let company = Company(name: "Romaguera-Crona",
                              catchPhrase: "Multi-layered client-server neural-net",
                              bachelorScience: "harness real-time e-markets")
        let author = User(identification: 1,
                                 name: "Bret", username: "Leanne Graham",
                                 email: "Sincere@april.biz",
                                 address: address, phone: "1-770-736-8031 x56442",
                                 website: "hildegard.org",
                                 company: company)
        return author
    }

    func commentItem() -> Comment {
        let comments = Comment(postId: 1, identification: 1,
                                     name: "id labore ex et quam laborum",
                                     email: "Eliseo@gardner.biz",
                                     body: """
                                            laudantium enim quasi est quidem magnam voluptate ipsam
                                            eos\ntempora quo necessitatibus\ndolor
                                            quam autem quasi\nreiciendis
                                            et nam sapiente accusantium
                                        """)
        return comments
    }

    func postItem() -> Posts {
        let posts = Posts(userId: 1,
                                identification: 1,
                                body: """
                                    quia et suscipit\nsuscipit recusandae consequuntur expedita et
                                    cum\nreprehenderit molestiae ut ut
                                    quas totam\nnostrum rerum est autem sunt rem eveniet architecto
                                    """,
                                title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
        return posts
    }
}
