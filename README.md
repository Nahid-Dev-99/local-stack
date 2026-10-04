# LocalStack AWS Infrastructure Environment

This repository provides a fully offline, cost-free development environment for testing and provisioning AWS infrastructure using HashiCorp Terraform and LocalStack. By leveraging Docker to emulate cloud services locally, this setup allows for safe experimentation and module development without requiring active AWS IAM credentials or incurring cloud billing charges.

📂 Repository Contents

docker-compose.yml: Configures the LocalStack emulator container (version 2.3.2). It maps the primary gateway to port 4566, mounts the local Docker socket to support sub-containers, and utilizes lazy loading to efficiently spin up mock AWS services only when requested by Terraform.   

main.tf: The primary Terraform configuration file. It is explicitly configured to bypass live AWS Security Token Service (STS) validation by using mock credentials (access_key = "test", secret_key = "test") and setting skip_credentials_validation = true. All API requests (such as creating mock EC2 instances with ami = "ami-test") are rerouted directly to the local http://localhost:4566 endpoint instead of reaching out to the live AWS internet servers.   

makefile: A command-line automation script containing predefined targets to streamline LocalStack operations. It abstracts verbose Docker commands into simple shortcuts, such as make up to deploy the container in detached mode and make logs to stream real-time output.  

.gitignore: Prevents local state files, Terraform caches (.terraform/), and sensitive variables from being accidentally tracked and pushed to version control.   

⚙️ Prerequisites

To deploy this local environment, ensure the following tools are installed on your local machine

Docker: To host the LocalStack emulator.
Terraform CLI: To execute the Infrastructure as Code (IaC) configuration.
Make file: To execute the Makefile shortcut targets.

🚀Getting Started 

Follow these steps to provision the mock infrastructure locally.
1. Start the Local Cloud EmulatorUse the provided Makefile shortcut to spin up the LocalStack Docker container in the background.Bash[make up]command 
(Optional: You can view the live LocalStack boot logs by running [make logs]. To safely detach from the log stream, press Ctrl + C.)

2. Initialise Terraform Prepare your working directory by downloading the necessary AWS provider plugins. Do not configure an S3 backend for this step; allow Terraform to default to local state tracking. Bash [terraform init]

3. Deploy the Mock Infrastructure Execute the Terraform configuration. Because main.tf successfully reroutes traffic, this step provisions the mock resources entirely offline. Bash [terraform apply]

4. Teardown Once you are finished testing your logic, cleanly destroy the mock Terraform resources and shut down the LocalStack container.Bash [terraform destroy]
docker-compose down
