# g2e-codegen

## 사용법
- etc 디렉토리에 db.properties 파일을 src 디렉토리로 복사한다.
- src로 복사한 db.properties 파일에 DB 접속 정보를 추가한다.
- xsl 디렉토리 안에 탬플릿 파일을 열어 상단에 package를 프로젝트에 맞게 변경한다.
- src 폴더에 프로젝트에서 사용하는 DB종류에 해당하는 클래스(CodegenXXX.java)를 열어 main 함수를 실행한다.
  * 기본값으로 실행하면 전체 테이블에 대한 DAO, VO 가 생성된다.
  * 특정 테이블만 생성 하려면 _tbList 배열에 문자열로 테이블 명을 나열한다.