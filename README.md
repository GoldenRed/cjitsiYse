# cjitsiYse
This repo contains the terraform script I use to run my own chat-server using the open source Jitsi application on AWS. I have defined my own Amazon Machine Image that has been properly set up using my specific information. I use my own sub-domain name, my own certificate request and an elastic IP address I have allocated previously.

Note that only the main.tf file and this README have been whitelisted. The other file contain sensitive information about my running applicaton. 

- [x] - Replace my previous manually created setup with one defined in Terraform code.
- [x] - Add a part for Global Accelerator that I can comment/uncomment, for when I want the best internet speeds.
