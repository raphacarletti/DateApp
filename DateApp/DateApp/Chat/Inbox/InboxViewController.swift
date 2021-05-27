import UIKit

class InboxViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableHeaderView = MessageHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 80))
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: String(describing: InboxChatTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: InboxChatTableViewCell.self))
            tableView.separatorStyle = .none
        }
    }

    private let viewModel = InboxViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        viewModel.reloadTable = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()

        }
        LoadingUtils.startLoading(in: view)
        viewModel.getChannels {
            LoadingUtils.stopLoading()
        }
    }
}

extension InboxViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = InboxSectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
        view.setText(for: section)
        return view
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let title = indexPath.section == 0 ? "Unpin" : "Pin"
        return UISwipeActionsConfiguration(actions: [UIContextualAction(style: .normal, title: title, handler: { [weak self] action, view, completion in
            guard let self = self else { return }
            self.viewModel.pinAction(indexPath: indexPath)
        })])
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Segue.inboxToConvesationScreen, sender: self)
    }


}

extension InboxViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.cellForRow(tableView: tableView, indexPath: indexPath)
    }
}
