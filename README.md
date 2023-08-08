 
# Liquid Art AI

The LiquidArt AI is a mobile application developed in Flutter that allows users to generate images using a text or an audio to text prompt and a selection of  APIs (NightCafe, a local server of Stable Diffusion, AI Art Maker, Dall-e), a multi-screen system for displaying geographic information. The application uses a Node js server to connect to the Liquid Galaxy system and a custom API  to display the images on the screens. The project also includes a new local machine for the LG project that has a GPU and the ability to create AI art based on stable diffusion.
<p align="center">
<img src="./assets/logo/Logo.png" width="70%">
</p>

## Before Running
1. Make sure the Liquid Galaxy core is installed, more info about the installation can be found on this [repository](https://github.com/LiquidGalaxyLAB/liquid-galaxy)
2. Make sure **The latest Docker version** is installed on the machine that you want to start the server by running:
```bash
docker --version
```
3. The output should look someting like `v24.0.2`, if this is not the case use the following link for tips on how to install it:
[How To Install Docker on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)
4. After Docker is installed, clone the following repository on the same machine in a directory that you want. Run command:
```bash
git clone https://github.com/MurilonND/stable-diffusion-webui-docker.git
```
5. Make sure Chromium Browser is installed on all machines. if this is not the case use the following link for tips on how to install it:
[How To Install Chromium Browser on Ubuntu](https://linuxize.com/post/how-to-install-chromium-web-browser-on-ubuntu-20-04/)
6. Create an API Key for each API that you what to use
[How To create your own API Key for Dall-E](https://platform.openai.com/docs/api-reference/authentication)

## Running Project For The Liquid Galaxy
1. Firstly, download the latest APK for Liquid Art AI and install it on the device that you want to use.
2. Inside the App, go for the API Key page so you can save you API Key.
3. Now, go back to the machine with the docker and inside the folder that you clone docker run the command (this may take some time):
```bash
docker compose --profile download up --build
```
4. Once the comand is finished run the docker container with the command:
```bash
docker compose --profile auto up --build
```
5. After that command finish the docker file should be runnig on the machine.

## Connecting Players To The Game On LG
Once the screens are open, you can open the app on the Connection Page and connect with the galaxy, once that is done, and the API Key is configurated you can go to the drawer and chose one to run (The Stable Diffusion is the local Docker, will take a good amout of time depending on the machine). Once you have your image, save it and go to the Gallery page, ther you can select it and open it on Liquid Galaxy (Small images and images genereted with API that dont suport the Liquid Galaxy format will get distorted or get low resolutions)

## License

This software is under the [MIT License](https://en.wikipedia.org/wiki/MIT_License)

Copyright 2023 [Murilo Nogueira Duarte](https://www.linkedin.com/in/murilo-nogueira-4ab34421b/)