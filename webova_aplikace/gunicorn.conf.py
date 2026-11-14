# Konfigurace Gunicornu pro produkční spuštění
# Spuštění: gunicorn -c gunicorn.conf.py app:app

import multiprocessing

# Vícevláknové workery (gthread) pro obsluhu souběžných požadavků z infopanelů
worker_class = "gthread"
workers = min(4, max(2, multiprocessing.cpu_count()))
threads = 4  # Počet souběžných vláken na jednoho workera

bind = "0.0.0.0:5001"
timeout = 60
keepalive = 5

# Logování na standardní výstupy pro Docker
accesslog = "-"
errorlog = "-"
loglevel = "info"
