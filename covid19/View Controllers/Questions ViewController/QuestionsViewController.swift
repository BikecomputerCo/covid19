import UIKit
import Firebase

class QuestionsViewController: UIViewController {
    // MARK: - Outlets
    
    // Views
    @IBOutlet var mainView:             UIView!
        
    // Labels
    @IBOutlet var questionLabel:        UILabel!
    @IBOutlet var descriotionLabel:     UILabel!
    @IBOutlet var numberLabel:          UILabel!
    
    // Stack
    @IBOutlet var answersContainer:     UIStackView!
    
    // MARK: -
    // MARK: - Variables
    
    private var questionNumber          = 0
    private var questions: [Question]   = []
    private var answers: [Answer]       = []
    
    // MARK: -
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        /* Configure */
        configure()
    
        /* Localization */
        updateTextForNewLocalization()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Data
        getData()
    }
    
    // MARK: -
    // MARK: - Data
    
    private func getData() {
        Firestore.firestore().collection("questions").getDocuments() { (querySnapshot, error) in
            guard let querySnapshot = querySnapshot else { return }
            self.dataProcess(documents: querySnapshot.documents)
        }
    }
    
    private func dataProcess(documents: [DocumentSnapshot])  {
        var data: [Question] = []
        for document in documents {
            data.append(Question(document: document))
        }
        
        questions.removeAll()
        questions.append(contentsOf: data)
        
        updateData()
    }
    
    // MARK: -
    // MARK: - UI Update
    
    private func updateData() {
        DispatchQueue.main.async {
            if self.questionNumber == self.questions.count {
                self.questionsCompleted()
                return
            }
            
            self.resetButtons()
            self.numberLabel.text = "\(self.questionNumber + 1) / \(self.questions.count)"
            self.setupQuestion()
            self.mainView.isHidden = false
        }
    }
    
    private func setupQuestion() {
        let question = questions[questionNumber]
        questionLabel.text      = question.title.value
        descriotionLabel.text   = question.description.value
        
        for (i, answer) in question.answers.enumerated() {
            if i == 8 { break } // We have only 8 buttons added in storyboard
            if let button = view.viewWithTag(i+1) as? UIButton {
                setupButton(button: button, answer: answer)
            }
        }
    }
    
    private func setupButton(button: UIButton, answer: AnswerOption?) {
        if let answer = answer {
            button.setTitle(answer.title.value, for: .normal)
            
            if answer.colored {
                makeButtonOrange(button: button)
            } else {
                makeButtonWhite(button: button)
            }
            
            button.isHidden = false
            
        } else {
            button.isHidden = true
        }
    }
    
    private func resetButtons() {
        var tag = 1
        while let button = view.viewWithTag(tag) as? UIButton {
            button.isHidden = true
            tag += 1
        }
    }
    
    private func questionsCompleted() {
        performSegue(withIdentifier: "openTankYou", sender: nil)
    }
    
    // MARK: -
    // MARK: - Actions
    
    @IBAction private func questionAnswerPressed(button: UIButton) {
        mainView.isHidden = true
        
        let question = questions[questionNumber]
        let answer = Answer(question: question.title.value, description: question.description.value, answer: button.title(for: .normal) ?? "")
        answers.append(answer)
        
        questionNumber += 1
        updateData()
    }
    
    // MARK: -
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ThanksViewController {
            controller.answers = answers
        }
    }
    
    // MARK: -
}
