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
    
    //MARK: - Lifecycle
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchUsers()
    }
    
    //MARK: - API
    
    func fetchUsers() {
        UserService.shared.fetchUsers { users in
//            users.forEach { user in
//                print("Debug user is \(user.username)")
//            }
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

    
}

extension ExploreController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        cell.user = users[indexPath.row]
        
        return cell
    }
    
}
