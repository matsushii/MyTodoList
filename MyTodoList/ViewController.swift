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
    var todoList = [String]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tapAddButton(_ sender: Any) {
        //  アラートダイアログを生成
        let alertController = UIAlertController(title: "ToDoの追加", message: "ToDoを入力してください", preferredStyle: UIAlertController .Style.alert)
        
        //  テキストエリアを追加
        alertController.addTextField(configurationHandler: nil)
        //  OKボタンを追加
        let okAction = UIAlertAction(title: "OK",style:  UIAlertAction.Style.default) { (action: UIAlertAction) in
            //  OKがタップされた時の処理
            if let textField = alertController.textFields?.first {
                //  ToDoの配列に入力値を挿入（先頭に挿入しする）
                self.todoList.insert(textField.text!, at:0)
                //  テーブルに行が追加されたことをテーブルに追加
                self.tableView.insertRows(at: [IndexPath(row:0, section: 0)], with: UITableView.RowAnimation.right)
            }
        }
        //  OKボタンがタップされた時の処理
        alertController.addAction(okAction)
        //  CANSELボタンがタップされた時の処理
        let cancelButton = UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.cancel, handler: nil)
        //  CANCELボタンを追加
        alertController.addAction(cancelButton)
        //  アラートダイアログを表示
        present(alertController, animated: true, completion: nil)
    }
}

