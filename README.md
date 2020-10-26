# CybersecurityProject-
Joe Stones Cybersecurity Project 1
## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

[https://github.com/gisailor/CybersecurityProject-/blob/main/Joe%20Stones%20Projec%201%20Cloud%20Security%20(2).png](Images/diagram)

These files have been tested and used to generate a live ELK deployment on Azure and DVWA Web servers behind a load balancer. They can be used to recreate the entire deployment pictured above. Alternatively, select portions of the config files and yaml files may be used to install only certain pieces of it, such as Filebeat.

Link to DWVA play book: https://github.com/gisailor/CybersecurityProject-/blob/main/DVWA%20YAML
  
Link to Ansible configuration file:   
 https://github.com/gisailor/CybersecurityProject-/blob/main/AnsibleConfigFile.txt
  
  - Webservice configuration file changes
       [webservers]
        10.0.0.5 ansible_python_interpreter=/usr/bin/python3
	10.0.0.6 ansible_python_interpreter=/usr/bin/python3
	10.0.0.8 ansible_python_interpreter=/usr/bin/python3

	# default user to use for playbooks if user is not specified
    	# (/usr/bin/ansible will use current user as default)
    	remote_user = sysadmin

  - Filebeat Playbook Link: https://github.com/gisailor/CybersecurityProject-/blob/main/Filebeat_playbook.txt

 
  - Filebeat configuration file changes down loaded with curl command: curl https://gist.githubusercontent.com/slape/5cc350109583af6cbe577bbcc0710c93/raw/eca603b72586fbe148c11f9c87bf96a63cb25760/Filebeat > filebeat-config.yml
   line #1106 and replace the IP address with the IP address of ELK machine.
   output.elasticsearch:
   hosts: ["10.1.0.4:9200"]
   username: "elastic"
   password: "changeme"
  
   line #1806 replaced the IP address with the IP address of ELK machine.
   setup.kibana:
   host: "10.1.0.4:5601"
   
   Link to Filebeat configuration file https://github.com/gisailor/CybersecurityProject-/blob/main/FilebeatConfiguration%20File.txt 



  - Metricbeat Playbook used to install Metricbeat monitoring utility on ELK stack server 
    Link: https://github.com/gisailor/CybersecurityProject-/blob/main/Metricbeat_playbook.txt

  - Metricbeat configuration yaml link : https://github.com/gisailor/CybersecurityProject-/blob/main/Metricbeat_configfile.txt

  - Metricbeat configuration file changes:
    starting on line 61
    setup.kibana:
    host: "10.1.0.4:5601" 

    Starting on line 96
    hosts: ["10.1.0.4:9200"]
    username: "elastic"
    password: "changeme"



This document contains the following details:
- Description of the Topologu
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly scalable, in addition to restricting access to the network.
The Load Balancer off-loading function protects the system against denial-of-service (DDoS) attacks provides redundancy if servers go down or there is a high volume of traffic. 
This is accomplished by shifting traffic across several VMs. The system also has a jump box  that functions like a proxy server for the system. It provides isolated access to a private network internl network. 
The jumpbox is only accessible to computers on the internal network. The jump box is configured to allow access to internal VMs. 

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the system logs, file logs etc. and system traffic.
The installed filebeat kibana utlity allows you to set up monitoring on select files and system componets and monitors selected activities in each log.  
Metricbeat monitors and reports system operations metrics for services running on selected servers. 


The configuration details of each machine may be found below.
| Name     | Function | internal IP Address | Operating System     |
|----------|----------|---------------------|----------------------|
| Jump Box | Gateway  | 10.0.0.1            | Linux / ubuntu 18.04 |
| Web 1    | Webserver| 10.0.0.5            | Linux / ubuntu 18.04 |
| Web 2    | Webserver| 10.0.0.6            | Linux / ubuntu 18.04 | 
| Web 3    | Webserver| 10.0.0.8            | Linux / ubuntu 18.04 |
| ElkStack | Elkserver| 10.1.0.4            | Linux / ubuntu 18.04 |
                  |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jumpbox machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:74.174.37.230 
(Non static host machine IP address must be verified prior to each connection attempt.)


Machines within the network can only be accessed by the jump box VM.
The jump box also has access to the ELKstack VM via the interal ip 10.1.0.4 

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box |     No              | 74.174.37.230        |
| Web-1    |     No              | 10.0.0.5             |
| Web-2    |     No              | 10.0.0.6             |
| Web-1    |     No              | 10.0.0.8             |
| ELKStack |     No              | 10.1.0.4             |


### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because it is repeatable and
configurable. This method supports rapid upgrades and deployments on multiple servers. 

The playbook implements the following tasks:
- Installs Docker
- Installs python3
- Downloads and installs current kibana filebeats software
- Downloads and installs current kibana metricbeat software- 
- 

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

[ https://github.com/gisailor/CybersecurityProject-/blob/main/Docker_PS_Output.png](Images/docker_ps_output.png)


### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web-1 : 10.0.0.5
- Web-2 : 10.0.0.6
- Web-3 : 10.0.0.8

We have installed the following Beats on these machines:
- Filebeats 7.4.0
- Metricbeat 7.6.1

These Beats allow us to collect the following information from each machine:
- Filebeat monitors selected system log files for changes and selected message severity levels. Metricbeats monitors system performance and provides alerts when 
  Services have issues. For example, when a servers CPU is running at capacity or the RAM is being fully utilized.  

Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the anible.cfg  file to etc/ansible.
- Update the config file to include Host IP of server that contains the ELK stack and the config file for the webservers with all the web server IPs requiring configuration / deployment of Filebeat and Metirc beat.
- Run the playbook, and navigate to the ELK stack / Kibana server to check that the installation worked as expected.

Additional steps required to to run system monitoring utlities:
    Copy the install-elk.yml, filebeat-playbook.yml and files to /etc/ansible/host.
    Update the install-elk.yml and filebeat-playbook.yml file to include the machine you want use the playbooks on by changing the hosts name on the 3rd line.
    Run the playbook, then use a web browser to navigate to http://[ELKStack IP]:5601/app/kibana to verify the installation is working as expected.

Commands users will need to run and download yaml play books and update files etc. 

sudo docker container list -a
sudo docker start <container name>
sudo docker ps 
sudo docker attach <container name>
sudo docker run -ti <container name>
sudo apt update
sudo apt upgrade
sudo docker pull
sudo docker install  docker.o hub.docker.com
ansible-playbook <playbook name>
