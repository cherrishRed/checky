# checky 

> 팀원: 🍒[@RED](https://github.com/cherrishRed) 👼[@Taeangel](https://github.com/Taeangel)
> 프로젝트 기간: 2022/10/3 ~ 2022/11/16

|Monthly|Weekly|Daily|
|:-:|:-:|:-:|
|![](https://i.imgur.com/TQxbCJX.png)|![](https://i.imgur.com/YfsrsDG.png)|![](https://i.imgur.com/RAcjd2I.png)|
한 달 동안 일정을 한번에 보여주는 뷰 입니다.|한 주의 일정을 한번에 보여주는 뷰 입니다.| 하루치 일정을 한눈에 보여주는 뷰 입니다. 

✨ Monthly와 Weekly 에서는 우선순위가 **상**인 미리알림만 화면에 나타납니다. 
✨ Daily에는 오늘 마감인 미리알림과, 오늘 완료한 미리알림이 나타납니다. 

|Add Event&Reminder|Add Event|Edit Reminder|
|:-:|:-:|:-:|
|![](https://i.imgur.com/MSkECrn.png)|![](https://i.imgur.com/w0IRr2n.png)|![](https://i.imgur.com/r4wsvNf.png)|
|Tap의 플러스 버튼을 누르면 나타나는 뷰 입니다.|이벤트를 추가 할 수 있는 뷰 입니다.|이벤트를 수정할 수 있는 뷰 입니다.|

✨ Daily에서 일정을 클릭하면 수정할 수 있습니다. 

|Reminder Tap|Setting Tap|Dark Mode|
|:-:|:-:|:-:|
|![](https://i.imgur.com/P9GC2RJ.png)|![](https://i.imgur.com/UMrd4Ky.png)|![](https://i.imgur.com/WQ4ljhv.png)|
|모든 reminder들의 카테고리 별로 보여주는 탭 입니다.| 카테고리별 색상 및 이모지 선택을 할 수 있는 세팅 뷰 입니다. |다크 모드 완벽 지원 합니다.|

🥲 Reminder Tap에 수정 기능은 제공하고 있지 않아요 추후에 업데이트 예정에 있습니다.
✏️ 세팅에서 색상을 선택해 주지 않으면... 아이폰 캘린더 앱에서 설정 된 색상으로 화면에 보이게 됩니다. 

## ⚙️ 개발환경 ⚙️
![Combine](https://img.shields.io/badge/Combine-F05138?style=for-the-badge&logo=swift&logoColor=white) ![SwiftUI](https://img.shields.io/badge/SwiftUI-f5bc42?style=for-the-badge&logo=swift&logoColor=white) ![EventKit](https://img.shields.io/badge/EventKit-0A9EDC?style=for-the-badge&logo=swift&logoColor=white)

![target](https://img.shields.io/badge/target-iOS15-16a87c?style=for-the-badge&logo=apple&logoColor=white) ![xcode](https://img.shields.io/badge/Xcode-14.1-5164e0?style=for-the-badge&logo=xcode&logoColor=white)

![xcode](https://img.shields.io/badge/MVVM-900be3?style=for-the-badge)
뷰 컨트롤러와 뷰는 화면을 그리는 역할에만 집중하고, 데이터 관리, 로직 실행은 뷰 모델에서 진행되도록 했습니다.

![xcode](https://img.shields.io/badge/Coordinator-d42464?style=for-the-badge)
화면 전환에 대한 로직을 View로부터 분리하기위해 Coordinator 디자인패턴을 선택하였습니다.

## 📚  더 자세한 사항 
자세한 앱 구현 과정과 trouble shooting에 관한 내용은 [checky wiki](https://github.com/cherrishRed/checky/wiki)를 참고하세요!
