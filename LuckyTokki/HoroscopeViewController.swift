import UIKit

class HoroscopeViewController: UIViewController {

    @IBOutlet weak var topInformationLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var birthButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var rabbitButton: UIButton!

    var selectedBirthday: Date = Date()

    let horoscopes: [String: [String]] = [
        "양자리": [
            "오늘은 추진력이 좋은 날입니다. 미뤄둔 일을 시작해보세요.",
            "당신의 용기가 주변 사람에게 좋은 영향을 줍니다."
        ],
        "황소자리": [
            "안정적인 기운이 흐르는 하루입니다. 익숙한 것을 붙잡아보세요.",
            "작은 즐거움이 큰 행복으로 이어질 수 있어요."
        ],
        "쌍둥이자리": [
            "소통운이 좋은 날입니다. 새로운 정보를 얻게 될 거예요.",
            "가볍게 나눈 대화에서 인사이트를 얻을 수 있어요."
        ],
        "게자리": [
            "감정이 풍부해지는 날입니다. 스스로를 잘 돌봐주세요.",
            "가까운 사람과의 대화가 큰 위로가 될 거예요."
        ],
        "사자자리": [
            "자신감이 빛나는 날입니다. 사람들 앞에 나서보세요.",
            "당신의 매력이 주목받는 하루가 됩니다."
        ],
        "처녀자리": [
            "사소한 디테일이 중요한 하루예요. 꼼꼼함이 빛을 발합니다.",
            "정리 정돈을 하면 머릿속도 함께 정리됩니다."
        ],
        "천칭자리": [
            "균형과 조화가 중요한 날입니다. 한쪽에 치우치지 마세요.",
            "사람 사이에서 중재자의 역할을 하게 될 수 있어요."
        ],
        "전갈자리": [
            "집중력이 높아지는 날입니다. 깊이 파고드는 데 유리해요.",
            "비밀스럽던 것이 드러날 수 있는 하루입니다."
        ],
        "사수자리": [
            "모험심이 살아나는 날입니다. 새로운 시도를 해보세요.",
            "평소와 다른 길을 택하면 좋은 경험을 하게 됩니다."
        ],
        "염소자리": [
            "책임감이 강조되는 하루입니다. 맡은 일을 끝까지 해보세요.",
            "오늘의 노력은 나중에 확실한 보상으로 돌아옵니다."
        ],
        "물병자리": [
            "독창적인 아이디어가 떠오르는 날입니다.",
            "틀을 깨는 생각이 좋은 결과를 가져옵니다."
        ],
        "물고기자리": [
            "상상력이 풍부한 날입니다. 감성적인 작업에 잘 맞아요.",
            "감정에 휩쓸리지 않도록 잠시 호흡을 골라보세요."
        ]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // DatePicker 기본 설정
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.isHidden = true

        resultLabel.isHidden = true

        selectedBirthday = datePicker.date
        updateBirthLabel()

        // 🍀 폰트 적용
        applyCustomFonts()
    }

    func applyCustomFonts() {
        let fontName = "LeeSeoyun"

        topInformationLabel.font = UIFont(name: fontName, size: 20)
        birthLabel.font = UIFont(name: fontName, size: 20)
        resultLabel.font = UIFont(name: fontName, size: 22)
        birthButton.titleLabel?.font = UIFont(name: fontName, size: 18)
        rabbitButton.titleLabel?.font = UIFont(name: fontName, size: 18)
    }

    func updateBirthLabel() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월 d일"

        birthLabel.text = "생일: \(formatter.string(from: selectedBirthday))"
    }

    @IBAction func didTapBirthButton(_ sender: UIButton) {
        datePicker.isHidden.toggle()
    }

    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        selectedBirthday = sender.date
        updateBirthLabel()
    }

    @IBAction func didTapRabbitButton(_ sender: UIButton) {
        let sign = zodiacSign(for: selectedBirthday)
        let emoji = zodiacEmoji(for: sign)
        let message = horoscopes[sign]?.randomElement() ?? "오늘은 조용히 흘러가는 하루입니다."

        birthLabel.isHidden = true
        birthButton.isHidden = true
        datePicker.isHidden = true

        resultLabel.isHidden = false
        resultLabel.text = "\(sign) \(emoji)\n\n\(message)"
        resultLabel.textAlignment = .center
        resultLabel.numberOfLines = 0
    }

    func zodiacSign(for date: Date) -> String {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)

        switch (month, day) {
        case (3, 21...31), (4, 1...19): return "양자리"
        case (4, 20...30), (5, 1...20): return "황소자리"
        case (5, 21...31), (6, 1...21): return "쌍둥이자리"
        case (6, 22...30), (7, 1...22): return "게자리"
        case (7, 23...31), (8, 1...22): return "사자자리"
        case (8, 23...31), (9, 1...23): return "처녀자리"
        case (9, 24...30), (10, 1...22): return "천칭자리"
        case (10, 23...31), (11, 1...22): return "전갈자리"
        case (11, 23...30), (12, 1...21): return "사수자리"
        case (12, 22...31), (1, 1...19): return "염소자리"
        case (1, 20...31), (2, 1...18): return "물병자리"
        case (2, 19...29), (3, 1...20): return "물고기자리"
        default: return "알 수 없음"
        }
    }

    func zodiacEmoji(for sign: String) -> String {
        switch sign {
        case "양자리": return "🐏"
        case "황소자리": return "🐂"
        case "쌍둥이자리": return "👥"
        case "게자리": return "🦀"
        case "사자자리": return "🦁"
        case "처녀자리": return "🌾"
        case "천칭자리": return "⚖️"
        case "전갈자리": return "🦂"
        case "사수자리": return "🏹"
        case "염소자리": return "🐐"
        case "물병자리": return "🏺"
        case "물고기자리": return "🐟"
        default: return "⭐️"
        }
    }
}
