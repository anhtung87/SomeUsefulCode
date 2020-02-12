//
//  ViewController.swift
//  SomeUsefulCode
//
//  Created by Hoang Tung on 2/12/20.
//  Copyright © 2020 Hoang Tung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var tools: [Tool]?
  
  let toolTableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupData()
    setupTableView()
    setupNavigation()
  }

  func setupTableView() {
    view.addSubview(toolTableView)
    
    toolTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
    toolTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
    toolTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    toolTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    
    toolTableView.delegate = self
    toolTableView.dataSource = self
  }
  
  func setupData() {
    tools = [
      Tool(subject: "Hide keyboard when touch around", scene: HideKeyboardViewController()),
      Tool(subject: "Change hex string to RGB Colour", scene: HexColorViewController())
    ]
  }
  
  func setupNavigation() {
    navigationController?.navigationBar.topItem?.title = "Some useful code"
  }
  
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tools!.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.textLabel?.text = tools![indexPath.row].subject
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    navigationController?.pushViewController(tools![indexPath.row].scene, animated: true)
  }
}
