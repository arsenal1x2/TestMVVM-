//
//  PersonViewModel.swift
//  AppMusic1
//
//  Created by LTT on 12/4/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import Foundation

class PersonViewModel {
    private var person: Person

    var nameText: String {
        return person.name
    }

    var ageText: String {
        return String(person.age)
    }

    init(person: Person) {
        self.person = person
    }
}
