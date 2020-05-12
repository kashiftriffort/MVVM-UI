//
//  ViewModel.swift
//  MVVM-UI
//
//  Created by Kashif Jilani

import UIKit

//1 - Setup my viewModel that inherits from NSObject
class ViewModel: NSObject {
  
  var apps: [NSDictionary]?  
  let netProvider: NetworkServiceProvider = APIClient()
  
  //4 - This function is what directly accesses the apiClient to make the API call
  func getApps(completion: @escaping () -> Void) {
    
    netProvider.retrieveList {
      switch $0 {
      case .failure:
        print("failed items")
      case let .success(apps):
        self.apps = apps
        DispatchQueue.main.async {
          completion()
        }
      }
    }    
  }
  
  // MARK: - values to display in our table view controller
  //9 -
  func numberOfItemsToDisplay(in section: Int) -> Int {
    return apps?.count ?? 0
  }
  
  //10 -
  func appEmployeeName(for indexPath: IndexPath) -> String {
    return apps?[indexPath.row].value(forKeyPath: "employee_name") as? String ?? ""
  }
  
  //11 -
  func appEmployeeSalary(for indexPath: IndexPath) -> String {
    return apps?[indexPath.row].value(forKeyPath: "employee_salary") as? String ?? ""
  }
  
}
















