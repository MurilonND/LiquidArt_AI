 
# Liquid Art AI

The LiquidArt AI is a mobile application developed in Flutter that allows users to generate images using a text or an audio to text prompt and a selection of  APIs:
- Dall-E
- Local Server of Stable Diffusion
- Realistic Vision
- Stable Diffusion
- OpenJourney
- 

The application uses a Dart server to connect to the Liquid Galaxy system to display the images on the screens. The project also includes a new local machine for the LG project that has a GPU and the ability to create AI art based on stable diffusion.
<p align="center">
<img src="./assets/logo/Logo.png" width="70%">
</p>

## Before Running
1. Make sure the Liquid Galaxy core is installed, more info about the installation can be found on this [repository](https://github.com/LiquidGalaxyLAB/liquid-galaxy)
2. Make sure Chromium Browser is installed in all liquid galaxys. if this is not the case use the following link for tips on how to install it:
[How To Install Chromium Browser on Ubuntu](https://linuxize.com/post/how-to-install-chromium-web-browser-on-ubuntu-20-04/)

## Docker Setup
1. Make sure that the machine that will run the docker have an NVidia GPU and at least 12 RAM.
2. Make sure that the machine has the [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) install.
3. Make sure **The latest Docker version** is installed on the machine that you want to start the server by running:
```bash
docker --version
```
4. The output should look someting like `v24.0.2`, if this is not the case use the following link for tips on how to install it:
[How To Install Docker on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)
5. After Docker is installed and in the right version, clone the following repository on the same machine in a directory that you want. Run command:
```bash
git clone https://github.com/MurilonND/stable-diffusion-webui-docker.git
```
6. Now, go to the folder of the project and run the command (this will take time):
```bash
sudo docker compose --profile download up --build
```
7. Once the comand is finished run the docker container with the command (this will take time in the first run):
```bash
sudo docker compose --profile auto up --build
```
8. After that command finish the docker file should be runnig on the machine, now get the machine ipv4 of the same network that your app is connected to use it on the app:
```bash
ifconfig
```

## Running Project
1. Firstly, download the latest APK for Liquid Art AI and install it on the device that you want to use.
2. Get the API Keys that are use in the project:
- [Dall-E](https://platform.openai.com/docs/api-reference/authentication)
- [Leap](https://docs.tryleap.ai/authentication)
3. Inside the App, go for the services key and IA server configuration page so you can save your APIs Keys, the IP Adress and port that the Docker is runnig.


## Connecting App To The Liquid Galaxy
Once the screens are open, you can open the app on the Connection Page and connect with the galaxy, once that is done, and the API Key is configurated you can go to the drawer and chose one to run (The Stable Diffusion is the local Docker, will take a good amout of time depending on the machine). Once you have your image, save it and go to the Gallery page, ther you can select it and open it on Liquid Galaxy (Small images and images genereted with API that dont suport the Liquid Galaxy format will get distorted or get low resolutions)

## License

This software is under the [MIT License](https://en.wikipedia.org/wiki/MIT_License)

Copyright 2023 [Murilo Nogueira Duarte](https://www.linkedin.com/in/murilo-nogueira-4ab34421b/)