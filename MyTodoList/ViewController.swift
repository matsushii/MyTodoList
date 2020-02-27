//
//  ViewController.swift
//  MyTodoList
//
//  Created by M.Atsuhi on 2020/02/24.
//  Copyright © 2020 M.Atsuhi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    //  ToDoを格納した配列
    var todolist = [String]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

