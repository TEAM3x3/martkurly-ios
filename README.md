![MartKurly Logo](https://user-images.githubusercontent.com/41736472/95359814-870a0780-0905-11eb-9c9a-c07e095f71e6.png)

# MartKurly-ios

여러가지 신선재료 샛별배송 서비스를 제공하는 **Market Kurly** 의 **iOS App** 을 **Clone** 하는 프로젝트 입니다.

**프로젝트 기간: 2020.08.20 - 2020.10.08**

```
현재 대한민국 신선재료배송 서비스 시장을 선도하고 있는 Market Kurly 앱을 모방하여 개발함으로서,
실제로 상용화되어 있는 앱을 개발할 수 있는 역량을 키우고 증명하는 것을 목표로 개발을 기획하였습니다.
```

## Team Members

- 송도영
- 안준영
- 천지운

---

## Architecture

- MVVM

## Requirements

- Language
  - Swift 5.0
- Framework
  - UIKit

## Dependencies

- Alamofire
- BSImagePicker
- KingFisher
- SnapKit
- SwiftLint
- Then

## Development Tools

- Adobe XD : 체계적으로 뷰를 관리하고 코드를 재사용하기 위하여 **Adobe XD** 를 사용해 프로젝트 초반에 모든 뷰 구성을 확인했습니다.
- Discord : **커뮤니케이션 및 코드리뷰**를 위한 화면 공유용도로 사용하였습니다.
- Github Projects : **Github Issue** 와 연동하여 프로젝트를 좀 더 수월하게 관리할 목적으로 사용했습니다.
- Google Meet : **트러블슈팅** 회의에 사용했습니다.
- Slack : 여러 **Notification 을 통합적**으로 관리하였습니다.
- Trello : **BackEnd 팀**과 **프로젝트 진행상황** 공유 목적으로 사용되었습니다.

최대한 여러가지 툴을 사용하고 경험해봄으로서, 이후 프로젝트에서는 더 적합한 툴을 시행착오 없이 선택할 수 있는 경험을 쌓는 것을 목표로 하였습니다.

## Additional Documents

**정보구조** (Information Architecture : IA)

프로젝트 일정, 파트별 진행 여부를 한눈에 확인하고 동시에 관리하고자 제작했습니다.

![정보구조 이미지](https://user-images.githubusercontent.com/41736472/95364202-81172500-090b-11eb-931b-4765e4a0def8.png)

**화면흐름도**

직관적으로 화면 이동을 표현하여 어려움 없이 흐름을 파악할 수 있으며 도식화되어 있어 화면 흐름에 대한 이해도를 높히기 위해 제작했습니다.

![화면흐름도 이미지](https://user-images.githubusercontent.com/41736472/95364209-82485200-090b-11eb-82d8-692b192ebc14.png)

### MVP FlowChart

뷰들의 관계를 이해하고 그 흐름을 명확히 파악하여 중복되는 작업을 최소화하고 효율적으로 프로젝트를 관리하고자 제작하였습니다.

![MVP FlowChart](https://user-images.githubusercontent.com/41736472/95364435-c5a2c080-090b-11eb-9a26-c459c6dc5d32.png)

아래 **Notion** 에서 **MartKurly App** 제작에 사용한 **정보구조 및 화면흐름도,** **MVP FlowChart** 에 대한 더 자세한 정보를 확인할 수 있습니다.

[Notion 확인하기](https://www.notion.so/Mart-Kurly-4fbaeae14a874fdd96698f06472137e1)

---

## MVP

- 회원가입, 로그인
- 메인페이지, 카테고리
- 상품 상세정보, 배송안내
- 상품 후기
- 마이페이지, 장바구니
- 결제 시스템

---

## Demo

### 회원가입 및 로그인

**로그인**

<img src="https://user-images.githubusercontent.com/41736472/95409618-037c0500-095d-11eb-9559-55de6ffddacc.gif" width="100" height="200"> <img src="https://user-images.githubusercontent.com/41736472/95409766-59e94380-095d-11eb-82f0-b5b246584c60.gif" width="100" height="200">

<img src="https://user-images.githubusercontent.com/41736472/95409619-0545c880-095d-11eb-9ec8-cb9ca018f215.gif" width="100" height="200">

<img src="https://user-images.githubusercontent.com/41736472/95409622-070f8c00-095d-11eb-84d2-a3b43c5da0df.gif" width="100" height="200">

<img src="https://user-images.githubusercontent.com/41736472/95409769-5bb30700-095d-11eb-94ec-23b89f71e9f2.gif" width="100" height="200">

### 홈탭 및 카테고리

<img src="https://user-images.githubusercontent.com/41736472/95409938-b77d9000-095d-11eb-8427-fe5b6fb3865c.gif" width="100" height="200">

<img src="https://user-images.githubusercontent.com/41736472/95409942-b9475380-095d-11eb-95d6-a26be9f91706.gif" width="100" height="200">

<img src="https://user-images.githubusercontent.com/41736472/95409944-ba788080-095d-11eb-99e0-bf967dc15b3e.gif" width="100" height="200">

<img src="https://user-images.githubusercontent.com/41736472/95409946-bb111700-095d-11eb-94c0-184a7c0d6b78.gif" width="100" height="200">

<img src="https://user-images.githubusercontent.com/41736472/95409948-bba9ad80-095d-11eb-8e89-cf9331b63948.gif" width="100" height="200">

<img src="https://user-images.githubusercontent.com/41736472/95410158-235ff880-095e-11eb-940f-7cbf1eabc3f3.gif" width="100" height="200">

---

## References

- [카카오 우편번호 서비스](http://postcode.map.daum.net/guide)

