FROM python:3.12
WORKDIR /app
COPY ./requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /app/requirements.txt
COPY ./test.sh /app/test.sh
COPY . /app/app
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80"]

