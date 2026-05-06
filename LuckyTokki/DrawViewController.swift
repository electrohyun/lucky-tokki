import UIKit

class DrawViewController: UIViewController {
    
    // 버튼 연결
    @IBAction func drawButton(_ sender: UIButton) {
        startLoadingAnimation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.stopLoadingAnimation()
            self.showFortune()
        }
    }
    
    // 아웃렛 연결
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    var timer: Timer?
    var dotCount = 0
    
    // 이모지 딕셔너리
    let gradeEmojis: [String: String] = [
        "대길": "🌟",
        "길": "😊",
        "보통": "😐",
        "흉": "😞",
        "대흉": "💀"
    ]
    
    // 결과 키 (딕셔너리 키와 정확히 일치해야 함)
    let grades = ["대길", "길", "보통", "흉", "대흉"]
    
    // 운세 메시지 데이터
    let fortunesByGrade: [String: [String]] = [
        "대길": [
            "당신에게 큰 행운이 찾아옵니다!",
            "기분 좋은 일이 연달아 생길 거예요!",
            "오늘의 주인공은 바로 당신!"
        ],
        "길": [
            "작지만 확실한 행운이 따릅니다.",
            "좋은 소식이 찾아올 수 있어요.",
            "평온 속에서 기쁨이 피어납니다."
        ],
        "보통": [
            "무난하고 안정적인 하루가 될 거예요.",
            "기대하지 않아도 잔잔한 행복이 있어요.",
            "오늘은 균형 잡힌 하루가 될 거예요."
        ],
        "흉": [
            "작은 실수에 주의가 필요해요.",
            "말 한마디를 조금 조심해보세요.",
            "급한 결정보다는 신중함이 좋아요."
        ],
        "대흉": [
            "오늘은 휴식이 가장 필요합니다.",
            "컨디션 관리가 최우선!",
            "중요한 결정은 피하는 것이 좋아요."
        ]
    ]
    
    
    // MARK: - 로딩 애니메이션
    
    func startLoadingAnimation() {
        // 기존 타이머 제거
        timer?.invalidate()
        timer = nil
        
        dotCount = 0
        loadingLabel.text = "추첨 대기 중"
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.dotCount = (self.dotCount + 1) % 4
            let dots = String(repeating: ".", count: self.dotCount)
            self.loadingLabel.text = "추첨 대기 중\(dots)"
        }
        
        resultLabel.text = ""
        messageLabel.text = ""
    }
    
    
    func stopLoadingAnimation() {
        timer?.invalidate()
        timer = nil
        loadingLabel.text = "추첨 완료!"
    }
    
    
    // MARK: - 최종 운세 표시
    
    func showFortune() {
        guard let grade = grades.randomElement(),
              let messages = fortunesByGrade[grade],
              let fortune = messages.randomElement(),
              let emoji = gradeEmojis[grade] else { return }
        
        // 예: 🌟 대길
        resultLabel.text = "\(emoji) \(grade)"
        messageLabel.text = fortune
    }
    // MARK: - 폰트 적용

    func applyCustomFont() {
        let fontName = "LeeSeoyun"
        
        topLabel.font = UIFont(name: fontName, size: 30)
        loadingLabel.font = UIFont(name: fontName, size: 18)
        resultLabel.font = UIFont(name: fontName, size: 28)
        messageLabel.font = UIFont(name: fontName, size: 20)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyCustomFont()
    }
}
