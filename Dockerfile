FROM ansible/ubuntu14.04-ansible:devel
MAINTAINER acyost@spscommerce.com
ADD . /tmp/playbook
WORKDIR /tmp/playbook
ENV ANSIBLE_FORCE_COLOR=true
ENV PYTHONUNBUFFERED=1
RUN ansible-playbook -i "localhost," -c local test.yml -e "pyenv_owner=root"
RUN ansible-playbook -i "localhost," -c local test.yml -e "pyenv_owner=root" \
    | grep -q 'changed=0.*failed=0' \
    && (echo 'Idempotence test: pass' && exit 0) \
    || (echo 'Idempotence test: fail' && exit 1)
