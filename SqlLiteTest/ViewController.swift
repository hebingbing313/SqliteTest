//
//  ViewController.swift
//  SqlLiteTest
//
//  Created by 2016 on 16/11/8.
//  Copyright © 2016年 2016. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var db:SQLiteDB!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        //获取数据库实例
        db = SQLiteDB.sharedInstance()
        //如果表不存在创建表
        db.execute("create table if not exists t_user(uid integer primary key,username varchar(20),passWord varchar(20))")
        initUser()
    }

    //从SQLite 加载数据
    func initUser() {
        let data = db.query("select * from t_user")
        if data.count > 0 {
            //获取最后一行数据显示
            let user = data[data.count - 1]
            userName.text = user["username"] as? String
            passWord.text = user["passWord"] as? String
        }
    }
    
    func saveUser(){
        let username = self.userName.text!
        let password = self.passWord.text!
        
        //插入数据库，这里用到了esc字符编码函数，其实是调用bridge.m实现的
        let sql = "insert into t_user(username,passWord) values('\(username)','\(password)')"
        print(sql)
        //通过封装的方法执行sql
        let result = db.execute(sql)
        print(result)

    }
    //保存按钮
    @IBAction func saveBtn(sender: AnyObject) {
        saveUser()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

