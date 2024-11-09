# Using docker as an Ansible controller

## Build
```bash
docker build -t ansible-controller .
```

## Run
```bash
docker run -v ./hosts:/etc/ansible/hosts -v /home/username/Repos/infrastructure/Ansible:/ansible/playbooks ansible-controller /ansible/playbooks/check-python.yml 
```
