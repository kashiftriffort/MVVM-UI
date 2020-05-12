//
//  TopAppsTableViewController.swift
//  MVVM-UI
//
//  Created by Kashif Jilani

import UIKit

class TopAppsTableViewController: UITableViewController {
  
  var viewModel = ViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.getApps {
      self.tableView.reloadData()
    }
  }
  
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfItemsToDisplay(in: section)
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = viewModel.appEmployeeName(for: indexPath)
    cell.detailTextLabel?.text = viewModel.appEmployeeSalary(for: indexPath)
    return cell
  }
  
}




















