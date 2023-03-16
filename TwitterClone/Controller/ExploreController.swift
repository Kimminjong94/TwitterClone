//
//  ExploreController.swift
//  TwitterClone
//
//  Created by 김민종 on 2023/02/17.
//

import UIKit

private let reuseIdentifier = "UserCell"

class ExploreController: UITableViewController {
    
    //MARK: - Properties
    
    private var users = [User]() {
        didSet {tableView.reloadData()}
    }
    private var filterUsers = [User]() {
        didSet { tableView.reloadData() }
    }
    
    private var isSeachMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    //MARK: - Lifecycle
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchUsers()
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isHidden = false

    }
    
    
    
    //MARK: - API
    
    func fetchUsers() {
        UserService.shared.fetchUsers { users in
            self.users = users
        }
    }
    
    
    //MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .white
         
        let imageView = UIImageView(image: UIImage(named: "icTabHomeAbled"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Seach for a user"
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }

    
}

extension ExploreController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSeachMode ? filterUsers.count : users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        
        let user = isSeachMode ? filterUsers[indexPath.row] : users[indexPath.row]
        cell.user = user
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = isSeachMode ? filterUsers[indexPath.row] : users[indexPath.row]

        let controller = ProfileController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension ExploreController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let seachText = searchController.searchBar.text?.lowercased() else {return}
        
        filterUsers = users.filter {$0.username.contains(seachText)}
        
    }
    
    
}
