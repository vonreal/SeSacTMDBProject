# SeSacTMDBProject
<a href="https://developers.themoviedb.org/3/getting-started">TMDB API</a>를 이용해서 최근 7일 트렌딩한 영화를 받아와서 보여주고, 영화에 대한 출연진 정보등을 보여주는 프로젝트입니다.


# 구현 결과
## 0807
트렌딩 화면에 대한 페이지 네이션 적용, 그림자 크기 조정
![ezgif com-gif-maker (12)](https://user-images.githubusercontent.com/50474006/183284101-4802a369-ec01-4505-9f17-2b91ce89ccd2.gif)

### 소감
델리게이트 패턴을 처음 사용해보았다. 버튼을 눌렀을때 그 버튼에 대한 걸 어떻게 알고 어떻게 다른 컨트롤러에 값을 전달하는가? (델리게이트, 클로저, 노피티케이션을 사용할 수 있다고 한다.) 이 과정이 매우 고통스러웠다. 일단은 델리게이트를 써보고 실험해보고 이해를 해서 흐름을 알겠지만 익숙해지려면 계속 써보고 응용해봐야겠다. 그리고 그리고 자꾸 레이아웃 오류에 대한 메시지가 디버깅 창에 출력된다. 아마도 셀 부분에서 각각의 요소들의 레이아웃을 명시해줘야 하는데 어렵다.

## 0806
화면전환 적용 및 캐스트 정보 출력
![ezgif com-gif-maker (9)](https://user-images.githubusercontent.com/50474006/183284116-4e9305f1-b887-437f-a775-9aaeb3d3752b.gif)
