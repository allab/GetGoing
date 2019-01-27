//
//  SearchResultsViewController.swift
//  GetGoingClass
//
//  Created by Alla Bondarenko on 2019-01-23.
//  Copyright © 2019 SMU. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        let nib = UINib(nibName: "SearchResultTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "SearchResultTableViewCell")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell") as? SearchResultTableViewCell else { return UITableViewCell() }

        cell.nameLabel.text = "hello"
        cell.vicinityLabel.text = "world"

        return cell
    }


}
