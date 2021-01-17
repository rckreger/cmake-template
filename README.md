This is a template project that creates a shared object and an executable that both 
use extenal libraries.

The external libriaries are ACE, Boost, and Log4cplus.  This code has been tested
on Windows 10 64bit, and Ubuntu 64bit.

Windows vcpkg must be boost strapped.  The vcpkg.json file will do the rest
Linux vcpkg must be boot strapped.  The vcpkg.json file will do the rest.

Openssl need this next item to be installed to build correctly on linux.
sudo apt-get install pkg-config
Linux Setup Instructions
cd ~
git clone https://github.com/microsoft/vcpkg.git
vcpkg install log4cplus ace curl

cmake -DCMAKE_TOOLCHAIN_FILE=vcpkg/scripts/buildsystems/vcpkg.cmake so that find_package() will work.
\vcpkg\installed\x64-linux\include
\vcpkg\installed\x64-linux\lib

.Help for this is located here https://devblogs.microsoft.com/cppblog/announcing-a-single-c-library-manager-for-linux-macos-and-windows-vcpkg/#:~:text=%20Getting%20started:%20%201%20Clone%20the%20vcpkg,install...%204%20Using%20the%20generated%20library%20More

Use exploer.exe . in wsl to view with explorer


PDDLibrary 10.0 Developement
Windows
Requires Visaul Studio 2019
   MSVC v142 - VS 2019 C++ x64/x86 build tools (v14.20)
   Windows 10 SDK (10.0.18362.0)
Linux
   Dockerfile to create linux image to compile on
       # https://devblogs.microsoft.com/cppblog/build-c-applications-in-a-linux-docker-container-with-visual-studio/
      FROM ubuntu

      LABEL description="Container for use with Visual Studio"

      # install build dependencies
      RUN apt-get update && apt-get install -y g++ rsync zip openssh-server make 
      RUN apt-get -y upgrade 
      RUN apt-get install -y libace-dev liblog4cplus-dev libboost-all-dev git
      #Get the runtime files
      #apt-get install libace-6.4.5
      #Get the headers and libs
      #RUN apt-get install libace-dev 
      #RUN apt-get install liblog4cplus-1.1-9
      #RUN apt-get install libboost-all-dev

      #RUN apt-get install automake
      #RUN apt-get install git

      # configure SSH for communication with Visual Studio
      RUN mkdir -p /var/run/sshd

      RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config && \
         ssh-keygen -A

      # expose port 22
      EXPOSE 22

   To build the container
      docker build -t ubuntu-vs .

   To run the container it it exists in a docker repository
      docker run -p 5000:22 -i -t ubuntu-vs /bin/bash

   The VM will start and then you need to run the followign commands to enabled debugging.
      service ssh start
      useradd -m -d /home/<username> -s /bin/bash -G sudo <username>
      passwd <username>

   In Visual Studio you need to enable remote debugging.
      Now you are ready to connect the Linux visual studio project to this running docker container to develope against it.


dpkg -L liblog4cplus-dev lists all files belonging to a package package_name