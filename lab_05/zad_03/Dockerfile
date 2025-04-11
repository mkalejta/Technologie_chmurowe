ARG PYTHON_VERSION=latest
FROM python:${PYTHON_VERSION}
WORKDIR /myapp
COPY myapp/ ./
RUN if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi
CMD ["python", "app.py"]