FROM python:2.7

EXPOSE {{VIRTUAL_PORT}}

WORKDIR /app

RUN pip install -r requirements.txt

COPY ./.deploy/harden.sh /usr/local/bin/harden.sh
RUN chmod 777 /usr/local/bin/harden.sh
RUN /usr/local/bin/harden.sh

USER user

COPY . .

ENTRYPOINT ["python"]

CMD ["{{PYTHON_INDEX_SCRIPT}}"]
