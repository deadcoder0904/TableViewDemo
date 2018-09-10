import Cocoa
import Defaults

extension Defaults.Keys {
    static let dreams = Defaults.Key<Array<String>>("dreams", default: [
        "Hit the gym",
        "Run daily",
        "Become a millionaire",
        "Become a better programmer",
        "Achieve your dreams"
        ])
}

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet weak var table: NSTableView!
    var dreams = defaults[.dreams]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
    }

    func numberOfRows(in tableView: NSTableView) -> Int {
        return dreams.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let dream = table.makeView(withIdentifier: tableColumn!.identifier, owner: self) as! NSTableCellView
        dream.textField?.stringValue = dreams[row]
        
        return dream
    }
    
    @IBAction func addTableRow(_ sender: Any) {
        addNewDream()
    }
    
    @IBAction func removeTableRow(_ sender: Any) {
        print(sender)
//        removeDream()
    }
    
    func addNewDream() {
        dreams.append("Double Click or Press Enter to Add Workout")
        table.beginUpdates()
        table.insertRows(at: IndexSet(integer: dreams.count - 1), withAnimation: .effectFade)
        table.endUpdates()
    }
 
    func removeDream() {
        dreams.remove(at: 0)
    }
}



