# devsecops-class-amazon-linux2-ami
Step to deploy

1. Make sure packer is installed
2. Make sure connectivity established from your local to AWS ( aws sts get-caller-identity)

to build

1. packer version
2. packer validate -var-file=packer-vars.json ubuntu-hardened.json
3. packer build -var-file=packer-vars.json ubuntu-hardened.json
4. packer validate -var-file=packer-vars.json ubuntu-hardened.json
5. packer build -debug


