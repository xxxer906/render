FROM alpine:latest

# Install necessary packages
RUN apk update && apk add --no-cache \
    openssh \
    xfce4 \
    xfce4-terminal \
    xrdp \
    sudo

# Setup SSH server
RUN mkdir /var/run/sshd
RUN echo 'root:rootpassword' | chpasswd # Change root password
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Setup XRDP
RUN adduser xrdp
RUN echo "xrdp:xrdppassword" | chpasswd # Change xrdp password
RUN echo "xrdp ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Expose SSH port
EXPOSE 2222

CMD ["/usr/sbin/sshd", "-D"]
