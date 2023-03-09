
//  ViewController.swift
//  CatchTheKennyGame
//  Created by Serdar Altındaş on 8.03.2023.


import UIKit

class ViewController: UIViewController {
    //1.ADIM : MAİN ÜZERİNDEKİ TÜM EKLENTİLERİ TANIMLIYORUZ.
    //2.ADIM : KENNY İSMİNDEKİ KARAKTERİMİZE 1-9 ARASI NUMARALAR VERİYORUZ.
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    //3.ADIM : "SCORE" DEĞİŞKENİ TANIMLIYORUZ VE KENNY ÜZERİNE DOKUNDUĞUMUZ ZAMAN SCORE DEĞİŞKENİ DEĞİŞECEK.
    var score = 0
    //11.ADIM : "TİMELABEL" ÜZERİNDEKİ SAYACIN DEĞİŞMESİ İÇİN TİMER KULLANIYORUZ.
    var timer = Timer()
    var hideTimer = Timer()
    //12.ADIM : "TİMELABEL" ÜZERİNDEKİ SAYAÇIN KAÇTAN SAYACAĞINI YAZIYORUZ.
    var counter = 0
    //20.ADIM : 9 ADET KENNY'İ DÖNGÜYE ALIYORUZ.
    var kennyArray = [UIImageView]()
    var highScore = 0
    
    override func viewDidLoad() {
        //4.ADIM : SCORE DEĞİŞKENİNİ SCORELABEL ÜZERİNE EKLİYORUZ. ÇÜNKÜ SÜREKLİ DEĞİŞECEK.
        super.viewDidLoad()
        scoreLabel.text = "SCORE : \(score)"
        
        //HIGHSCORE CHECK
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "HIGHSCORE : \(highScore)"
        }
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "HIGHSCORE : \(highScore)"
        }
        //8.ADIM : BİRLEŞTİRME İŞLEMİNDEN SONRA RECOGNIZER'LAR AKTİF HALE GELİR. "TRUE" FONKSİYONU İLE.
        //9.ADIM : 5-7 VE 8.ADIMLAR ASLINDA BİRER GRUP ŞEKLİNDE İLERLİYOR.
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        //5.ADIM : BÜTÜN KENNY'LERİN ÜZERİNE DOKUNULABİLİR OLMASI İÇİN RECOGNİZER EKLİYORUZ!
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        //7.ADIM : KENNY'LER VE RECOGNIZER'LAR BU AŞAMADA BİRLEŞTİRİLİR YANİ KENNY'LERE RECOGNIZER EKLENİR.
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)
        //21.ADIM : DÖNGÜYE ALINAN KENNY'LER.
        kennyArray = [kenny1,kenny2,kenny3,kenny4,kenny5,kenny6,kenny7,kenny8,kenny9]
        //13.ADIM : 30 SANİYEDEN GERİYE SAYMAYA BAŞLAYACAK ŞEKİLDE AYARLIYORUZ.
        counter = 30
        //14.ADIM : "TİMELABEL" ÜZERİNDEKİ COUNTER'IN STRİNG DEĞERİ ALMASINI SAĞLIYORUZ.
        timeLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        //25.ADIM : HİDEKENNY FONKSİYONUNU DÖNGÜYE ALIYORUZ.
        hideTimer = Timer.scheduledTimer(timeInterval: 0.4 , target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        //23.ADIM : DAHA SONRA KENNY'LER AÇILIŞ EKRANINDA SAKLI ŞEKİLDE GÖZÜKECEKLER.
        hideKenny()
    }
    
    @objc func hideKenny(){
        
        for kenny in kennyArray {
            kenny.isHidden = true
    }
        //24.ADIM : KENNY'LER RANDOM OLARAK AÇILIP KAPANACAK BU FONKSİYON O İŞE YARIYOR.
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
    }
    //6.ADIM : RECOGNİZER EKLENEN KENNY'LER ÜZERİNE DOKUNULUNCA BU FUNC(INCREASE SCORE) SAYESİNDE +1 DEĞER ALIR.
    //10.ADIM : BU DEĞERİ TEKRAR GÜNCELLİYORUZ ÇÜNKÜ VİEWDİDLOAD ÜZERİNDEKİ EKRAN TEK SEFERLİK AÇILIYOR.
    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "SCORE : \(score)"
    }
    //15.ADIM : TİMER FONKSİYONU ÜZERİNDEKİ SELECTOR İÇİN GERİ SAYIM FONKSİYONU OLUŞTURUYORUZ VE EKLİYORUZ.
    @objc func countDown(){
        counter -= 1
        timeLabel.text = String(counter)
        if counter == 0 {
    //16.ADIM : TİMER EKRANINI NEGATİF OLMAMASI İÇİN İNVALİDATE İLE DURDURDUK.
            timer.invalidate()
            //26.ADIM : HİDEKENNY FONKSİYONUNU DURDURMAK İÇİN İNVALİDATE KULLANIYORUZ.
            hideTimer.invalidate()
            //27.ADIM : BÜTÜN KENNY'LER TEKRAR GİZLENSİN DİYE DURDURDUKTAN SONRA BU FONKSİYONU TEKRAR EKLİYORUZ.
            for kenny in kennyArray {
                kenny.isHidden = true
    }
            //HIGHSCORE
            if self.score > self.highScore{
                self.highScore = self.score
                highScoreLabel.text = "HIGHSCORE : \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "hıghcore")
    }
            //17.ADIM : KULLANICIYA ZAMANININ BİTTİĞİNİ GÖSTERİYORUZ!.
            let alert = UIAlertController(title: "Game Over!", message: "Do You Want To Play Again?", preferredStyle: UIAlertController.Style.alert)
            //18.ADIM : UYARININ ARDINDAN OK VE REPLAY BUTONLARINI UYARI MESAJINA EKLİYORUZ.
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default){
                (UIAlertAction) in
                //REPLAY FUNCTION
                //28.ADIM HEPSİNİ RESETLİYORUZ.
                self.score = 0
                self.scoreLabel.text = "SCORE : \(self.score)"
                self.counter = 30
                self.timeLabel.text = String(self.counter)
                //29.ADIM : SON OLARAK HEPSİNİ TEKRAR RESETLİYORUZ.
                self.timeLabel.text = String(self.counter)
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.4 , target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
    }
        //19.ADIM : BUTONLARI KULLANICIYA GÖSTERİYORUZ.
        alert.addAction(okButton)
        alert.addAction(replayButton)
        self.present(alert, animated: true)
    }
  
    }
    }

