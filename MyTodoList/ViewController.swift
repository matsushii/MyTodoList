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
    var todoList = [MyTodo]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  保存しているToDoの読み込み処理
        let userDefaults = UserDefaults.standard
        if let storedTodoList = userDefaults.object(forKey: "todoList") as? Data {
            do {
                if let unachiveTodoList = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, MyTodo.self], from: storedTodoList) as? [MyTodo] {
            todoList.append(contentsOf: unachiveTodoList)
                }
            } catch {
                //  エラー処理なし
            }
        }
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
                //  ToDoの配列に入力値を挿入（先頭に挿入する）
                let myTodo = MyTodo()
                myTodo.todoTitle = textField.text!
                self.todoList.insert(myTodo, at:0)
                //  テーブルに行が追加されたことをテーブルに通知
                self.tableView.insertRows(at: [IndexPath(row:0, section: 0)], with: UITableView.RowAnimation.right)
                //  ToDoの保存処理
                let userDefaults = UserDefaults.standard
                //  Data型にシリアライズする
                do {
                    let data = try NSKeyedArchiver.archivedData(withRootObject: self.todoList, requiringSecureCoding: true)
                    userDefaults.set(data, forKey: "todoList")
                    userDefaults.synchronize()
                } catch {
                    //  エラー処理なし
                }
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
        //  行番号にあったToDoの情報を取得
        let myTodo = todoList[indexPath.row]
        //  セルのラベルにToDoのタイトルをセット
        cell.textLabel?.text = myTodo.todoTitle
        if myTodo.todoDone {
            //  チェックあり
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        } else {
            //  チェックなし
            cell.accessoryType = UITableViewCell.AccessoryType.none
        }
        return cell
    }
    //  セルをタップした時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myTodo = todoList[indexPath.row]
        if myTodo.todoDone {
            //  完了済みの場合は未完了に変更
            myTodo.todoDone = false
        } else {
            //  未完了の場合は完了済みに変更
            myTodo.todoDone = true
        }
        //  セルの状態を変更
        tableView.reloadRows(at: [indexPath],
            with: UITableView.RowAnimation.fade)
        //  データを保存，Data型にでシリアライズする
        do {
            let data: Data = try NSKeyedArchiver.archivedData(
                withRootObject: todoList, requiringSecureCoding: true)
            //  UserDefaultsに保存
            let userDefaults = UserDefaults.standard
            userDefaults.set(data, forKey: "todoList")
            userDefaults.synchronize()
        } catch {
            //  エラー処理なし
        }
}

    @objc(_TtCC10MyTodoList14ViewController6MyTodo)class MyTodo: NSObject, NSSecureCoding {
    static var supportsSecureCoding: Bool {
        return true
    }
    //  ToDoのタイトル
    var todoTitle: String?
    //  ToDoを完了したかを表すフラグ
    var todoDone: Bool = false
    //  コントラスタ
    override init() {
    }
    //  NSCodingプロトコルに宣言されているデシリアライズ処理
    required init?(coder aDecorder: NSCoder) {
        todoTitle = aDecorder.decodeObject(forKey: "todoTitle") as? String
        todoDone = aDecorder.decodeBool(forKey: "todoDone")
    }
    //  NSCodingプロトコルに宣言されているシリアライズ処理
    func encode(with aCoder: NSCoder) {
        aCoder.encode(todoTitle, forKey: "todoTitle")
        aCoder.encode(todoDone, forKey: "todoDone")
    }
    }
}
