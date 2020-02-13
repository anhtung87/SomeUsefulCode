//
//  SeperatedViewController.swift
//  SomeUsefulCode
//
//  Created by Hoang Tung on 2/13/20.
//  Copyright © 2020 Hoang Tung. All rights reserved.
//

import UIKit

/// Giao thức HasCustomView xác định thuộc tính customView cho UIViewControllers được sử dụng để thay đổi thuộc tính view.
public protocol HasCustomView {
  associatedtype CustomView: UIView
}

extension HasCustomView where Self: UIViewController {
  /// The UIViewController's custom view.
  public var customView: CustomView {
    guard let customView = view as? CustomView else {
      fatalError("Expected view to be of type \(CustomView.self) but got \(type(of: view)) instead")
    }
    return customView
  }
}

class SeperatedViewController: UIViewController, HasCustomView {
//  typealias cho phép chúng ta cung cấp một tên mới cho một loại dữ liệu hiện có. Trong case này là MyView.
  typealias CustomView = MyView
  
  override func loadView() {
    let customView = CustomView()
    view = customView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // khai báo và dựng layout cho các view con
    view.backgroundColor = .white
    customView.setupLayout()
  }
}

class MyView: UIView {
  
  let redView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .systemRed
    return view
  }()
  
  let blueView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .systemBlue
    return view
  }()
  
  let greenView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .systemGreen
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupView() {
    self.addSubview(redView)
    self.addSubview(blueView)
    self.addSubview(greenView)
  }
  
  func setupLayout() {
    redView.topAnchor.constraint(equalTo: self.topAnchor, constant: 200).isActive = true
    redView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 64).isActive = true
    redView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -64).isActive = true
    redView.heightAnchor.constraint(equalToConstant: 64).isActive = true
    
    blueView.topAnchor.constraint(equalTo: redView.bottomAnchor, constant: 64).isActive = true
    blueView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 64).isActive = true
    blueView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -64).isActive = true
    blueView.heightAnchor.constraint(equalToConstant: 64).isActive = true
    
    greenView.topAnchor.constraint(equalTo: blueView.bottomAnchor, constant: 64).isActive = true
    greenView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 64).isActive = true
    greenView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -64).isActive = true
    greenView.heightAnchor.constraint(equalToConstant: 64).isActive = true
  }
  
}
