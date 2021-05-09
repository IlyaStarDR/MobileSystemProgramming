//
//  BookFullInfoViewController.swift
//  MobileSystemProgramming
//
//  Created by Illia Starodubtcev on 17.04.2021.
//

import UIKit

class BookFullInfoViewController: UIViewController {
    
    static func create(with book: BookInfo) -> BookFullInfoViewController {
        let controller = UIStoryboard(name: "Main", bundle: Bundle.main) .instantiateViewController(withIdentifier: "BookFullInfoViewController") as! BookFullInfoViewController
        controller.bookInfo = book
        return controller
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bookImageView: UIImageView!
    
    var bookInfo: BookInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookImageView.image = bookInfo.bookImage
        tableView.register(UINib(nibName: "BookInfoTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "BookInfoTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension BookFullInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookInfo.getFullInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookInfoTableViewCell", for: indexPath) as? BookInfoTableViewCell else {
            return UITableViewCell()
        }
        let data = bookInfo.getFullInfo[indexPath.row]
        cell.configure(field: data.field, value: data.value)
        return cell
    }
}
