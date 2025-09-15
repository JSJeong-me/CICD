# 1. 베이스 이미지 설정 (Ubuntu 20.04)
FROM ubuntu:20.04

# 2. 환경 변수 설정 (비대화식 모드)
ENV DEBIAN_FRONTEND=noninteractive

# 3. 기본 패키지 업데이트 및 필수 도구 설치
RUN apt-get update && apt-get install -y \
    software-properties-common \
    curl \
    wget \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# 4. Deadsnakes PPA 추가 (Python 3.11 지원)
RUN add-apt-repository ppa:deadsnakes/ppa -y && \
    apt-get update

# 5. Python 3.11 및 필수 패키지 설치
RUN apt-get install -y \
    python3.11 \
    python3.11-dev \
    python3.11-distutils \
    python3.11-venv \
    && rm -rf /var/lib/apt/lists/*

# 6. Python3 기본 명령어를 Python 3.11로 설정
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1 && \
    update-alternatives --config python3

# 7. pip 최신 버전 설치
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3

# 8. 작업 디렉토리 생성
WORKDIR /app

# 9. 기본 명령어 설정 (Python REPL)
CMD ["python3", "--version"]
