FROM alpine:3.17

# Install OpenSSH server, rsync, and other necessary packages
RUN apk update && \
    apk add --no-cache openssh-server openssh-sftp-server rsync bash

# Create the SSH directory and configure the SSH daemon
RUN mkdir /var/run/sshd

# Generate SSH host keys
RUN ssh-keygen -A

# Configure SSH for SFTP
RUN echo "Subsystem sftp /usr/lib/ssh/sftp-server" >> /etc/ssh/sshd_config

# Set a password for the root user
RUN echo 'root:password' | chpasswd

# Create a new user with a password and home directory
RUN adduser -D user && \
    echo 'user:1234ssh' | chpasswd && \
    mkdir -p /home/user/uploads /home/user/downloads && \
    chown -R user:user /home/user

# Create some sample files for demo purposes
RUN echo "Sample file for SFTP/rsync demo" > /home/user/sample.txt && \
    echo "Another test file" > /home/user/test.txt && \
    chown user:user /home/user/*.txt

# Expose port 22 for SSH/SFTP
EXPOSE 22

# Start SSH server
CMD ["/usr/sbin/sshd", "-D"]