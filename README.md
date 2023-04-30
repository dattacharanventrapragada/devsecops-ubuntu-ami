# devsecops-class-ubuntu-ami

Step to deploy

Make sure packer is installed
Make sure connectivity established from your local to AWS ( aws sts get-caller-identity)
to build

packer version
packer validate ubuntu-hardened.json
packer build ubuntu-hardened.json
packer validate -var-file=packer-vars.json ubuntu-hardened.json
packer build -debug
