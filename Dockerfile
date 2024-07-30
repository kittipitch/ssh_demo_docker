FROM alpine:3.17

# Install OpenSSH server and other necessary packages
RUN apk update && \
    apk add --no-cache openssh-server bash

# Create the SSH directory and configure the SSH daemon
RUN mkdir /var/run/sshd

# Generate SSH host keys
RUN ssh-keygen -A

# Set a password for the root user
RUN echo 'root:password' | chpasswd

# Create a new user with a password
RUN adduser -D user && \
    echo 'user:1234ssh' | chpasswd

# Expose port 22 for SSH
EXPOSE 22

# Start SSH server
CMD ["/usr/sbin/sshd", "-D"]

