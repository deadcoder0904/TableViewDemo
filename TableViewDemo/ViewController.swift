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
    var selectedRow:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
    }
    
    override var acceptsFirstResponder : Bool {
        return true
    }
    
    override func keyDown(with theEvent: NSEvent) {
        if theEvent.keyCode == 51 {
            removeDream()
        }
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        let table = notification.object as! NSTableView
        selectedRow = table.selectedRow
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
        removeDream()
    }
    
    func addNewDream() {
        dreams.append("")
        table.beginUpdates()
        let last = dreams.count - 1
        table.insertRows(at: IndexSet(integer: last), withAnimation: .effectFade)
        table.scrollRowToVisible(last)
        table.selectRowIndexes([last], byExtendingSelection: false)
        table.endUpdates()
        
        // focus on the last item, add cursor & start editing
        let keyView = table.view(atColumn: 0, row: last, makeIfNecessary: false) as! NSTableCellView
        self.view.window!.makeFirstResponder(keyView.textField)

        saveDreams()
    }
 
    func removeDream() {
        if selectedRow >= dreams.count {
            selectedRow = dreams.count - 1
        }
        if selectedRow != -1 {
            dreams.remove(at: selectedRow)
            table.removeRows(at: IndexSet(integer: selectedRow), withAnimation: .effectFade)
        }
        saveDreams()
    }
    
    func saveDreams() {
        defaults[.dreams] = dreams
    }
}
