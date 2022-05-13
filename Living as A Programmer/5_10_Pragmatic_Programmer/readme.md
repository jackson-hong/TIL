# 5/10 Pragmatic Programmer

Date: May 10, 2022 11:33 PM

> 왜 단일 책임 원칙이 유용한가? 요구 사항이 바뀌더라도 모듈 하나만 바꿔서 반영할 수 있기 때문이다.
> 

> 프로그래머로서 우리는 지식을 수집하고, 조직하고, 유지하며, 통제한다.
> 

> 우리는 지식을 명세로 문서화하고, 실행 코드를 통해 그 지식에 생명을 부여한다. 그리고 그 지식으로부터 테스트 중에 점검할 사항들을 얻는다.
> 

> 안타깝게도 지식은 고정적이지 않다. 지식은 변화한다. 때로는 급격하게 변화한다.
> 

> 유지보수를 하려면 사물의 표현 양식, 즉 애플리케이션에 표현되어 있는 지식을 찾아내고 또 바꿔야한다. 문제는 명세와 프로세스, 개발하는 프로그램 안에 지식을 중복해서 넣기 쉽다는 것이다. 그렇게 된다면 애플리케이션이 출시되기 한참 전부터 유지 보수의 악몽이 시작될 것이다.
> 

> DRY는 지식의 중복, 의도의 중복에 대한 것이다. 똑같은 개념을 다른 곳 두군데에서 표현하면 안 된다는 것이다. 경우에 따라서는 중복 표현이 두 가지 완전히 다른 방식으로 이루어질 수도 있다.
> 

> 코드는 동일하지만 두 함수가 표현하는 지식은 다르다. 두 함수는 각각 서로 다른 것을 검증하고 있지만, 우연히 규칙이 같은 것뿐이다. 이것은 우연이지 중복이 아니다.
> 

> 시스템은 서로 협력하는 모듈의 집합으로 구성되어야 하고, 각 모듈은 다른 부분과 독립적인 기능을 구현해야 한다. 때로는 이런 컴포넌트들이 계층으로 묶여서 계층 단위의 추상화를 제공하기도 한다.
> 

> 현실 세계의 변화와 설계 사이의 결합도를 얼마나 줄였는지도 확인해보기 바란다.
> 

> 툴킷이나 라이브러리를 도입할 때에는 심지어 같은 팀의 다른 멤버가 작성한 것이더라도 이것이 여러분의 코드에 수용해서는 안 될 변화를 강요하지 않는지 검토해 보라.
> 

> 객체의 상태를 바꿀 필요가 있다면 여러분을 위해 객체가 직접 상태를 바꾸게 하라. 이렇게 한다면 코드는 다른 코드 구현으로부터 분리된 채로 남아있을 것이며, 계속해서 직교성을 유지할 확률이 높아진다.
> 

> 테스트를 정규 빌드 과정의 일부로 수행하는 것을 추천한다.
> 

> 단위 테스트 작성하는 행위 자체가 직교성을 테스트해 볼 수 있는 기회다. 단위 테스트를 빌드하고 실행하기 위해 어떤 작업이 필요한가? 나머지 시스템 중 상당 부분을 불러와야 하지는 않는가? 만약 그렇다면 모듈과 나머지 지스템 사이의 결합도를 충분히 줄이지 못했다는 뜻이다.
> 

> 여러분이 특정 업체의 데이터베이스나 아키텍처 패턴, 어떤 배포 모델을 사용하기로 결정했다면 큰 비용을 치르지 않고는 되돌릴 수 없는 행동을 하기로 묶여버린 셈이다.
> 

> 우리가 소프트웨어를 개발하는 속도는 요구 사항, 사용자, 하드웨어의 변화를 앞지를 수 없다.
> 

> 시스템을 정의하는 중요한 요구 사항을 찾아라. 의문이 드는 부분이나 가장 위험이 커 보이는 곳을 찾아라. 이런 부분의 코드를 가장 먼저 작성하도록 개발 우선순위를 정하라.
>