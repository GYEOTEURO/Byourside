# Byourside
2022 배리어 프리 앱 개발 콘테스트 팀 곁으로

----
## Git Commit Message Convention

```python
Type(유형): Subject(제목) (#이슈번호 - 생략가능)
# blank line
Body(본문 - 생략 가능)
# blank line
Footer(꼬릿말 - 생략 가능)
```


### *Header*

> 1. 커밋 유형과 제목의 첫 글자는 대문자로 표기한다.
> 2. 제목은 50자를 넘기지 않고, 마침표(`.`)를 표기하지 않는다.
> 3. 타입의 끝에는 콜론(`:`)을 작성하고 한 칸 공백을 두어 제목과 구분한다.
> 4. 제목과 본문, 본문과 꼬릿말은 한 줄 띄워 분리한다.
> 5. 제목은 명령문을 지향하며, 과거형은 적지 않는다.
> 6. 이슈 번호가 있다면 제목의 끝에 (`(#이슈 번호)`-괄호포함)을 작성한다.

<details>
<summary><b>Type</b></summary>
<div markdown="1">       

|Type|Explanation|
|:---|:---|
|Feat|새로운 기능을 추가
|Fix|	버그를 고친 경우
|Chore|	간단한 수정 혹은 빌드 업데이트
|Design|	사용자 UI 디자인 변경
|!BREAKING CHANGE|	커다란 API 변경
|!HOTFIX|	급하게 치명적인 버그를 고쳐야하는 경우
|Style|	코드에 변화가 없는 수정 (코드 포맷 변경, 세미 콜론 누락, 들여쓰기 등)
|Refactor|	프로덕션 코드 리팩토링 (결과의 변경 없이 코드의 구조를 재조정 / 가독성을 높여 유지보수를 하는 경우)
|Comment|	필요한 주석 추가 및 변경
|Docs|	문서를 수정한 경우
|Test|	테스트 코드 (테스트 추가/ 테스트 코드 리팩토링) - 프로덕션 코드 변경 없음
|Build|	빌드 테스트 업데이트, 패키지 매니저 설정 - 프로덕션 코드 변경 없음
|Rename|	파일 혹은 폴더명을 수정하는 경우
|Remove|	파일을 삭제하는 경우
|Move|	코드나 파일을 이동하는 경우

</div>
</details>


### *Body*

*생략 가능*

1. 생략이 불가능할 경우 자세한 내용을 적어 본문을 구성한다.
2. 어떻게(How)보다 무엇(What)을, 왜(Why)에 초점을 맞춰 작성한다.


### *Footer*

*생략 가능*

형식: `Type: #issue_number`

1. 이슈 트랙킹을 위해 사용한다. (이슈 트래커 ID를 작성)
2. 여러 개의 이슈는 쉼표로 구분한다.

<details>
<summary><b>Type</b></summary>
<div markdown="1">       

|Type|Explanation|
|:---|:---|
|Resolves|이슈 해결
|Fixes|이슈 수정중
|Ref|참고할 이슈가 있음


</div>
</details>
