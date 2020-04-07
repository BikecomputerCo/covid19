import UIKit

extension StartViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if countryInfo != nil {
                return 1
            } else {
                return 0
            }
        }
        
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: CountryBaseInfoTVC = tableView.dequeueReusableCell(for: indexPath)
            cell.baseInfo = countryInfo
            return cell
        }
        
        let cell: CityBaseInfoTVC = tableView.dequeueReusableCell(for: indexPath)
        cell.baseInfo = cities[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 50
        }
        
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let label = UILabel()
            label.frame = CGRect(x: 25, y: 20, width: tableView.frame.size.width - 50, height: 21)
            label.font = UIFont.boldSystemFont(ofSize: 18)
            label.text = "Municipality".localized()
            label.textColor = UIColor.App.black100

            let view = UIView()
            view.backgroundColor = .white
            view.addSubview(label)

            return view
        }

        return nil
    }
    
    // MARK: -
}
