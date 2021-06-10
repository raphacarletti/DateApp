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
        NotificationCenter.default.addObserver(self, selector: #selector(channelUpdated), name: .channelUpdated, object: nil)
        viewModel.reloadTable = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()

        }
        LoadingUtils.startLoading(in: view)
        viewModel.getChannels {
            LoadingUtils.stopLoading()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let destination = segue.destination as? ConversationViewController,
            let channelId = viewModel.selectedChannelId
        else {
            return
        }

        destination.set(channelId: channelId)
    }

    @objc
    func channelUpdated() {
        tableView.reloadData()
    }
}

extension InboxViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SectionHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
        view.set(text: viewModel.getText(for: section))
        return view
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let configuration = UISwipeActionsConfiguration(actions: [viewModel.reportSwipeAction(), viewModel.unmatchSwipeAction(), viewModel.pinSwipeAction(indexPath: indexPath)])
        configuration.performsFirstActionWithFullSwipe = false

        return configuration
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.setSelectedChannelId(for: indexPath)
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
