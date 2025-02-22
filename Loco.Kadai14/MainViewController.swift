import UIKit

struct CheckItem {
    var name: String
    var isChecked: Bool
}

class MainViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!

    private var checkItems: [CheckItem] =
        [
        CheckItem(name: "りんご", isChecked: false),
        CheckItem(name: "みかん", isChecked: true),
        CheckItem(name: "バナナ", isChecked: false),
        CheckItem(name: "パイナップル", isChecked: true)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }

        if identifier == "ShowInputVC" {
            guard let navigationController = segue.destination as? UINavigationController, let inputNameViewController = navigationController.topViewController as? InputTextViewController else { return }
            inputNameViewController.delegate = self
        }
    }

    @IBAction private func exit(segue: UIStoryboardSegue) {
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    var cellIdentifier: String { "MyCell" }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        checkItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CustomTableViewCell
        cell?.configure(item: checkItems[indexPath.row])
        return cell!
    }
}

extension MainViewController: InputTextDelegate {
    func saveTextAndReturn(fruitsName: String) {
        checkItems.append(CheckItem(name: fruitsName, isChecked: false))

        dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
}
