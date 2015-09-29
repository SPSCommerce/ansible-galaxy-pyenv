FROM ansible/ubuntu14.04-ansible:devel
MAINTAINER acyost@spscommerce.com
ADD . /tmp/playbook
WORKDIR /tmp/playbook
ENV ANSIBLE_FORCE_COLOR=true
ENV PYTHONUNBUFFERED=1
## run test
RUN ansible-playbook -i "[test] localhost," -c local test.yml -e "pyenv_owner=root pyenv_path=/usr/local/pyenv" &&\
    ansible-playbook -i "[test] localhost," -c local test.yml -e "pyenv_owner=root pyenv_path=/usr/local/pyenv" 2>/dev/null | grep -q 'changed=0.*failed=0' &&\
    (echo 'Idempotence test: \033[0;32mpass\033[0m' && exit 0) ||\
    (echo 'Idempotence test: \033[0;31mfail\033[0m' && exit 1) 
