//
//  DVMCardViewController.swift
//  DeckOfCards-C
//
//  Created by Michael Moore on 8/20/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class DVMCardViewController: UIViewController {
    @IBOutlet weak var suitLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func drawButtonTapped(_ sender: Any) {
        updateViews()
    }
    
    func updateViews() {
        DVMCardController.drawANewCard(52) { (cards, error) in
            guard let cards = cards else { return }
            let card = cards[0]
            DispatchQueue.main.async {
                self.suitLabel.text = card.suit
            }
            
            DVMCardController.fetchCardImage(card) { (image) in
                DispatchQueue.main.async {
                    self.cardImageView.image = image
                }
            }
        }
    }
}
