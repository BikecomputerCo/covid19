import Foundation
import UIKit

extension HelpViewController: UITableViewDataSource {
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return helpInfoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HelpInfoTVC = tableView.dequeueReusableCell(for: indexPath)
        cell.helpInfo = helpInfoData[indexPath.row]
        return cell
    }
    
    // MARK: -
}

extension HelpViewController: UITableViewDelegate {
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let helpInfo = helpInfoData[indexPath.row]
        let phoneNumber = helpInfo.phoneNumber.replacingOccurrences(of: " ", with: "")
        guard let url = URL(string: "tel://)" + phoneNumber), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView() // Removing separator when there are no cells
    }
    
    // MARK: -
}
