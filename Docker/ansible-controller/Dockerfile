# Use an up-to-date base image
FROM python:3.11-slim-bullseye

# Install required system packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    sshpass \
    git \
    openssh-client \
    libffi-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip and install Ansible and the community.general collection
RUN pip install --upgrade pip && \
    pip install ansible==8.1.0 && \
    ansible-galaxy collection install community.general

# Remove build dependencies to reduce image size
RUN apt-get remove -y build-essential libffi-dev libssl-dev && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# Set up Ansible environment variables
ENV ANSIBLE_GATHERING=smart \
    ANSIBLE_HOST_KEY_CHECKING=false \
    ANSIBLE_RETRY_FILES_ENABLED=false \
    ANSIBLE_SSH_PIPELINING=true

# Create Ansible directories and add a default hosts file
RUN mkdir -p /etc/ansible /ansible/playbooks && \
    echo -e "[local]\nlocalhost" > /etc/ansible/hosts

# Set the working directory
WORKDIR /ansible/playbooks

# Provide an easy way to override the hosts file
VOLUME ["/etc/ansible/hosts"]

# Set the entry point to ansible-playbook
ENTRYPOINT ["ansible-playbook"]
