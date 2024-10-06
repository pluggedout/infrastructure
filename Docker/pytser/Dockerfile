FROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
RUN git clone https://github.com/dharineeshj/Pytster.git
WORKDIR /app/Pytster/Command\ Line
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt
CMD ["tail", "-f", "/dev/null"]
#CMD ["python", "pytster-cmd.py"]
