# haru-study-config
초기 ubuntu EC2에서 haru study의 WAS, Promtail 컨테이너를 빠르게 설치하는 가이드

### 1. 초기 설정 파일 다운로드
새 EC2 인스턴스에 도커 컨테이너를 띄우기 위한 `init.sh`, 환경 변수를 저장할 `.env` 파일을 내려받는다
```
wget https://raw.githubusercontent.com/jaehee329/haru-study-config/main/init.sh
wget https://raw.githubusercontent.com/jaehee329/haru-study-config/main/.env
```

  
### 2. 환경 변수 설정
.env 파일을 열어 서버에 맞는 환경 변수 정보로 **수정한다**  
ex)
```
export LOKI_ADDRESS="http://123.456.789.000:3100"
```
LOKI 디렉토리 및 포트 번호, 사용할 스프링 profile의 이름 등을 지정한다  


  
### 3. `init.sh` 실행
```
./init.sh
```

필요한 설치가 끝나고 docker container가 아래와 같이 두 개 뜨면 성공이다  

`sudo docker ps -a`  
<img width="741" alt="image" src="https://github.com/jaehee329/haru-study-config/assets/77962265/541ab7b9-7a3b-4af1-abfc-8c56adbd7b33">



---
이후 GitHub Action을 통해 브랜치를 지정하고 CD를 수행하면 정상적으로 애플리케이션이 올라간다.


