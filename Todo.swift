// Todo.swift
// データベースのテーブルを定義

// Realmをインポート
import RealmSwift

// class テーブル名: Object {}
class Todo: Object {
    // Int型のIDというカラム
    @objc dynamic var id:Int = Int()
    // TODOのタイトル
    @objc dynamic var title:String = String()
    // TODOの作成日時
    @objc dynamic var date:Date = Date()
}
