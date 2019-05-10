import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    // テーブルに表示するTodoの配列
    var todos: [Todo] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let realm = try! Realm()
        // 全件取得
        todos = realm.objects(Todo.self).reversed()
        tableView.reloadData()
    }
    
    
    @IBAction func didClickAddBtn(_ sender: Any) {
        performSegue(withIdentifier: "toInput", sender: nil)
    }
    
    // テーブルにセルを何個表示するか
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    // セルの表示内容はなにか
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let todo = todos[indexPath.row]
        
        // TODOのタイトルをセルのテキストに設定
        cell.textLabel?.text = todo.title
        // セルに右矢印を付与
        cell.accessoryType = .disclosureIndicator
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // セルをスワイプして、削除が選ばれた場合
        if editingStyle == .delete {
            //            let id = todos[indexPath.row].id
            let todo = todos[indexPath.row]
            
            // IDを元に削除対象を取得
            let realm = try! Realm()
            //            let todo = realm.objects(Todo.self).filter("id = \(id)").first
            
            try! realm.write {
                realm.delete(todo)
            }
            
            // 配列から削除
            todos.remove(at: indexPath.row)
            
            // 画面から削除
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    // セルを選択した時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = todos[indexPath.row]
        performSegue(withIdentifier: "toInput", sender: todo)
    }
    // 画面遷移時に呼ばれるメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 使うsegueがtoInputか判別
        if segue.identifier == "toInput" {
            // senderからtodoがあれば取り出す
            if let todo = sender {
                // 次の画面にtodoを渡す
                let inputVC = segue.destination as! inputViewController
                inputVC.todo = todo as? Todo
            }
        }
    }
}
