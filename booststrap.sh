sudo apt-get purge liblog4cplus-dev

sudo rm -r log4cplus
git clone https://github.com/log4cplus/log4cplus.git --recurse-submodules
sudo ./configure --enable-debugging
sudo make 
sudo make install
sudo ldconfig
