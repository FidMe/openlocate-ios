//
//  Copyright (c) 2017 OpenLocate
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import UIKit

class TransmissionIntervalViewController: UITableViewController {

    // 1 min, 5 min, 1 hour, 6 hours, 12 hours, 1 day
    private let intervals = [60.0, 300.0, 3600.0, 21600.0, 43200.0, 86400.0]

    private var selectedIndexPath: IndexPath?

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return intervals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let interval = intervals[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "IntervalCell", for: indexPath)
        cell.textLabel?.text = "\(Int(interval / 60)) minutes"

        if interval == UserDefaults.standard.double(forKey: "TransmissionInterval") {
            cell.accessoryType = .checkmark
            selectedIndexPath = indexPath
        } else {
            cell.accessoryType = .none
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedIndexPath = self.selectedIndexPath, let cell = tableView.cellForRow(at: selectedIndexPath) {
            cell.accessoryType = .none
        }
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            UserDefaults.standard.set(intervals[indexPath.row], forKey: "TransmissionInterval")
            UserDefaults.standard.synchronize()

            (UIApplication.shared.delegate as? AppDelegate)?.configureOpenLocate()
        }
        selectedIndexPath = indexPath
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
