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
    //  テーブルの行数を返却する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //  ToDoの配列の長さを返却する
        return todoList.count
    }
    //  テーブルの行ごとのセルを返却する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //  StoryBoardで指定したtodoCellのき識別子を利用して再利用可能なセルを取得する
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        //  行番号にあったToDoのタイトルを取得
        let todoTitle = todoList[indexPath.row]
        //  セルのラベルにToDoのタイトルをセット
        cell.textLabel?.text = todoTitle
        return cell
    }
    
}

