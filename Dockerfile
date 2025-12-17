FROM python:3.12-slim-bookworm

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV PYTHONUNBUFFERED=1
ENV PIP_PREFER_BINARY=1

# نصب وابستگی‌های سیستمی مورد نیاز Odoo
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    python3-dev \
    libxml2-dev \
    libxslt1-dev \
    libldap2-dev \
    libsasl2-dev \
    libjpeg-dev \
    zlib1g-dev \
    libpq-dev \
    postgresql-client \
    wkhtmltopdf \
    curl \
    git \
    libffi-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/odoo

COPY requirements.txt .
RUN pip install --upgrade pip setuptools wheel \
    && pip install --no-cache-dir -r requirements.txt

COPY odoo odoo
COPY odoo-bin .


  
# دسترسی اجرای فایل odoo-bin
RUN chmod +x odoo-bin

EXPOSE 8069

CMD ["python3", "odoo-bin"]
