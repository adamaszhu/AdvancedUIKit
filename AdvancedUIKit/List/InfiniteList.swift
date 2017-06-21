/**
 * InfiniteList is a list that can load infinite items.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 21/06/2017
 */
public class InfiniteList: UITableView {
    
    /**
     * UITableView
     */
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
        dataSource = self
        register(Cell.self, forCellReuseIdentifier: "Cell")
//        register(UINib(nibName: "Cell", bundle: Bundle(for: Cell.self)), forCellReuseIdentifier: "Cell")
    }
    
}

import UIKit

class Cell: UITableViewCell {
    
}

extension InfiniteList: UITableViewDelegate {
    
}

extension InfiniteList: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? Cell
        return cell!
    }
}
