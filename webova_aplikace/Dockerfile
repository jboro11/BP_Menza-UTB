FROM python:3.12-slim

WORKDIR /app

# Závislosti instalujeme jako první – Docker cachuje tuto vrstvu
# dokud se requirements.txt nemění.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Zkopírujeme zbytek aplikace
COPY . .

# Statické složky (uploads, photos) musí existovat
RUN mkdir -p static/uploads static/photos

# Expozice portu
EXPOSE 5001

CMD ["gunicorn", "-c", "gunicorn.conf.py", "app:app"]
