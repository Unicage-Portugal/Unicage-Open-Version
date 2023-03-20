# Unicage-Open-Version
Unicage is a set of highly efficient commands that allow the user to build robust, yet flexible systems in a modular way through data processing pipelines. Unicage follows the Unix philosophy, a set of concepts and guidelines that focus on designing small but highly efficient programs and operating systems.

Unicage Open Version is a set of 85 Unicage commands that are freely distributed and that can be easily installed on any machine with a Linux environment. Contrarily to the ones distributed through Unicage Enterprise Version, these commands are written in Python, therefore, they are not able to achieve the same performance levels as the ones from the Unicage Enterprise Version, and they might present certain limitations in terms of execution. 
For the full Enterprise version of Unicage commands, please contact: info@unicage.com

If you want to know more about Unicage, our methodology and technology, please visit our website at https://unicage.eu/ or feel free contact us through info@unicage.com


## Install
To install the Unicage Open Version commands, you just need to follow the following steps: 
1)	Download or clone this repository 
2)	Go to the repository and type sudo make install in your terminal.
This will install the Unicage commands in the default path /usr/local/bin.
After the previous steps are executed, you can now use the Unicage commands by simply using the command line or through Shell scripts. 


## Test
To check if the installation was successful, you can execute the following command: sudo make test 
This command will execute a series of scripts that will check if the Unicage commands were installed correctly in your system. Please note that these tests might take a while to finish. 


## Uninstall
If you want to remove the Unicage Open Version from your computer, just go to the directory containing the data you downloaded from the GitHub repository, open your terminal and type: sudo make uninstall The commands should now be removed from your system.


## Requirements
To install and execute Unicage Open Version commands, you just need a Linux Operating System and Python 2.4 or above. 
