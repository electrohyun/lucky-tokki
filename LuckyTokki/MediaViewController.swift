import UIKit
import AVKit
import AVFoundation

class MediaViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!   // 재생하기 버튼

    override func viewDidLoad() {
        super.viewDidLoad()

        // 버튼 텍스트에 커스텀 폰트 적용
        playButton.titleLabel?.font = UIFont(name: "LeeSeoyun", size: 22)
    }

    @IBAction func playButtonTapped(_ sender: UIButton) {
        // 앱 번들에서 rabbit.mp4 가져오기
        guard let path = Bundle.main.path(forResource: "rabbit", ofType: "mp4") else {
            print("❌ 동영상 파일을 찾을 수 없습니다.")
            return
        }

        let url = URL(fileURLWithPath: path)

        // 플레이어 생성
        let player = AVPlayer(url: url)
        let playerVC = AVPlayerViewController()
        playerVC.player = player

        // 모달로 띄우기
        present(playerVC, animated: true) {
            player.play()
        }
    }
}
