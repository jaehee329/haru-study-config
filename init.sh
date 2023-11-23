# 도커 설치
# https://docs.docker.com/compose/install/linux/

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


# 도커 컴포즈 설치
sudo apt-get install -y docker-compose


# bashrc에 같은 디렉토리의 .env파일에 적힌 환경 변수 영구 등록
ENV_FILE="./.env"

if [ -f "$ENV_FILE" ]; then
  while IFS= read -r line; do
    echo "$line" >> ~/.bashrc
  done < "$ENV_FILE"

  echo "등록 완료"
else
  echo "파일이 존재하지 않습니다: $ENV_FILE"
  exit 1
fi

source ~/.bashrc

# deploy.sh 생성
wget -P /home/ubuntu/backend https://raw.githubusercontent.com/jaehee329/haru-study-config/main/deploy.sh
chmod 777 /home/ubuntu/backend/deploy.sh


# dockerfile, docker-compose 생성
wget https://raw.githubusercontent.com/jaehee329/haru-study-config/main/docker-compose.yml
wget https://raw.githubusercontent.com/jaehee329/haru-study-config/main/amazoncorretto17_dockerfile
wget https://raw.githubusercontent.com/jaehee329/haru-study-config/main/promtail_dockerfile


# 컨테이너 실행
sudo docker-compose up -d
