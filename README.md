# Swift-SimpleWeather

원티드 프리 온보딩 iOS 파트의 사전과제입니다.

- [원티드 프리온보딩 코스 - iOS](https://www.wanted.co.kr/events/pre_ob_ios_1)
- [과제 안내](https://yagomacademy.notion.site/4eb46f9eb3a442efb9d0856b72f15b74)

## 요구사항

- [Open Weather API](https://openweathermap.org/api) 를 활용해 주어진 요구사항을 구현한다.
- 첫번째 화면
	- 주어진 20개 도시의 날씨 정보를 화면에 표시한다.
	- 도시이름, 날씨 아이콘, 현재기온, 현재습도
	- 도시 정보를 선택할 시 두번째 화면으로 이동한다.
- 두번째 화면
	- 첫번째 화면에서 선택한 도시의 현재 날씨 상세 정보를 표헌한다.
	- 도시이름, 날씨 아이콘, 현재기온, 체감기온, 현재습도, 최저기온, 최고기온, 기압, 풍속, 날씨설명
	- 날씨 아이콘 이미지를 불러올땐 캐시를 활용한다.
- 날씨 아이콘의 경우 API 에서 제공하는 아이콘을 활용한다.

## 설명

### 사용 기술

- UIKit, Storyboard, AutoLayout

### 기간

- 2022.06.14 ~ 2022.06.15

### Target

- iOS 15.4

## 첫번째 화면

<img src="https://user-images.githubusercontent.com/55919701/173806014-e449bf8d-500b-45c7-b3d3-802d8eb0dfa2.png" width="30%" height="30%"> 

- 20개 도시의 날씨정보를 받아오기 위해 API 호출 시 사용되는 url 에 모든 도시의 `id` 를 삽입했습니다.
- 받아온 날씨 데이터를 모두 출력하기 위해 리스트 형태로 날씨 정보를 저장한 후 `UICollectionView` 를 이용해 화면에 출력했습니다.
- 도시이름, 날씨 아이콘, 현재기온, 현재습도를 `cell` 내에 차례대로 출력했습니다.
- 날씨 아이콘 `id` 를 이용해 url 을 구성하여 아이콘 데이터를 받아왔으며, 캐시 이미지를 활용했습니다.
- 도시를 선택할 시 해당 도시의 날씨 데이터를 두번째 화면으로 넘겨주었습니다.

### 스크롤 내렸을때

<img src="https://user-images.githubusercontent.com/55919701/173807047-5cae9eb6-ea90-4f4d-83be-d7cc7e0dbc1c.png" width="30%" height="30%"> 

## 두번째 화면

<img src="https://user-images.githubusercontent.com/55919701/173807138-abe08652-eb1a-4a8e-aebb-5d41024d6029.png" width="30%" height="30%">
 
- 선택한 도시의 상세 날씨 정보를 출력하기 위해 첫번째 화면에서 사용된 데이터를 전달받았습니다.
- 날씨 정보를 보기좋게 출력하기 위해 `UICollectionView` 를 이용해 화면에 출력했습니다.
- 날씨 상세 정보는 임의로 순서를 지정해주었습니다.
- 도시이름, 날씨 아이콘, 현재기온, 날씨설명을 먼저 `Header` 에 담았습니다.
- 이후 각 `Cell` 에 최저기온, 최고기온, 체감기온, 습도, 기압, 풍속을 담았습니다.
- 날씨 아이콘을 출력할때는 캐시 이미지를 활용했습니다.

### 스크롤 내렸을때
 
<img src="https://user-images.githubusercontent.com/55919701/173807654-4e8f6356-bbe4-430f-b730-0756dbe07ee6.png" width="30%" height="30%"> 

## What I Learned

- `CompositionalLayout` 을 이용하여 `UICollectionView` 의 `Header` 를 구성하는 방법을 배웠습니다.
- 캐시 이미지를 활용하여 화면에 출력하는 방법을 배웠습니다.
- `View` 에 `BlurEffect` 를 적용하는 방법을 배웠습니다.
