//
//  TicketsController.swift
//  Tickets
//
//  Created by Mohammed Iskandar on 23/10/2020.
//

import UIKit

struct Register: Encodable {
    let name: String
    let pin: Int
    let password: String
    let email: String
}

class TicketsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell")
        
        return cell!
    }
    
    override func viewDidLoad() {
        tableView.rowHeight = 200
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(toAddTickets(_:)))
    }
    
    @objc func toAddTickets(_ sender: UIViewController){
        performSegue(withIdentifier: "toAddTickets", sender: nil)
    }
}
