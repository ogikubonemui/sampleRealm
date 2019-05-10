import UIKit
// Realmをインポート
import RealmSwift

class inputViewController: UIViewController {
    
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var button: UIButton!
    
    // この画面で追加または編集するTODO
    var todo: Todo? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let t = todo{
            textField.text = t.title
            button.setTitle("更新", for: .normal)
        } else {
            button.setTitle("追加", for: .normal)
        }
    }
    
    @IBAction func didClickBtn(_ sender: Any) {
        if let title = textField.text {
            // 空文字の場合処理しない
            if title == "" {
                // returnを書くと処理がそこで終わる
                return
            }
            
            let realm = try! Realm()
            
            // 更新か追加で分岐
            if let t = todo {
                // 更新
                try! realm.write {
                    t.title = title
                }
            } else {
                // 追加
                todo = Todo()
                todo?.title = title
                todo?.date = Date()
                
                let maxId = (realm.objects(Todo.self).max(ofProperty:"id")as Int? ?? 0) + 1
                todo?.id = maxId
                try! realm.write {
                    realm.add(todo!)
                }
            }
            

           
            navigationController?.popViewController(animated: true)
            
        }
    }
}
