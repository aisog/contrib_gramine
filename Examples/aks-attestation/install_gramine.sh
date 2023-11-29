sudo curl -fsSLo /usr/share/keyrings/gramine-keyring.gpg https://packages.gramineproject.io/gramine-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/gramine-keyring.gpg] https://packages.gramineproject.io/ $(lsb_release -sc) main" \
| sudo tee /etc/apt/sources.list.d/gramine.list

sudo curl -fsSLo /usr/share/keyrings/intel-sgx-deb.asc https://download.01.org/intel-sgx/sgx_repo/ubuntu/intel-sgx-deb.key
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/intel-sgx-deb.asc] https://download.01.org/intel-sgx/sgx_repo/ubuntu $(lsb_release -sc) main" \
| sudo tee /etc/apt/sources.list.d/intel-sgx.list

sudo apt-get update
sudo apt-get install gramine

sudo apt-get update
sudo apt-get install gramine # for out-of-tree DCAP driver (required by AKS Ubuntu 18.04 distro) current 1.4

#sudo apt-get install libsgx-dcap-quote-verify-dev

######### dependences
sudo apt-get install -y build-essential \
    autoconf bison gawk nasm ninja-build pkg-config python3 python3-click \
    python3-jinja2 python3-pip python3-pyelftools wget
sudo python3 -m pip install 'meson<=1.0.0' 'tomli>=1.1.0' 'tomli-w>=0.4.0'

##require pip3 install protobuf==3.20.3

gramine-sgx-gen-private-key

git clone --depth 1 https://github.com/gramineproject/gramine.git --branch v1.5

# Copy dummy server certificate with Common Name as "<AKS-DNS-NAME.*.cloudapp.azure.com>
cp -r ssl/* gramine/CI-Examples/ra-tls-secret-prov/ssl

