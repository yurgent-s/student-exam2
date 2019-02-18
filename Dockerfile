FROM centos:7

RUN yum update -y && \
    mkdir /epam_app && \
# Install python
    yum install epel-release -y && \
    yum --disablerepo="*" --enablerepo="epel" install python34 -y && \
    curl -O https://bootstrap.pypa.io/get-pip.py && \
    /usr/bin/python3.4 get-pip.py &&\
    python3 --version

COPY . /usr/local/epam

WORKDIR /usr/local/epam

ENV LC_ALL en_US.utf-8
ENV LANG en_US.utf-8
ENV FLASK_APP js_example

RUN pip install -e .

CMD [ "flask", "run", "--host=0.0.0.0"]
