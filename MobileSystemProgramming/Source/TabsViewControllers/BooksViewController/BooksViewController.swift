//
//  CinemaViewController.swift
//  MobileSystemProgramming
//
//  Created by Illia Starodubtcev on 14.03.2021.
//

import UIKit

class BooksViewController: UIViewController {
    
    @IBOutlet weak var addBook: UIBarButtonItem!
    @IBOutlet weak var notFoundLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var booksTableView: UITableView!
    var books: [BookInfo] = []
    var filteredBooks: [BookInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        books = getBooks()
        booksTableView.register(UINib(nibName: "BookTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "BookTableViewCell")
        booksTableView.reloadData()
        booksTableView.delegate = self
        booksTableView.dataSource = self
        filteredBooks = books
        searchBar.delegate = self
        notFoundLabel.isHidden = true
    }
    
    @IBAction func addBookAction(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add book", message: "", preferredStyle: .alert)
        alert.view.backgroundColor = .cyan
        
        alert.addTextField {
            $0.placeholder = "Book title"
        }
        alert.addTextField {
            $0.keyboardType = .numberPad
            $0.placeholder = "Price"
        }
        alert.addTextField {
            $0.placeholder = "Author"
        }
        
        alert.addAction(UIAlertAction(title: "Exit", style: .cancel))
        alert.addAction(UIAlertAction(title: "Add", style: .default) { [weak alert, weak self] _ in
            
            guard let title = alert?.textFields?[0].text,
                  let price = alert?.textFields?[1].text,
                  let subtitle = alert?.textFields?[2].text else {
                return
            }
            
            guard let priceBook = Float(price),
                  (0...Float.greatestFiniteMagnitude).contains(priceBook) else {
                
                let alert = UIAlertController(title: "Wrong price", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
                return
            }
            
            let addedBook = BookInfo(title: title, subtitle: subtitle, price: "$" + String(round(priceBook * 100) / 100.0))
            self?.books.append(addedBook)
            self?.filteredBooks.append(addedBook)
            self?.notFoundLabel.isHidden = true
            self?.booksTableView.isHidden = false
            self?.booksTableView.reloadData()
        })
        
        present(alert, animated: true)
        
    }
    
    func getBooks() -> [BookInfo] {
        
        do {
            if let path = Bundle.main.path(forResource: "BooksList", ofType: "txt"),
               let jsonData = try String(contentsOfFile: path, encoding: String.Encoding.utf8).data(using: .utf8) {
                
                let decodedData = try JSONDecoder().decode(Books.self, from: jsonData)
                return decodedData.books
            }
        } catch {
            print("Error: ", error.localizedDescription)
        }
        
        return []
    }
    
    func getBook(with id: String) -> BookInfo? {
        
        guard !id.isEmpty else {
            return nil
        }
        
        do {
            if let path = Bundle.main.path(forResource: id, ofType: "txt"),
               let jsonData = try String(contentsOfFile: path, encoding: String.Encoding.utf8).data(using: .utf8) {
                
                let decodedData = try JSONDecoder().decode(BookInfo.self, from: jsonData)
                return decodedData
            }
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
}



extension BooksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBookId = filteredBooks[indexPath.row].isbn13
        if let selectedBook = getBook(with: selectedBookId) {
            let controller = BookFullInfoViewController.create(with: selectedBook)
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath) as? BookTableViewCell else {
            return UITableViewCell()
        }
        let book = filteredBooks[indexPath.row]
        cell.book = book
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let bookToBeDelete = filteredBooks.remove(at: indexPath.row)
            books.removeAll { book in
                return book.isbn13 == bookToBeDelete.isbn13
            }
            booksTableView.reloadData()
            notFoundLabel.isHidden = !filteredBooks.isEmpty
            booksTableView.isHidden = filteredBooks.isEmpty
        }
        
    }
    
}

extension BooksViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredBooks = searchText.isEmpty ? books : books.filter {
            $0.title.lowercased().contains(searchText.lowercased())
        }
        notFoundLabel.isHidden = !filteredBooks.isEmpty
        booksTableView.isHidden = filteredBooks.isEmpty
        booksTableView.reloadData()
    }
}
