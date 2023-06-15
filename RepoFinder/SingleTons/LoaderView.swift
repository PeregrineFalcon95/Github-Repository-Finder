//
//  LoaderView.swift
//  RepoFinder
//
//  Created by Amit Sarker on 15/6/23.
//

import UIKit

class LoaderView: UIView {
    private let activityIndicatorView = UIActivityIndicatorView(style: .large)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        backgroundColor = UIColor(white: 0, alpha: 0.5)
        alpha = 0.0

        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    func startAnimating(view: UIView) {
        DispatchQueue.main.async {
            self.activityIndicatorView.startAnimating()
            view.addSubview(self)
            self.translatesAutoresizingMaskIntoConstraints = false
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

            UIView.animate(withDuration: 0.3) {
                self.alpha = 1.0
            }

        }
    }

    func stopAnimating() {
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            self.removeFromSuperview()
            UIView.animate(withDuration: 0.3) {
                self.alpha = 0.0
            }
        }
    }
    
    deinit {
        debugPrint("LoaderView Deinit Called")
    }
}
