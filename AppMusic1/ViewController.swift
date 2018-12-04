//
//  ViewController.swift
//  AppMusic1
//
//  Created by LTT on 12/4/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    @IBOutlet weak var personTableView: UITableView!
    @IBOutlet weak var searchbar: UISearchBar!
    var persons: [PersonViewModel]?
    var showPerson: [PersonViewModel]?
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
    }

    func setupSearchBar() {
        searchbar
            .rx.text // Observable property
            .orEmpty // Make it non-optional
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .distinctUntilChanged() // If they didn't occur, check if the new value is the same as old.
            .filter { !$0.isEmpty } // If the new value is really new, filter for non-empty query.
            .subscribe(onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                self.showPerson = self.persons?.filter({ (person) -> Bool in
                    person.nameText.hasPrefix(query)
                })
                self.personTableView.reloadData() // And reload table view data.
            })
            .disposed(by: disposeBag)
    }

    func loadData() {
        var personsModel = [PersonViewModel]()
        var arrayNamePerson = ["Ronaldo", "Messi", "Dimaria"]
        var arrayAgePerson = [11, 12, 13]
        for index in 0 ..< arrayNamePerson.count {
            let person = Person(name: arrayNamePerson[index], age: arrayAgePerson[index])
            let personViewModel = PersonViewModel(person: person)
            personsModel.append(personViewModel)

        }
        DispatchQueue.main.async {
            self.persons = personsModel
            self.personTableView.reloadData()
        }
    }

    func setupTableView() {
        loadData()
        personTableView.dataSource = self
        personTableView.delegate = self
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let persons = showPerson else { return 0 }
        return persons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = personTableView.dequeueReusableCell(withIdentifier: "cellID") as? PersonTableViewCell else {
            return UITableViewCell()
        }
        cell.configCell(person: showPerson![indexPath.row])
        return cell
    }
}
